# LibFile: unfy\_fasteners.scad

UnfyOpenSCADLib Copyright Leif Burrow 2026
kc8rwr@unfy.us
unforgettability.net

This file is part of UnfyOpenSCADLib.

UnfyOpenSCADLib is free software: you can redistribute it and/or modify it under the terms of the
GNU General Public License as published by the Free Software Foundation, either version 3 of
the License, or (at your option) any later version.

UnfyOpenSCADLib is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with UnfyOpenSCADLib.
If not, see <https://www.gnu.org/licenses/>.

Unfy_fasteners.scad contains modules for creating bolts, screws, nuts, washers, heatsink inserts and more. These models at the time do not include threads. Their purpose is for subtracting from a model to create holes and countersinks. Realistic models with threads could be added later if there is a use for them.

Fasteners may be generated to size by passing the size as a string. Metric sizes may be passed as "M&lt;number&gt;" such as "M4" or "M3". It is case insensitie so "m4" or "m3" will work as well. Numbered SAE sizes are represented as "#&lt;number&gt;", such as "#6" or "#8". Inch sizes are represented as a decimal number or as a fraction. "1/4" or "0.25" would both represent 1/4".

Tables are included for looking up dimensions based on these sizes. Shaft diameter of course is the size itself in it's respective units. Tables also include things like typical diameters and thicknesses of heads for various bolt types, nut, washer and heatset insert dimensions, etc... Most sizes commonly used in 3d-printed projects as well as larger fasteners commonly available in hardware stores are included. If sizes that are outside of the built in tables are requested then the code will attempt to interpolate the missing value.

Functions are included to look up the various dimensions of fasteners by size and type. This way one using this library may allow the end user to choose fastener sizes from the customizer menu. Then the script may adapt, re-sizing or re-positioning things based on the outer dimensions of the requested fastener sizes. Sizes may be looked up as scalars describing just one dimension. Or they may be looked up as a vector which may then be passed to the functions that look up the individual dimensions or the module which renders the part. This way the lookup and/or interpolation need only happen once.

The goal here is to allow the user to create customizable designs where the end user may choose parts that they already have on hand or parts that are easily available. Designers are encouraged to give the end-user plenty of choices. Perfectly valid arguments regarding the merits of measurement systems aside, the best fastener size is the one you already have on hand. The next best is the one your local hardware store sells in bulk rather than the specialty isle.

Provisions are included for distorting horizontal bolt holes, to remove some extra material from the top side. This way when printing via fused filament fabrication plastic which sags down will just cancel this distortion out rather than requiring drilling so the bolt can fit cleanly. The distortion is defined by two special variables, $unf-hdist_y and $unf_hdist_x. These define the extra removed material by height and width respectively, both as a percentage of the shaft diameter.

So far this feature has been developed only for bolt holes and not the other parts. The original intention was to distort every part depending on the angle at which it is rendered. Unfortunately there is no good way to know what angle a part is being rendered in OpenSCAD so it relies on the user telling it. Thus this feature has not been furtner developed.

## File Contents

