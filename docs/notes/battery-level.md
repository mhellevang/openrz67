# Battery level

The Battery Service percent first came from a straight line from 2.5 V to 3.0 V. A CR2032 sits
near 2.9 V for most of its life and drops off at the end, so the line showed a high number for a
long time and then fell fast.

The firmware now maps the voltage through the CR2032 curve the nRF5 SDK uses in
`battery_level_in_percent()`: 3.0 V 100 %, 2.9 V 42 %, 2.74 V 18 %, 2.44 V 6 %, 2.1 V 0 %,
linear in between. It is still an estimate:

* the reading is taken at rest, while the radio load pulls the cell lower;
* a cold cell reads low and recovers when it warms up;
* each reading is a single sample, no averaging.

The Feather keeps its old linear LiPo range (3.3 to 4.15 V) as a two-point `vbat-curve`.
