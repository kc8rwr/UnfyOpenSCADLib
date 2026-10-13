# LibFile: unfy\_motors.scad

UnfyOpenSCADLib Copyright Leif Burrow 2026
kc8rwr@unfy.us
unforgettability.net

This file is part of UnfyOpenSCADLib.

unfy_motors contains modules for working with motors and servos.

## File Contents

- [`unf_servo_arm`](#module-unf_servo_arm)

2. [Section: Licensing](#section-licensing)


### Module: unf\_servo\_arm

**Usage:** 

- unf_servo_arm(&lt;args&gt;);

**Description:** 

Creates the shape of a servo arm (horn) including the coupler which fits over the servo shaft. Intended for subtracting from a part to create a pocket that a servo arm fits into.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`length`             | length of each arm measured from the center of the shaft to the far end
`thickness`          | thickness of the arm
`coupler_height`     | height of the coupler that fits over the servo shaft, extending beyond the arm
`shaft_end_radius`   | radius of the arm at the shaft end, also the radius of the coupler
`end_radius`         | radius of the arm at the far end
`sides`              | number of arms, evenly spaced, or a vector of the angles at which to place each arm (1)
`distorted`          | distort the coupler hole to compensate for sagging when printed horizontally, see unf_shaft() in unfy_fasteners.scad (false)

**Figure 1.1.1:** single arm

<img align="left" alt="unf\_servo\_arm Figure 1.1.1" src="images/unfy_motors/figure_1_1_1.png" width="320" height="240">

<br clear="all" />

**Figure 1.1.2:** sides=4

<img align="left" alt="unf\_servo\_arm Figure 1.1.2" src="images/unfy_motors/figure_1_1_2.png" width="320" height="240">

<br clear="all" />

---

## Section: Licensing

UnfyOpenSCADLib is free software: you can redistribute it and/or modify it under the terms of the
GNU General Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.

UnfyOpenSCADLib is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with UnfyOpenSCADLib.
If not, see <https://www.gnu.org/licenses/>.


