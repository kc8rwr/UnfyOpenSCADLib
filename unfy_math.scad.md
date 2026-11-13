# LibFile: unfy\_math.scad

UnfyOpenSCADLib Copyright Leif Burrow 2026
kc8rwr@unfy.us
unforgettability.net

This file is part of UnfyOpenSCADLib.

unfy_math contains math functions for rounding, angles, regular polygons, circles, curve resolution and bezier curves.

## File Contents

1. [Section: Basic Math](#section-basic-math)
    - [`unf_inf`](#function-unf_inf) – Infinity
    - [`unf_isNan`](#function-unf_isnan) – Test for NaN
    - [`unf_round`](#function-unf_round) – Round to any decimal place
    - [`unf_signum`](#function-unf_signum) – Sign of a number
    - [`unf_normalizeAngle`](#function-unf_normalizeangle) – Normalize an angle to [0, 360)
    - [`unf_quadratic`](#function-unf_quadratic) – Solve a quadratic equation

2. [Section: Regular Polygons](#section-regular-polygons)
    - [`unf_calcPolygonDiameter`](#function-unf_calcpolygondiameter) – Regular polygon diameter from distance across flats
    - [`unf_calcPolygonInteriorAngle`](#function-unf_calcpolygoninteriorangle) – Regular polygon interior angle
    - [`unf_calcPolygonExteriorAngle`](#function-unf_calcpolygonexteriorangle) – Regular polygon exterior angle
    - [`unf_calcPolygonCentralAngle`](#function-unf_calcpolygoncentralangle) – Regular polygon central angle

3. [Section: Circles](#section-circles)
    - [`unf_distanceToBoundingCircle`](#function-unf_distancetoboundingcircle) – Distance from a point inside a circle to its edge

4. [Section: Curve Resolution](#section-curve-resolution)
    - [`unf_effectiveFn`](#function-unf_effectivefn) – Effective $fn
    - [`unf_effectiveFa`](#function-unf_effectivefa) – Effective $fa
    - [`unf_effectiveFs`](#function-unf_effectivefs) – Effective $fs

5. [Section: Curves](#section-curves)
    - [`unf_boundSize2`](#function-unf_boundsize2) – Bounding size of 2d points
    - [`unf_bezier`](#function-unf_bezier) – Points along a bezier curve
    - [`unf_cartesianFromPolar`](#function-unf_cartesianfrompolar) – Convert polar coordinates to cartesian
    - [`unf_chordDistance`](#function-unf_chorddistance) – Chord length from distance to center
    - [`unf_chordAngle`](#function-unf_chordangle) – Chord length from angle

6. [Section: Licensing](#section-licensing)


## Section: Basic Math


### Function: unf\_inf

**Synopsis:** Infinity

**Usage:** 

- unf_inf()

**Description:** 

Returns positive infinity. Adapted from https://forums.openscad.org/is-nan-td28336.html

---

### Function: unf\_isNan

**Synopsis:** Test for NaN

**Usage:** 

- unf_isNan(x)

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

### Function: unf\_normalizeAngle

**Synopsis:** Normalize an angle to [0, 360)

**Usage:** 

- unf_normalizeAngle(angle)

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


### Function: unf\_calcPolygonDiameter

**Synopsis:** Regular polygon diameter from distance across flats

**Usage:** 

- unf_calcPolygonDiameter(f, n)

**Description:** 

Calculate the diameter of a regular polygon (the diameter of the circle passing through its vertices) from the distance between opposite sides. Useful for sizing a circle() with a low $fn, such as a hexagonal nut trap.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`f`                  | distance between flats
`n`                  | number of sides

---

### Function: unf\_calcPolygonInteriorAngle

**Synopsis:** Regular polygon interior angle

**Usage:** 

- unf_calcPolygonInteriorAngle(n)

**Description:** 

Calculate the interior angles of a regular polygon given the number of sides.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`n`                  | number of sides

---

### Function: unf\_calcPolygonExteriorAngle

**Synopsis:** Regular polygon exterior angle

**Usage:** 

- unf_calcPolygonExteriorAngle(n)

**Description:** 

Calculate the exterior angles of a regular polygon given the number of sides.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`n`                  | number of sides

---

### Function: unf\_calcPolygonCentralAngle

**Synopsis:** Regular polygon central angle

**Usage:** 

- unf_calcPolygonCentralAngle(n)

**Description:** 

Calculate the central angle of a regular polygon (the angle between two adjacent vertices, as seen from the center) given the number of sides.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`n`                  | number of sides

---

## Section: Circles


### Function: unf\_distanceToBoundingCircle

**Synopsis:** Distance from a point inside a circle to its edge

**Usage:** 

- unf_distanceToBoundingCircle(radius, point, angle, [focus])

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

### Function: unf\_effectiveFn

**Synopsis:** Effective $fn

**Usage:** 

- unf_effectiveFn(radius, [angle])

**Description:** 

Determine which of $fa, $fs or $fn currently takes precidence, calculate and return an equivalent $fn value.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`radius`             | radius of the circle or arc
`angle`              | angle in degrees covered by the arc, 360 for a full circle (360)

---

### Function: unf\_effectiveFa

**Synopsis:** Effective $fa

**Usage:** 

- unf_effectiveFa(radius)

**Description:** 

Determine which of $fa, $fs or $fn currently takes precidence, calculate and return an equivalent $fa value.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`radius`             | radius of the circle

---

### Function: unf\_effectiveFs

**Synopsis:** Effective $fs

**Usage:** 

- unf_effectiveFs(radius)

**Description:** 

Determine which of $fa, $fs or $fn currently takes precidence, calculate and return an equivalent $fs value.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`radius`             | radius of the circle

---

## Section: Curves


### Function: unf\_boundSize2

**Synopsis:** Bounding size of 2d points

**Usage:** 

- unf_boundSize2(v)

**Description:** 

Determine the bounding size of a vector of 2 dimensional vectors. Returns [width, height], or 0 if fewer than 2 points are given.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`v`                  | vector of [x, y] points

---

### Function: unf\_bezier

**Synopsis:** Points along a bezier curve

**Usage:** 

- unf_bezier(v)

**Description:** 

Take a vector of control points, return a vector of points on the curve. Linear, quadratic and cubic curves (2, 3 or 4 control points) are supported. The number of points is determined by the current $fn, $fa and $fs.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`v`                  | vector of 1 to 4 [x, y] control points

---

### Function: unf\_cartesianFromPolar

**Synopsis:** Convert polar coordinates to cartesian

**Usage:** 

- unf_cartesianFromPolar([r], [theta])

**Description:** 

Convert a polar coordinate to an [x, y] cartesian coordinate.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`r`                  | distance from the origin (1)
`theta`              | angle in degrees, counter-clockwise from the X axis (90)

---

### Function: unf\_chordDistance

**Synopsis:** Chord length from distance to center

**Usage:** 

- unf_chordDistance([r], [d])

**Description:** 

Returns the length of a chord given it's distance from the vertex and the radius.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`r`                  | radius of the circle (1)
`d`                  | distance of the chord from the center of the circle (0.5)

---

### Function: unf\_chordAngle

**Synopsis:** Chord length from angle

**Usage:** 

- unf_chordAngle([r], [a])

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


