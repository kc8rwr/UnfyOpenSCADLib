# LibFile: unfy\_lists.scad

UnfyOpenSCADLib Copyright Leif Burrow 2026
kc8rwr@unfy.us
unforgettability.net

This file is part of UnfyOpenSCADLib.

unfy_lists.scad contains functions for working with lists and strings within OpenSCAD.

## File Contents

- [`unf_lookup`](#function-unf_lookup) – Lookup with interpolation
- [`unf_stCutAfter`](#function-unf_stcutafter) – Return a string with everything after the beginning of the first occurance of a substring cut off.
- [`unf_stTrim`](#function-unf_sttrim) – Trim a string
- [`unf_vToS`](#function-unf_vtos) – Convert a vector to a string
- [`unf_stToLower`](#function-unf_sttolower) – Convert a string to lowercase.
- [`unf_stToUpper`](#function-unf_sttoupper) – Convert a string to uppercase.
- [`unf_chToLower`](#function-unf_chtolower) – Convert a character to lowercase
- [`unf_chToUpper`](#function-unf_chtoupper) – Convert a character to uppercase
- [`unf_sub`](#function-unf_sub) – return a subset of a string or a vector
- [`unf_stToInt`](#function-unf_sttoint) – convert a numeric string to an integer
- [`unf_stToDec`](#function-unf_sttodec) – convert a numeric string to an number's decimal part
- [`unf_stToNum`](#function-unf_sttonum) – convert a numeric string to a number
- [`unf_ordToLower`](#function-unf_ordtolower) – Convert a character represented as a unicode number to lowercase
- [`unf_ordToUpper`](#function-unf_ordtoupper) – Convert a character represented as a unicode number to uppercase
- [`unf_matrix_sort`](#function-unf_matrix_sort) – Sort a 2-dimensional matrix
- [`unf_enbox`](#module-unf_enbox) – Place a box around something

2. [Section: Licensing](#section-licensing)


### Function: unf\_lookup

**Synopsis:** Lookup with interpolation

**Usage:** lookup(key, values)


**Description:** 

(key, vector[key, value]) - Looks up a value from a table, like the built-in lookup function but interpolate even beyond the bounds of the vector

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`key`                | the lookup key
`values`             | the value table to look within

---

### Function: unf\_stCutAfter

**Synopsis:** Return a string with everything after the beginning of the first occurance of a substring cut off.

**Usage:** unf\\_stCutAfter(string in, string cutoff)


**Description:** 

Find the first occurrance of cutoff within in and return a string that consists of in, only up to that point with the rest cut off.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`in`                 | the input string
`cutoff`             | the search substring
`trim`               | also trim any preceding or trailing whitespace?

---

### Function: unf\_stTrim

**Synopsis:** Trim a string

**Usage:** unf\\_strTrim(in)


**Description:** 

Return a copy of a string with any whitespace on the front or back trimmed off.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`in`                 | the input string

---

### Function: unf\_vToS

**Synopsis:** Convert a vector to a string

**Usage:** unf\\_vToS(in)


**Description:** 

Convert a vector to a string.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`in`                 | input vector

---

### Function: unf\_stToLower

**Synopsis:** Convert a string to lowercase.

**Usage:** unf\\_stToLower(in)


**Description:** 

Take an input string and return a copy where every uppercase character has been converted to it's lowercase equivalent.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`in`                 | the input string

---

### Function: unf\_stToUpper

**Synopsis:** Convert a string to uppercase.

**Usage:** unf\\_stToUpper(in)


**Description:** 

Take an input string and return a copy where every lowercase character has been converted to it's uppercase equivalent.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`in`                 | the input string

---

### Function: unf\_chToLower

**Synopsis:** Convert a character to lowercase

**Usage:** unf\\_chToLower(in)


**Description:** 

Accepts a single character and if it is uppercase then return it's lowercase equivalent otherwise return the original input.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`in`                 | the input character

---

### Function: unf\_chToUpper

**Synopsis:** Convert a character to uppercase

**Usage:** unf\\_chToUpper(in)


**Description:** 

Accepts a single character and if it is lowercase then return it's uppercase equivalent otherwise return the original input.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`in`                 | the input character

---

### Function: unf\_sub

**Synopsis:** return a subset of a string or a vector

**Usage:** 

- unf_sub(v, start, count, outv)

**Description:** 

Takes a string or vector input. Returns a string or vector starting at an index and ending no more than count beyond this index. Returns a string or vector type output the same as the input unless outv is set true. In that case then always output a vector.

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`v`                  | input string or vector value
`start`              | starting index
`count`              | count of max caracters or items to return
`outv`               | force output type to vector?

---

### Function: unf\_stToInt

**Synopsis:** convert a numeric string to an integer

**Usage:** 

- unf_stToInt(in)

**Description:** 

Converts a numeric string to an integer. Garbage in = Garbage Out. Non-numeric characters are counted as 0s. Uses recursion, not tail recursive so could overflow but.. that would require a very long number string.

**Arguments:** in = input string

---

### Function: unf\_stToDec

**Synopsis:** convert a numeric string to an number's decimal part

**Usage:** 

- unf_stToDec(in)

**Description:** 

Converts a numeric string to an integer less than 1. Convert it as though there was a "0." in front of it. For example, "123" becomes the number 0.123.  Garbage in = Garbage Out. Non-numeric characters are counted as 0s. Uses recursion, not tail recursive so could overflow but.. that would require a very long number string.

**Arguments:** in = input string

---

### Function: unf\_stToNum

**Synopsis:** convert a numeric string to a number

**Usage:** 

- unf_stToNum(in)

**Description:** 

Converts a numeric string to a number. Handles integers and floats with decimal points. Interprets a '/' as division, converting fractions to decimals. Garbage in = Garbage Out. Non-numeric characters are counted as 0s. Uses recursion, not tail recursive so could overflow but.. that would require a very long number string.

**Arguments:** in = input string

---

### Function: unf\_ordToLower

**Synopsis:** Convert a character represented as a unicode number to lowercase

**Usage:** unf\\_ordToLower(in)


**Description:** 

Converts a number representing a unicode character to the number representing it's lowercase version

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`in`                 | the input number

---

### Function: unf\_ordToUpper

**Synopsis:** Convert a character represented as a unicode number to uppercase

**Usage:** unf\\_ordToLower(in)


**Description:** 

Converts a number representing a unicode character to the number representing it's uppercase version

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`in`                 | the input number

---

### Function: unf\_matrix\_sort

**Synopsis:** Sort a 2-dimensional matrix

**Usage:** unf\\_matrix(arr, sort\\_col\\_num)


**Description:** 

Sorts a vector of vectors by the values in one of the columns of the inner vectors. *adapted from quicksort example OpenSCAD manual https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#Sorting_a_vector*

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`arr`                | the matrix to sort
`sort_col_num`       | the index of the items to sort by in the inner vectors

---

### Module: unf\_enbox

**Synopsis:** Place a box around something

**Description:** 

Places a 2-dimensional box around an item without having to know that item's size. This is not strictly a text or list function. However, it is mostly useful for putting a backing behind text since OpenSCAD gives no way to measure the size of rendered text. *Adapted from Mastering OpenSCAD https://mastering-openscad.eu/buch/introduction/*

**Arguments:** 

<abbr title="These args can be used by position or by name.">By&nbsp;Position</abbr> | What it does
-------------------- | ------------
`size`               | maximum size to support, must set some limit, may be large.
`extend_to_y`        | if the item being boxed begins to the right of the y-axis extend the box all the way to the y-axis. Useful with text because OpenSCAD often adds whitespace to the left of text.
`margin`             | margin around enboxed object in mm

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

