# LibFile: unfy\_math.scad

UnfyOpenSCADLib Copyright Leif Burrow 2026
kc8rwr@unfy.us
unforgettability.net

This file is part of UnfyOpenSCADLib.

unfy_math contains math functions for rounding, angles, regular polygons, circles, curve resolution and bezier curves.

## File Contents

1. [Section: Basic Math](#section-basic-math)
    - [`unf_INF`](#function-unf_inf) – Infinity
    - [`unf_is_nan`](#function-unf_is_nan) – Test for NaN
    - [`unf_round`](#function-unf_round) – Round to any decimal place
    - [`unf_signum`](#function-unf_signum) – Sign of a number
    - [`unf_normalize_angle`](#function-unf_normalize_angle) – Normalize an angle to [0, 360)
    - [`unf_quadratic`](#function-unf_quadratic) – Solve a quadratic equation

2. [Section: Regular Polygons](#section-regular-polygons)
    - [`unf_calc_polygon_diameter`](#function-unf_calc_polygon_diameter) – Regular polygon diameter from distance across flats
    - [`unf_calc_polygon_interior_angle`](#function-unf_calc_polygon_interior_angle) – Regular polygon interior angle
    - [`unf_calc_polygon_exterior_angle`](#function-unf_calc_polygon_exterior_angle) – Regular polygon exterior angle
    - [`unf_calc_polygon_central_angle`](#function-unf_calc_polygon_central_angle) – Regular polygon central angle

3. [Section: Circles](#section-circles)
    - [`unf_distance_to_bounding_circle`](#function-unf_distance_to_bounding_circle) – Distance from a point inside a circle to its edge

4. [Section: Curve Resolution](#section-curve-resolution)
    - [`unf_effective_fn`](#function-unf_effective_fn) – Effective $fn
    - [`unf_effective_fa`](#function-unf_effective_fa) – Effective $fa
    - [`unf_effective_fs`](#function-unf_effective_fs) – Effective $fs

5. [Section: Curves](#section-curves)
    - [`unfy_bound_size2`](#function-unfy_bound_size2) – Bounding size of 2d points
    - [`unfy_bezier`](#function-unfy_bezier) – Points along a bezier curve
    - [`unf_cartesian_from_polar`](#function-unf_cartesian_from_polar) – Convert polar coordinates to cartesian
    - [`unf_chord_distance`](#function-unf_chord_distance) – Chord length from distance to center
    - [`unf_chord_angle`](#function-unf_chord_angle) – Chord length from angle

6. [Section: Licensing](#section-licensing)


## Section: Basic Math


### Function: unf\_INF

**Synopsis:** Infinity

**Usage:** 

- unf_INF()

**Description:** 

Returns positive infinity. Adapted from https://forums.openscad.org/is-nan-td28336.html

---

### Function: unf\_is\_nan

**Synopsis:** Test for NaN

**Usage:** 

- unf_is_nan(x)

**Description:** 

Returns true if x is NaN (not a number). NaN is the only value which is not equal to itself. Adapted from https://forums.openscad.org/is-nan-td28336.html

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`x`                  | the value to test

---

### Function: unf\_round

**Synopsis:** Round to any decimal place

**Usage:** 

- unf_round(num, [place])

**Description:** 

A rounding function that allows rounding to places other than ones. The place is given as a power of 10, so place=0 rounds to the ones place, place=1 rounds to the tens place and place=-2 rounds to the hundredths place.

For example unf_round(52.43, 1) returns 50 and unf_round(52.43, -1) returns 52.4.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`num`                | the number to round
`place`              | the power of 10 to round to (0)

---

### Function: unf\_signum

**Synopsis:** Sign of a number

**Usage:** 

- unf_signum(x)

**Description:** 

Returns -1 if x is negative, 0 if x is zero or 1 if x is positive.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`x`                  | the input number

---

### Function: unf\_normalize\_angle

**Synopsis:** Normalize an angle to [0, 360)

**Usage:** 

- unf_normalize_angle(angle)

**Description:** 

Convert any angle to an equivalent positive (or 0) angle within a single circle. For example -90 becomes 270 and 450 becomes 90.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`angle`              | the angle in degrees

---

### Function: unf\_quadratic

**Synopsis:** Solve a quadratic equation

**Usage:** 

- unf_quadratic(a, b, c)

**Description:** 

Use the quadratic formula to solve the equation ax² + bx + c = 0. Returns a vector containing both answers, [(-b - √(b²-4ac)) / 2a, (-b + √(b²-4ac)) / 2a].

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`a`                  | the coefficient of x²
`b`                  | the coefficient of x
`c`                  | the constant term

---

## Section: Regular Polygons


### Function: unf\_calc\_polygon\_diameter

**Synopsis:** Regular polygon diameter from distance across flats

**Usage:** 

- unf_calc_polygon_diameter(f, n)

**Description:** 

Calculate the diameter of a regular polygon (the diameter of the circle passing through its vertices) from the distance between opposite sides. Useful for sizing a circle() with a low $fn, such as a hexagonal nut trap.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`f`                  | distance between flats
`n`                  | number of sides

---

### Function: unf\_calc\_polygon\_interior\_angle

**Synopsis:** Regular polygon interior angle

**Usage:** 

- unf_calc_polygon_interior_angle(n)

**Description:** 

Calculate the interior angles of a regular polygon given the number of sides.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`n`                  | number of sides

---

### Function: unf\_calc\_polygon\_exterior\_angle

**Synopsis:** Regular polygon exterior angle

**Usage:** 

- unf_calc_polygon_exterior_angle(n)

**Description:** 

Calculate the exterior angles of a regular polygon given the number of sides.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`n`                  | number of sides

---

### Function: unf\_calc\_polygon\_central\_angle

**Synopsis:** Regular polygon central angle

**Usage:** 

- unf_calc_polygon_central_angle(n)

**Description:** 

Calculate the central angle of a regular polygon (the angle between two adjacent vertices, as seen from the center) given the number of sides.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`n`                  | number of sides

---

## Section: Circles


### Function: unf\_distance\_to\_bounding\_circle

**Synopsis:** Distance from a point inside a circle to its edge

**Usage:** 

- unf_distance_to_bounding_circle(radius, point, angle, [focus])

**Description:** 

Calculate the distance from a point within a circle to it's circumference along a given angle.

Set demonstrate_unf_distance_to_bounding_circle to true and open this file in OpenSCAD for a graphical demonstration. Set steps to 360 to animate it.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`radius`             | radius of the circle
`point`              | [x, y] location of the point within the circle
`angle`              | direction in degrees in which to measure, counter-clockwise from the X axis
`focus`              | [x, y] location of the center of the circle ([0, 0])

---

## Section: Curve Resolution

Since which of $fa, $fs, $fn determines curve resolution varies depending on their respective values these functions allow one to calculate one which will be correct for use within modules.

Adapted from Post by MichaelAtOz https://openscad.rocklinux.narkive.com/jhqIIcOm/fn-fa-and-fs

### Function: unf\_effective\_fn

**Synopsis:** Effective $fn

**Usage:** 

- unf_effective_fn(radius, [angle])

**Description:** 

Determine which of $fa, $fs or $fn currently takes precidence, calculate and return an equivalent $fn value.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`radius`             | radius of the circle or arc
`angle`              | angle in degrees covered by the arc, 360 for a full circle (360)

---

### Function: unf\_effective\_fa

**Synopsis:** Effective $fa

**Usage:** 

- unf_effective_fa(radius)

**Description:** 

Determine which of $fa, $fs or $fn currently takes precidence, calculate and return an equivalent $fa value.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`radius`             | radius of the circle

---

### Function: unf\_effective\_fs

**Synopsis:** Effective $fs

**Usage:** 

- unf_effective_fs(radius)

**Description:** 

Determine which of $fa, $fs or $fn currently takes precidence, calculate and return an equivalent $fs value.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`radius`             | radius of the circle

---

## Section: Curves


### Function: unfy\_bound\_size2

**Synopsis:** Bounding size of 2d points

**Usage:** 

- unfy_bound_size2(v)

**Description:** 

Determine the bounding size of a vector of 2 dimensional vectors. Returns [width, height], or 0 if fewer than 2 points are given.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`v`                  | vector of [x, y] points

---

### Function: unfy\_bezier

**Synopsis:** Points along a bezier curve

**Usage:** 

- unfy_bezier(v)

**Description:** 

Take a vector of control points, return a vector of points on the curve. Linear, quadratic and cubic curves (2, 3 or 4 control points) are supported. The number of points is determined by the current $fn, $fa and $fs.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`v`                  | vector of 1 to 4 [x, y] control points

---

### Function: unf\_cartesian\_from\_polar

**Synopsis:** Convert polar coordinates to cartesian

**Usage:** 

- unf_cartesian_from_polar([r], [theta])

**Description:** 

Convert a polar coordinate to an [x, y] cartesian coordinate.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`r`                  | distance from the origin (1)
`theta`              | angle in degrees, counter-clockwise from the X axis (90)

---

### Function: unf\_chord\_distance

**Synopsis:** Chord length from distance to center

**Usage:** 

- unf_chord_distance([r], [d])

**Description:** 

Returns the length of a chord given it's distance from the vertex and the radius.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`r`                  | radius of the circle (1)
`d`                  | distance of the chord from the center of the circle (0.5)

---

### Function: unf\_chord\_angle

**Synopsis:** Chord length from angle

**Usage:** 

- unf_chord_angle([r], [a])

**Description:** 

Returns the length of a chord given the angle the chord forms with the vertex and the radius.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`r`                  | radius of the circle (1)
`a`                  | angle in degrees between the two ends of the chord, as seen from the center (45)

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


