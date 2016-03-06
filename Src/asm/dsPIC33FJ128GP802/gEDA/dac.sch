v 20110115 2
C 40000 40000 0 0 0 title-B.sym
C 45600 43700 1 0 0 dsPIC33FJ128GP802.sym
{
T 48400 49900 5 10 1 1 0 6 1
refdes=U1
T 46000 50100 5 10 0 0 0 0 1
device=dsPIC33FJ128GP802
T 46000 50300 5 10 0 0 0 0 1
footprint=SPDIP28
}
C 44200 49700 1 0 0 resistor-2.sym
{
T 44600 50050 5 10 0 0 0 0 1
device=RESISTOR
T 44500 50000 5 10 1 1 0 0 1
refdes=10K
}
C 44200 48100 1 0 0 resistor-2.sym
{
T 44600 48450 5 10 0 0 0 0 1
device=RESISTOR
T 45000 48300 5 10 1 1 0 0 1
refdes=470R
}
C 44200 47700 1 0 0 resistor-2.sym
{
T 44600 48050 5 10 0 0 0 0 1
device=RESISTOR
T 45000 47900 5 10 1 1 0 0 1
refdes=470R
}
C 44200 49300 1 0 0 resistor-2.sym
{
T 44600 49650 5 10 0 0 0 0 1
device=RESISTOR
T 44400 49100 5 10 1 1 0 0 1
refdes=470R
}
C 44200 41000 1 90 0 resistor-2.sym
{
T 43850 41400 5 10 0 0 90 0 1
device=RESISTOR
T 43900 41200 5 10 1 1 90 0 1
refdes=470R
}
C 48900 49200 1 0 0 capacitor-1.sym
{
T 49100 49900 5 10 0 0 0 0 1
device=CAPACITOR
T 49100 49700 5 10 1 1 0 0 1
refdes=100n
T 49100 50100 5 10 0 0 0 0 1
symversion=0.1
}
C 45500 45200 1 90 0 capacitor-1.sym
{
T 44800 45400 5 10 0 0 90 0 1
device=CAPACITOR
T 45000 45300 5 10 1 1 90 0 1
refdes=100n
T 44600 45400 5 10 0 0 90 0 1
symversion=0.1
}
C 48900 46000 1 0 0 capacitor-3.sym
{
T 49100 46700 5 10 0 0 0 0 1
device=POLARIZED_CAPACITOR
T 49100 46500 5 10 1 1 0 0 1
refdes=10u E.S.R. 2R
T 49100 46900 5 10 0 0 0 0 1
symversion=0.1
}
C 44000 43400 1 270 0 led-2.sym
{
T 43800 43200 5 10 1 1 270 0 1
refdes=POWER
T 44600 43300 5 10 0 0 270 0 1
device=LED
}
N 48900 46200 48700 46200 4
N 48700 45800 49900 45800 4
N 49900 45800 49900 46200 4
N 48700 49000 49900 49000 4
N 49900 49000 49900 49400 4
N 48900 49400 48700 49400 4
N 44100 44600 45700 44600 4
N 49800 49400 49900 49400 4
C 49700 48700 1 0 0 ground.sym
N 49800 46200 49900 46200 4
C 49700 45500 1 0 0 ground.sym
N 45100 49400 45700 49400 4
N 45700 48200 45100 48200 4
N 45700 47800 45100 47800 4
N 44200 47800 41300 47800 4
N 44200 48200 41300 48200 4
N 44200 49400 41300 49400 4
N 45400 49400 45400 49800 4
N 45400 49800 45100 49800 4
N 44100 49800 44200 49800 4
T 40800 44400 9 15 1 0 90 0 1
Raspberry Pi
T 40500 49300 9 10 1 0 0 0 1
GPIO9
T 40500 47700 9 10 1 0 0 0 1
GPIO10
T 40500 48100 9 10 1 0 0 0 1
GPIO11
T 50000 40700 9 10 1 0 0 0 1
Audio DAC Function Generator
T 50000 40400 9 10 1 0 0 0 1
dac.sch
T 50000 40100 9 10 1 0 0 0 1
1
T 51500 40100 9 10 1 0 0 0 1
1
T 53900 40400 9 10 1 0 0 0 1
1.1
T 53900 40100 9 10 1 0 0 0 1
Dmb
T 40200 43300 9 10 1 0 0 0 1
5V
T 40200 40900 9 10 1 0 0 0 1
GND
N 44100 43400 44100 50200 4
N 44100 50200 53200 50200 4
N 48800 50200 48800 49400 4
C 41400 41700 1 90 0 capacitor-1.sym
{
T 40700 41900 5 10 0 0 90 0 1
device=CAPACITOR
T 41100 41800 5 10 1 1 90 0 1
refdes=1u
T 40500 41900 5 10 0 0 90 0 1
symversion=0.1
}
C 52600 48600 1 90 0 resistor-2.sym
{
T 52250 49000 5 10 0 0 90 0 1
device=RESISTOR
T 52800 48800 5 10 1 1 90 0 1
refdes=10K
}
N 52500 48600 52500 48200 4
N 52000 48200 52500 48200 4
C 52600 46900 1 0 0 resistor-2.sym
{
T 53000 47250 5 10 0 0 0 0 1
device=RESISTOR
T 52900 47200 5 10 1 1 0 0 1
refdes=10K
}
C 51100 47700 1 0 0 resistor-2.sym
{
T 51500 48050 5 10 0 0 0 0 1
device=RESISTOR
T 51400 47400 5 10 1 1 0 0 1
refdes=10K
}
C 51100 48100 1 0 0 resistor-2.sym
{
T 51500 48450 5 10 0 0 0 0 1
device=RESISTOR
T 51400 48400 5 10 1 1 0 0 1
refdes=10K
}
N 48700 48200 51100 48200 4
N 52000 47800 52500 47800 4
N 52500 46300 52500 47800 4
N 52500 47000 52600 47000 4
N 53500 47000 53600 47000 4
N 53600 46300 53600 48000 4
C 53900 47800 1 0 0 capacitor-2.sym
{
T 54100 48500 5 10 0 0 0 0 1
device=POLARIZED_CAPACITOR
T 54200 47600 5 10 1 1 0 0 1
refdes=100u
T 54100 48700 5 10 0 0 0 0 1
symversion=0.1
}
N 53500 48000 53900 48000 4
L 52700 48400 52700 47600 3 0 0 0 -1 -1
L 52700 48400 53300 48000 3 0 0 0 -1 -1
L 53300 48000 52700 47600 3 0 0 0 -1 -1
L 52800 48250 52800 48150 3 0 0 0 -1 -1
L 52750 48200 52850 48200 3 0 0 0 -1 -1
L 52750 47800 52850 47800 3 0 0 0 -1 -1
P 52500 48200 52700 48200 1 0 0
{
T 52650 48150 5 8 0 1 0 8 1
pinseq=1
T 52750 48200 9 8 0 1 0 0 1
pinlabel=in+
T 52750 48200 5 8 0 1 0 2 1
pintype=in
}
P 52500 47800 52700 47800 1 0 0
{
T 52650 47750 5 8 0 1 0 8 1
pinseq=2
T 52750 47800 9 8 0 1 0 0 1
pinlabel=in-
T 52750 47800 5 8 0 1 0 2 1
pintype=in
}
P 53300 48000 53500 48000 1 0 1
{
T 53300 47950 5 8 0 1 0 2 1
pinseq=5
T 53250 48000 9 8 0 1 0 6 1
pinlabel=out
T 53250 48000 5 8 0 1 0 8 1
pintype=out
}
T 58200 48900 5 10 0 0 0 0 1
device=OPAMP
T 58200 49300 5 10 0 0 0 0 1
description=operational amplifier
T 58200 49100 5 10 0 0 0 0 1
numslots=0
T 58200 49500 5 10 0 0 0 0 1
symversion=0.1
T 58200 47000 5 10 0 0 0 0 1
device=OPAMP
T 58200 47400 5 10 0 0 0 0 1
description=operational amplifier
T 58200 47200 5 10 0 0 0 0 1
numslots=0
T 58200 47600 5 10 0 0 0 0 1
symversion=0.1
N 54800 48000 55100 48000 4
C 55300 47200 1 0 0 ground.sym
N 51100 47800 49500 47800 4
C 52800 47500 1 0 0 ground.sym
N 53200 48100 53200 50200 4
T 52900 50300 9 10 1 0 0 0 1
3V3
C 55600 47500 1 0 1 BNC-1.sym
{
T 55250 48150 5 10 0 0 0 6 1
device=BNC
T 56400 47600 5 10 1 1 0 6 1
refdes=OUTPUT
}
T 53400 48400 9 10 1 0 0 0 1
MCP6023
N 44100 41000 40700 41000 4
N 40700 43400 41400 43400 4
N 41200 42600 41200 43400 4
N 44100 42500 44100 41900 4
N 44900 46600 45700 46600 4
N 45300 46600 45300 46100 4
N 45300 45200 45300 44600 4
C 44700 46300 1 0 0 ground.sym
N 44100 43400 43000 43400 4
T 43700 43500 9 10 1 0 0 0 1
3V3
N 53000 47800 53200 47800 4
N 53200 47800 53200 47900 4
T 53300 47700 9 10 1 0 0 0 1
\_CS\_
C 52600 46100 1 0 0 capacitor-1.sym
{
T 52800 46800 5 10 0 0 0 0 1
device=CAPACITOR
T 52900 46600 5 10 1 1 0 0 1
refdes=2n2
T 52800 47000 5 10 0 0 0 0 1
symversion=0.1
}
N 53600 46300 53500 46300 4
N 52500 46300 52600 46300 4
N 52500 49500 53000 49500 4
N 48700 48600 49500 48600 4
N 49500 48600 49500 47800 4
N 45700 47400 45100 47400 4
N 45700 47000 45100 47000 4
C 44200 47300 1 0 0 resistor-2.sym
{
T 44600 47650 5 10 0 0 0 0 1
device=RESISTOR
T 45000 47500 5 10 1 1 0 0 1
refdes=470R
}
C 44200 46900 1 0 0 resistor-2.sym
{
T 44600 47250 5 10 0 0 0 0 1
device=RESISTOR
T 45000 47100 5 10 1 1 0 0 1
refdes=470R
}
N 44200 47400 41300 47400 4
N 44200 47000 41300 47000 4
T 40100 46900 9 10 1 0 0 0 1
TX
T 40100 47300 9 10 1 0 0 0 1
RX
T 40500 47300 9 10 1 0 0 0 1
GPIO15
T 40500 46900 9 10 1 0 0 0 1
GPIO14
N 53000 48200 53000 49500 4
T 52500 49600 9 10 1 0 0 0 1
VREF
C 41400 42800 1 0 0 mcp1700.sym
{
T 41700 43950 5 10 0 0 0 0 1
device=MCP1700
T 42800 43800 5 10 1 1 0 6 1
refdes=U2
T 41700 44550 5 10 0 0 0 0 1
footprint=TO92
T 41700 44150 5 10 0 0 0 0 1
symversion=1.0
}
N 41200 41700 41200 41000 4
C 43400 41700 1 90 0 capacitor-1.sym
{
T 42700 41900 5 10 0 0 90 0 1
device=CAPACITOR
T 43100 41800 5 10 1 1 90 0 1
refdes=1u
T 42500 41900 5 10 0 0 90 0 1
symversion=0.1
}
N 43200 42600 43200 43400 4
N 43200 41700 43200 41000 4
N 42200 42800 42200 41000 4
C 41000 40700 1 0 0 ground.sym