- [`unf_fnr_type`](#function-unf_fnr_type)
- [`unf_fnr_size`](#function-unf_fnr_size)
- [`unf_fnr_diameter`](#function-unf_fnr_diameter)
- [`unf_fnr_shaft_diameter`](#function-unf_fnr_shaft_diameter)
- [`unf_shaft`](#module-unf_shaft)
- [`unf_cap_v`](#function-unf_cap_v)
- [`unf_cap_head_diameter`](#function-unf_cap_head_diameter)
- [`unf_cap_head_height`](#function-unf_cap_head_height)
- [`unf_cap_default_length`](#function-unf_cap_default_length)
- [`unf_cap`](#module-unf_cap)
- [`unf_csk_v`](#function-unf_csk_v)
- [`unf_csk_head_diameter`](#function-unf_csk_head_diameter)
- [`unf_csk_head_height`](#function-unf_csk_head_height)
- [`unf_csk_default_length`](#function-unf_csk_default_length)
- [`unf_csk`](#module-unf_csk)


### Function: unf\_fnr\_type

**Usage:** 

- unf_fnr_type(fastener_vector)

**Description:** 

Takes a vector describing a fastener and returns a string representing the fastener type.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`in`                 | vector describing an unfy_fastener

---

### Function: unf\_fnr\_size

**Usage:** 

- unf_fnr_size(fastener_size_or_vector)

**Description:** 

Takes a vector describing a fastener or a string representing the fastener size and returns a string representing the fastener size.

Of course this isnt't doing much when it is passed the string. This is done so that a variable may hold the size string which the user requested before it is expanded into the vector and still work in the same code.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`in`                 | vector describing an unfy_fastener or a string representing the size of one.

---

### Function: unf\_fnr\_diameter

**Usage:** 

- unf_fnr_diameter(fastener_size_or_vector)

**Description:** 

Takes a vector describing a fastener or a string representing the fastener size and returns the diameter of the widest part in millimeters. Useful for calculating positioning or sizes of parts that will contain the fastener when the end-user is allowed to pick from a variety of sizes of fasteners.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`in`                 | vector describing an unfy_fastener or a string representing the size of one.

---

### Function: unf\_fnr\_shaft\_diameter

**Usage:** 

- unf_fnr_shaft_diameter(fastener_size_or_vector)

**Description:** 

Takes a vector describing a fastener or a string representing the fastener size and returns the shaft diameter in millimeters.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`in`                 | vector describing an unfy_fastener or a string representing the size of one.

---

### Module: unf\_shaft

**Usage:** 

- unf_shaft(diameter, length, distorted, $unf_hdist_x, $unf_hdist_y)

**Description:** 

Render a fastener shaft hole, optionally with distortions to account for overhang sagging when 3d-printing.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`diameter`           | shaft diameter in mm
`length`             | length in mm
`distorted`          | true/false should this be distorted

<abbr title="These args must be used by name, ie: name=value">By&nbsp;Name</abbr> | What it does
-------------------- | ------------
`$unf_hdist_x`       | width of distortion as a percentage of the diameter (0-100)
`$unf_hdist_y`       | height of distortion as a percentage of the diameter (0-100)

**Figure 1.5.1:** various values of unf\_hdist\_x and unf\_hdist\_y. (0, 0) or distorted=false would be a perfect circle.

<img align="left" alt="unf\_shaft Figure 1.5.1" src="images/unfy_fasteners/figure_1_5_1.png" width="320" height="240">

<br clear="all" />

---

### Function: unf\_cap\_v

**Usage:** 

- unf_cap_v(size_or_vector)

**Description:** 

Retrieve a vector representing the dimensions of a cap-head bolt given the size. Will return the passed parameter if passed a vector. Thus sizes and dimension vectors may be treated interchangably.

The vector will consist of, in order:
* name
* bolt_diameter
* head_diameter
* head_height
* default_length

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`size`               | size as a string or the vector itself

---

### Function: unf\_cap\_head\_diameter

**Usage:** 

- unf_cap_head_diameter(size_or_vector)

**Description:** 

Retrieve the diameter in mm of the head of a cap-head bolt given the size.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`size`               | size as a string or the unf_cap_v() vector itself

---

### Function: unf\_cap\_head\_height

**Usage:** 

- unf_cap_head_height(size_or_vector)

**Description:** 

Retrieve the height or thickness in mm of the head of a cap-head bolt given the size.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`size`               | size as a string or the unf_cap_v() vector itself

---

### Function: unf\_cap\_default\_length

**Usage:** 

- unf_cap_default_length(size_or_vector)

**Description:** 

Retrieve a default length for a cap head bolt given it's size. Probably not very useful in a real design, good for picking a length to demonstrate an example of a unf_cap bolt.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`size`               | size as a string or the unf_cap_v() vector itself

---

### Module: unf\_cap

**Usage:** 

- unf_cap(size, length, head_ext, distorted, $unf_hdist_x, $unf_hdist_y)

**Description:** 

Render a negative for a shaft and/or head-recess for a cap-head bolt. Note, the cap head is rendered as a simple cylinder with the diameter of the widest part of the actual head. This is because it is meant for being a negative, to recess a bolt and not for printing an actual bolt.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`size`               | string representing the size or the unf_cap_v() vector.
`length`             | length in mm
`head_ext`           | length in mm to recess the head beyond just it's thickness
`distorted`          | true/false, should the bolt hole be distorted

<abbr title="These args must be used by name, ie: name=value">By&nbsp;Name</abbr> | What it does
-------------------- | ------------
`$unf_hdist_x`       | width of distortion as a percentage of the diameter (0-100)
`$unf_hdist_y`       | height of distortion as a percentage of the diameter (0-100)

**Figure 1.10.1:** note - the head\_ext area is semi-transparent.

<img align="left" alt="unf\_cap Figure 1.10.1" src="images/unfy_fasteners/figure_1_10_1.png" width="320" height="240">

<br clear="all" /><br/>

---

### Function: unf\_csk\_v

**Usage:** 

- unf_csk_v(size_or_vector)

**Description:** 

Retrieve a vector representing the dimensions of a countersunk bolt given the size. Will return the passed parameter if passed a vector. Thus sizes and dimension vectors may be treated interchangably.

The vector will consist of, in order:
* name
* bolt_diameter
* head_diameter
* head_height
* default_length

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`size`               | size as a string or the vector itself

---

### Function: unf\_csk\_head\_diameter

**Usage:** 

- unf_csk_head_diameter(size_or_vector)

**Description:** 

Retrieve the diameter in mm of the head of a countersunk bolt given the size.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`size`               | size as a string or the unf_csk_v() vector itself

---

### Function: unf\_csk\_head\_height

**Usage:** 

- unf_csk_head_height(size_or_vector)

**Description:** 

Retrieve the height or thickness in mm of the head of a countersunk bolt given the size.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`size`               | size as a string or the unf_cap_v() vector itself

---

### Function: unf\_csk\_default\_length

**Usage:** 

- unf_csk_default_length(size_or_vector)

**Description:** 

Retrieve a default length for a countersunk bolt given it's size. Probably not very useful in a real design, good for picking a length to demonstrate an example of a unf_csk bolt.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`size`               | size as a string or the unf_cap_v() vector itself

---

### Module: unf\_csk

**Usage:** 

- unf_csk(size, length, head_ext, distorted, $unf_hdist_x, $unf_hdist_y)

**Description:** 

Render a negative for a shaft and/or head-recess for a cap-head bolt. Note, the cap head is rendered as a simple cylinder with the diameter of the widest part of the actual head. This is because it is meant for being a negative, to recess a bolt and not for printing an actual bolt.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`size`               | string representing the size or the unf_cap_v() vector.
`length`             | length in mm
`head_ext`           | length in mm to recess the head beyond just it's thickness
`distorted`          | true/false, should the bolt hole be distorted

<abbr title="These args must be used by name, ie: name=value">By&nbsp;Name</abbr> | What it does
-------------------- | ------------
`$unf_hdist_x`       | width of distortion as a percentage of the diameter (0-100)
`$unf_hdist_y`       | height of distortion as a percentage of the diameter (0-100)

**Figure 1.15.1:** note - the head\_ext area is semi-transparent.

<img align="left" alt="unf\_csk Figure 1.15.1" src="images/unfy_fasteners/figure_1_15_1.png" width="320" height="240">

<br clear="all" /><br/>

---

