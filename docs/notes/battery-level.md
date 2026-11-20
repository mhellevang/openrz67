# Battery level

The Battery Service percent first came from a straight line from 2.5 V to 3.0 V. A CR2032 sits
near 2.9 V for most of its life and drops off at the end, so the line showed a high number for a
long time and then fell fast.

The firmware now maps the voltage through the CR2032 curve the nRF5 SDK uses in
`battery_level_in_percent()`: 3.0 V 100 %, 2.9 V 42 %, 2.74 V 18 %, 2.44 V 6 %, 2.1 V 0 %,
linear in between. It is still an estimate:

* the cell takes a while to recover after a load such as a long bulb exposure, and reads low
  until then;
* a cold cell reads low and recovers when it warms up.

Around 2.9 V the curve is steep, so a single ADC sample that hit a radio event moved the
percent by tens of points (27 % and 47 % a few minutes apart on the same cell). Each reading is
now the highest of 5 samples 6 ms apart: a radio event lasts a couple of ms and only pulls the
cell down, so the highest sample is nearest the rest voltage. The ADC offset is calibrated on
the first sample.

The Feather keeps its old linear LiPo range (3.3 to 4.15 V) as a two-point `vbat-curve`.
