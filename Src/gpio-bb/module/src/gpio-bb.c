/*
 * Copyright (C) 2005-2014 Darron Broad
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * 3. Neither the name `Darron Broad' nor the names of any contributors
 *    may be used to endorse or promote products derived from this
 *    software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#include <linux/module.h>
#include <linux/fs.h>
#include <linux/gpio.h>
#include <linux/uaccess.h>
#include <linux/cdev.h>

#include "gpio-bb.h"

static struct cdev cdev;
static DEFINE_SPINLOCK(gpio_bb_lock);
static uint8_t pins[GPIO_BB_MAX] = {0}, dirs[GPIO_BB_MAX] = {0};
static struct gpio_bb_config config = {0};

static int gpio_bb_io(uint8_t dir, uint8_t pin, uint8_t *bit)
{
	int err = 0;

	if (pins[pin]) {
		if (dir == 0) {
			if (dirs[pin] == 1) {
				gpio_direction_output(pin, *bit);
				dirs[pin] = 0;
			} else {
				gpio_set_value(pin, *bit);
			}
		} else if (dir == 1) {
			if (dirs[pin] == 0) {
				gpio_direction_input(pin);
				dirs[pin] = 1;
			}
			*bit = gpio_get_value(pin) ? 1 : 0;
		} else {
			return -EINVAL;
		}
		return 0;
	}
	if (dir == 0) {
		if (*bit == 0) {
			err = gpio_request_one(pin, GPIOF_OUT_INIT_LOW, "gpio-bb");
		} else {
			err = gpio_request_one(pin, GPIOF_OUT_INIT_HIGH, "gpio-bb");
		}
		if (err) {
			printk("gpio-bb: pin %d is currently unavailable.\n", pin);
			return err;
		}
		dirs[pin] = 0;
	} else if (dir == 1) {
		err = gpio_request_one(pin, GPIOF_IN, "gpio-bb");
		if (err) {
			printk("gpio-bb: pin %d is currently unavailable.\n", pin);
			return err;
		}
		dirs[pin] = 1;
		*bit = gpio_get_value(pin) ? 1 : 0;
	} else {
		return -EINVAL;
	}
	pins[pin] = 1;

	return err;
}

static inline void gpio_bb_delay(uint8_t delay)
{

	while (delay--)
		gpio_get_value(config.data_pin_input);
}

static inline void gpio_bb_clock(void)
{

	gpio_set_value(config.clock_pin, 1);
	gpio_bb_delay(config.clock_delay_high);

	gpio_set_value(config.clock_pin, 0);
	gpio_bb_delay(config.clock_delay_low);
}

static int gpio_bb_shift_out(uint64_t bits, uint8_t nbits)
{
	int err = 0;
	uint64_t mask = 1 << 1;
	uint8_t bit = bits & 1;
	unsigned long flags = 0;

	if (config.lock)
		spin_lock_irqsave(&gpio_bb_lock, flags);

	err = gpio_bb_io(0, config.data_pin_output, &bit);
	if (err)
		goto error;
	gpio_bb_clock();

	while (--nbits) {
		gpio_set_value(config.data_pin_output, (bits & mask) != 0);
		gpio_bb_clock();
		mask <<= 1;
	}
error:
	if (config.lock)
		spin_unlock_irqrestore(&gpio_bb_lock, flags);

	return err;
}

static int gpio_bb_shift_in_falling(uint64_t *bits, uint8_t nbits)
{
	int err = 0;
	uint64_t mask = 1 << 1;
	uint8_t bit;
	unsigned long flags = 0;

	*bits = 0;

	if (config.lock)
		spin_lock_irqsave(&gpio_bb_lock, flags);

	err = gpio_bb_io(1, config.data_pin_input, &bit);
	if (err)
		goto error;
	*bits |= bit;
	gpio_bb_clock();

	while (--nbits) {
		if (gpio_get_value(config.data_pin_input))
			*bits |= mask;
		gpio_bb_clock();
		mask <<= 1;
	}
error:
	if (config.lock)
		spin_unlock_irqrestore(&gpio_bb_lock, flags);

	return err;
}

static int gpio_bb_shift_in_rising(uint64_t *bits, uint8_t nbits)
{
	int err = 0;
	uint64_t mask = 1 << 1;
	uint8_t bit;
	unsigned long flags = 0;

	*bits = 0;

	if (config.lock)
		spin_lock_irqsave(&gpio_bb_lock, flags);

	gpio_bb_clock();
	err = gpio_bb_io(1, config.data_pin_input, &bit);
	if (err)
		goto error;
	*bits |= bit;

	while (--nbits) {
		gpio_bb_clock();
		if (gpio_get_value(config.data_pin_input))
			*bits |= mask;
		mask <<= 1;
	}
error:
	if (config.lock)
		spin_unlock_irqrestore(&gpio_bb_lock, flags);

	return err;
}

static long gpio_bb_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
{
	int err = 0;

	if (_IOC_TYPE(cmd) != GPIO_BB_MAJOR) {
		return -EINVAL;
	}
	if (_IOC_DIR(cmd) & _IOC_READ) {
		if (!access_ok(VERIFY_WRITE, arg, _IOC_SIZE(cmd))) {
			return -EFAULT;
		}
	}
	if (_IOC_DIR(cmd) & _IOC_WRITE) {
		if (!access_ok(VERIFY_READ, arg, _IOC_SIZE(cmd))) {
			return -EFAULT;
		}
	}
	switch (cmd) {
	case GPIO_BB_IO:
		{
		struct gpio_bb_io io;

		if (copy_from_user(&io, (struct gpio_bb_io *)arg, sizeof(io)) != 0)
			return -EFAULT;
		else {
			err = gpio_bb_io(io.dir, io.pin, &io.bit);
			if (err)
				return err;
			if (copy_to_user((struct gpio_bb_io *)arg, &io, sizeof(io)) != 0)
				return -EFAULT;
		}
		}
		break;
	case GPIO_BB_CONFIGURE:
		{
		if (copy_from_user(&config, (struct gpio_bb_config *)arg, sizeof(config)) != 0)
			return -EFAULT;
		else {
			uint8_t low = 0;

			err = gpio_bb_io(0, config.clock_pin, &low);
			if (err)
				return err;
		}
		}
		break;
	case GPIO_BB_SHIFT:
		{
		struct gpio_bb_shift shift;

		if (copy_from_user(&shift, (struct gpio_bb_shift *)arg, sizeof(shift)) != 0)
			return -EFAULT;
		else {
			if (shift.dir == 0) {
				err = gpio_bb_shift_out(shift.bits, shift.nbits);
				if (err)
					return err;
			} else if (shift.dir == 1) {
				if (config.clock_falling) {
					err = gpio_bb_shift_in_falling(&shift.bits, shift.nbits);
				} else {
					err = gpio_bb_shift_in_rising(&shift.bits, shift.nbits);
				}
				if (err)
					return err;
				if (copy_to_user((struct gpio_bb_shift *)arg, &shift, sizeof(shift)) != 0)
					return -EFAULT;
			} else {
				return -EINVAL;
			}
		}
		}
		break;
	}
	return 0;
}

struct file_operations gpio_bb_fops = {
	.owner		= THIS_MODULE,
	.unlocked_ioctl = gpio_bb_ioctl,
};

static int __init gpio_bb_init(void)
{

	cdev_init(&cdev, &gpio_bb_fops);
	cdev.owner = THIS_MODULE;
	return cdev_add(&cdev, MKDEV(GPIO_BB_MAJOR, 0), 1);
}

static void gpio_bb_exit(void)
{
	uint16_t i;

	for (i = 0; i < GPIO_BB_MAX; ++i) {
		if (pins[i])
			gpio_free(i);
	}
	cdev_del(&cdev);
}

module_init(gpio_bb_init);
module_exit(gpio_bb_exit);
MODULE_DESCRIPTION("gpio bit-bang driver");
MODULE_AUTHOR("Darron Broad <darron@kewl.org>");
MODULE_LICENSE("GPL");
