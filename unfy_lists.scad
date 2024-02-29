//
// UnfyOpenSCADLib Copyright Leif Burrow 2022
// kc8rwr@unfy.us
// unforgettability.net
//
// This file is part of UnfyOpenSCADLib.
//
// UnfyOpenSCADLib is free software: you can redistribute it and/or modify it under the terms of the
// GNU General Public License as published by the Free Software Foundation, either version 3 of
// the License, or (at your option) any later version.
//
// UnfyOpenSCADLib is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
// without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with UnfyOpenSCADLib.
// If not, see <https://www.gnu.org/licenses/>.
//

// unf_lookup(key, vector[key, value]) - Like  built-in lookup but interpolate even beyond the bounds of the vector
function unf_lookup(key, v) = 0 == len(v) ? undef : (
  1 == len(v) ? v[0][1] : (
    key < v[0][0] ? v[0][1]-(((v[1][1]-v[0][1])/(v[1][0]-v[0][0])*(v[0][0]-key))) : (
      key <= v[len(v)-1][0] ? lookup(key, v) : (
	v[len(v)-1][1]+((((v[len(v)-1][0]-v[len(v)-2][0])/(v[len(v)-1][1]-v[len(v)-2][1]))*(key-v[len(v)-1][0])))
      )
    )
  )
);

// unf_stCutAfter(string in, string cutoff)
function unf_stCutAfter(in, cutoff, trim=true) = trim ? unf_stTrim(unf_stCutAfter(in, cutoff, false)) : (
  let(vpos=search(cutoff, in), pos=(0==len(vpos)?-1:vpos.x)) 0 > pos ? in : unf_sub(in, 0, pos)
);

// unf_stTrim(string in)
function unf_stTrim(in) = let(last=len(in)-1)
  0>last ? "" : (
    " "==in[0] || "\r"==in[0] || "\n"==in[0] ? unf_stTrim(unf_sub(in, 1)) : (
      " "==in[last] || "\r"==in[last] || "\n"==in[last] ? unf_stTrim(unf_sub(in, 0, last)) : in
    )
  );

// unf_vToS(in) - converts a vector to a string
function unf_vToS(in, pref="", start=0) =
  start >= len(in) ? pref : unf_vToS(in, str(in=pref, pref=in[start]), start=start+1);

// unf_stToLower(in) - converts a string to all lowercase
function unf_stToLower(in, pref="", start=0) =
  start >= len(in) ? pref : unf_stToLower(in, str(in=pref, pref=unf_chToLower(in[start])), start=start+1);
  
// unf_stToUpper(in) - converts a string to all uppercase
function unf_stToUpper(in, pref="", start=0) =
  start >= len(in) ? pref : unf_stToUpper(in, str(in=pref, pref=unf_chToUpper(in[start])), start=start+1);
  
// unf_chToLower(in) - converts a character to lowercase
function unf_chToLower(in) = chr(unf_ordToLower(ord(in)));

// unf_chToUpper(in) - converts a character to uppercase
function unf_chToUpper(in) = chr(unf_ordToUpper(ord(in)));

// unf_sub(v, start, count) - take a count-long substring/vector of a vector starting at char/index start
function unf_sub(v, start=0, count=0, outv=false) =
  (!outv) && is_string(v) ? unf_vToS(unf_sub(v, start, count, true)) : (
    0 == count ? [for(i=[start:len(v)-1])v[i]] : (
      0 < count ? [for(i = [start : min(len(v)-1, start+count-1)]) v[i]] : (
	[for(i = [max(0, start+count+1) : start]) v[i]]
      )
    )
  );

// unf_stToInt(in) - used by unf_stToNum() - convert a string to an integer
// gigo - non-numeric characters = 0; not tail recursive (but how long a number do you need?)
function unf_stToInt(in) = "" == in ? 0 : (
  1 == len(in) ? (
    "0" > in[0] || "9" < in[0] ? 0 : ord(in[0]) - ord("0")
  ) : (
    unf_stToInt(in[len(in)-1]) + (10 * unf_stToInt(unf_sub(in, 0, len(in)-1)))
  )
);

// unf_stToDec(in) - used by unf_stToNum() - convert a string to an decimal (as though it had "0." in front of it
// gigo - non-numeric characters = 0; not tail recursive (but how long of a decimal do you need?)
function unf_stToDec(in) = "" == in ? 0 : (
  1 == len(in) ? (
    "0" > in[0] || "9" < in[0] ? 0 : (ord(in[0]) - ord("0")) / 10
  ) : (
    unf_stToDec(in[0]) + (unf_stToDec(unf_sub(in, 1))/10)
  )
);

// unf_stToNum(in) - convert a string to a number, always returns int or decimal, if the string contains a fraction does the division
function unf_stToNum(in) = "" == in ? 0 : (
  is_undef(search("/", in).x) ? (
    is_undef(search(".", in).x) ? unf_stToInt(in) : (
      ("." == in[0] ? 0 : unf_stToInt(unf_sub(in, 0, search(".", in).x)))
      +
      ("." == in[(len(in)-1)] ? 0 : unf_stToDec(unf_sub(in, search(".", in).x+1)))
    )
  ) : (
      ("/" == in[0] ? 0 : unf_stToNum(unf_sub(in, 0, search("/", in).x)))
      /
      ("/" == in[(len(in)-1)] ? 1 : unf_stToNum(unf_sub(in, search("/", in).x+1)))
  )
);

// unf_ordToLower(in) - converts a number representing a unicode character to the number representing it's lowercase version
// generated by PHP code in comment at bottom of this file
function unf_ordToLower(in) = in < 65 ? in : (in < 91 ? in+32 : (in < 192 ? in : (in < 215 ? in+32 : (in < 216 ? in : (in < 223 ? in+32 : (in < 256 ? in : (in < 304 ? in : (in < 305 ? in-199 : (in < 306 ? in : (in < 313 ? in : (in < 330 ? in : (in < 376 ? in : (in < 377 ? in-121 : (in < 378 ? (0 == ((in-377)%2) ? in+1 : in) : (in < 385 ? in : (in < 386 ? in+210 : (in < 387 ? (0 == ((in-386)%2) ? in+1 : in) : (in < 390 ? in : (in < 391 ? in+206 : (in < 392 ? (0 == ((in-391)%2) ? in+1 : in) : (in < 393 ? in : (in < 395 ? in+205 : (in < 396 ? (0 == ((in-395)%2) ? in+1 : in) : (in < 398 ? in : (in < 399 ? in+79 : (in < 400 ? in+202 : (in < 401 ? in+203 : (in < 402 ? (0 == ((in-401)%2) ? in+1 : in) : (in < 403 ? in : (in < 404 ? in+205 : (in < 405 ? in+207 : (in < 406 ? in : (in < 407 ? in+211 : (in < 408 ? in+209 : (in < 409 ? (0 == ((in-408)%2) ? in+1 : in) : (in < 412 ? in : (in < 413 ? in+211 : (in < 414 ? in+213 : (in < 415 ? in : (in < 416 ? in+214 : (in < 417 ? (0 == ((in-416)%2) ? in+1 : in) : (in < 422 ? in : (in < 423 ? in+218 : (in < 424 ? (0 == ((in-423)%2) ? in+1 : in) : (in < 425 ? in : (in < 426 ? in+218 : (in < 428 ? in : (in < 430 ? in : (in < 431 ? in+218 : (in < 432 ? (0 == ((in-431)%2) ? in+1 : in) : (in < 433 ? in : (in < 435 ? in+217 : (in < 436 ? (0 == ((in-435)%2) ? in+1 : in) : (in < 439 ? in : (in < 440 ? in+219 : (in < 441 ? (0 == ((in-440)%2) ? in+1 : in) : (in < 444 ? in : (in < 452 ? in : (in < 453 ? in+2 : (in < 454 ? (0 == ((in-453)%2) ? in+1 : in) : (in < 455 ? in : (in < 456 ? in+2 : (in < 457 ? (0 == ((in-456)%2) ? in+1 : in) : (in < 458 ? in : (in < 459 ? in+2 : (in < 460 ? (0 == ((in-459)%2) ? in+1 : in) : (in < 478 ? in : (in < 497 ? in : (in < 498 ? in+2 : (in < 499 ? (0 == ((in-498)%2) ? in+1 : in) : (in < 502 ? in : (in < 503 ? in-97 : (in < 504 ? in-56 : (in < 505 ? (0 == ((in-504)%2) ? in+1 : in) : (in < 544 ? in : (in < 545 ? in-130 : (in < 546 ? in : (in < 570 ? in : (in < 571 ? in+10795 : (in < 572 ? (0 == ((in-571)%2) ? in+1 : in) : (in < 573 ? in : (in < 574 ? in-163 : (in < 575 ? in+10792 : (in < 577 ? in : (in < 579 ? in : (in < 580 ? in-195 : (in < 581 ? in+69 : (in < 582 ? in+71 : (in < 583 ? (0 == ((in-582)%2) ? in+1 : in) : (in < 880 ? in : (in < 886 ? in : (in < 895 ? in : (in < 896 ? in+116 : (in < 902 ? in : (in < 903 ? in+38 : (in < 904 ? in : (in < 907 ? in+37 : (in < 908 ? in : (in < 909 ? in+64 : (in < 910 ? in : (in < 912 ? in+63 : (in < 913 ? in : (in < 930 ? in+32 : (in < 931 ? in : (in < 940 ? in+32 : (in < 975 ? in : (in < 976 ? in+8 : (in < 984 ? in : (in < 1012 ? in : (in < 1013 ? in-60 : (in < 1015 ? in : (in < 1017 ? in : (in < 1018 ? in-7 : (in < 1019 ? (0 == ((in-1018)%2) ? in+1 : in) : (in < 1021 ? in : (in < 1024 ? in-130 : (in < 1040 ? in+80 : (in < 1072 ? in+32 : (in < 1120 ? in : (in < 1162 ? in : (in < 1216 ? in : (in < 1217 ? in+15 : (in < 1218 ? (0 == ((in-1217)%2) ? in+1 : in) : (in < 1232 ? in : (in < 1329 ? in : (in < 1367 ? in+48 : (in < 4256 ? in : (in < 4294 ? in+7264 : (in < 4295 ? in : (in < 4296 ? in+7264 : (in < 4301 ? in : (in < 4302 ? in+7264 : (in < 5024 ? in : (in < 5104 ? in+38864 : (in < 5110 ? in+8 : (in < 7312 ? in : (in < 7355 ? in-3008 : (in < 7357 ? in : (in < 7360 ? in-3008 : (in < 7680 ? in : (in < 7838 ? in : (in < 7839 ? in-7615 : (in < 7840 ? in : (in < 7944 ? in : (in < 7952 ? in-8 : (in < 7960 ? in : (in < 7966 ? in-8 : (in < 7976 ? in : (in < 7984 ? in-8 : (in < 7992 ? in : (in < 8000 ? in-8 : (in < 8008 ? in : (in < 8014 ? in-8 : (in < 8025 ? in : (in < 8026 ? in-8 : (in < 8027 ? in : (in < 8028 ? in-8 : (in < 8029 ? in : (in < 8030 ? in-8 : (in < 8031 ? in : (in < 8032 ? in-8 : (in < 8040 ? in : (in < 8048 ? in-8 : (in < 8072 ? in : (in < 8080 ? in-8 : (in < 8088 ? in : (in < 8096 ? in-8 : (in < 8104 ? in : (in < 8112 ? in-8 : (in < 8120 ? in : (in < 8122 ? in-8 : (in < 8124 ? in-74 : (in < 8125 ? in-9 : (in < 8136 ? in : (in < 8140 ? in-86 : (in < 8141 ? in-9 : (in < 8152 ? in : (in < 8154 ? in-8 : (in < 8156 ? in-100 : (in < 8168 ? in : (in < 8170 ? in-8 : (in < 8172 ? in-112 : (in < 8173 ? in-7 : (in < 8184 ? in : (in < 8186 ? in-128 : (in < 8188 ? in-126 : (in < 8189 ? in-9 : (in < 8486 ? in : (in < 8487 ? in-7517 : (in < 8490 ? in : (in < 8491 ? in-8383 : (in < 8492 ? in-8262 : (in < 8498 ? in : (in < 8499 ? in+28 : (in < 8544 ? in : (in < 8560 ? in+16 : (in < 8579 ? in : (in < 9398 ? in : (in < 9424 ? in+26 : (in < 11264 ? in : (in < 11311 ? in+48 : (in < 11360 ? in : (in < 11362 ? in : (in < 11363 ? in-10743 : (in < 11364 ? in-3814 : (in < 11365 ? in-10727 : (in < 11367 ? in : (in < 11373 ? in : (in < 11374 ? in-10780 : (in < 11375 ? in-10749 : (in < 11376 ? in-10783 : (in < 11377 ? in-10782 : (in < 11378 ? in : (in < 11381 ? in : (in < 11390 ? in : (in < 11392 ? in-10815 : (in < 11393 ? (0 == ((in-11392)%2) ? in+1 : in) : (in < 11499 ? in : (in < 11506 ? in : (in < 42560 ? in : (in < 42624 ? in : (in < 42786 ? in : (in < 42802 ? in : (in < 42873 ? in : (in < 42877 ? in : (in < 42878 ? in-35332 : (in < 42879 ? (0 == ((in-42878)%2) ? in+1 : in) : (in < 42891 ? in : (in < 42893 ? in : (in < 42894 ? in-42280 : (in < 42896 ? in : (in < 42902 ? in : (in < 42922 ? in : (in < 42923 ? in-42308 : (in < 42924 ? in-42319 : (in < 42925 ? in-42315 : (in < 42926 ? in-42305 : (in < 42927 ? in-42308 : (in < 42928 ? in : (in < 42929 ? in-42258 : (in < 42930 ? in-42282 : (in < 42931 ? in-42261 : (in < 42932 ? in+928 : (in < 42933 ? (0 == ((in-42932)%2) ? in+1 : in) : (in < 42946 ? in : (in < 42948 ? in : (in < 42949 ? in-48 : (in < 42950 ? in-42307 : (in < 42951 ? in-35384 : (in < 42952 ? (0 == ((in-42951)%2) ? in+1 : in) : (in < 42997 ? in : (in < 65313 ? in : (in < 65339 ? in+32 : (in < 66560 ? in : (in < 66600 ? in+40 : (in < 66736 ? in : (in < 66772 ? in+40 : (in < 68736 ? in : (in < 68787 ? in+64 : (in < 71840 ? in : (in < 71872 ? in+32 : (in < 93760 ? in : (in < 93792 ? in+32 : (in < 125184 ? in : (in < 125218 ? in+34 : (in))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));

// unf_ordToUpper(in) - converts a number representing a unicode character to the number representing it's uppercase version
// generated by PHP code in comment at bottom of this file
function unf_ordToUpper(in) = in < 97 ? in : (in < 123 ? in-32 : (in < 181 ? in : (in < 182 ? in+743 : (in < 223 ? in : (in < 224 ? in-140 : (in < 247 ? in-32 : (in < 248 ? in : (in < 255 ? in-32 : (in < 256 ? in+121 : (in < 257 ? in : (in < 305 ? in : (in < 306 ? in-232 : (in < 307 ? in : (in < 314 ? in : (in < 329 ? (0 == ((in-314)%2) ? in-1 : in) : (in < 330 ? in+371 : (in < 331 ? in : (in < 378 ? in : (in < 383 ? (0 == ((in-378)%2) ? in-1 : in) : (in < 384 ? in-300 : (in < 385 ? in+195 : (in < 387 ? in : (in < 392 ? in : (in < 396 ? in : (in < 402 ? in : (in < 405 ? in : (in < 406 ? in+97 : (in < 409 ? in : (in < 410 ? (0 == ((in-409)%2) ? in-1 : in) : (in < 411 ? in+163 : (in < 414 ? in : (in < 415 ? in+130 : (in < 417 ? in : (in < 424 ? in : (in < 429 ? in : (in < 432 ? in : (in < 436 ? in : (in < 441 ? in : (in < 445 ? in : (in < 447 ? in : (in < 448 ? in+56 : (in < 453 ? in : (in < 454 ? (0 == ((in-453)%2) ? in-1 : in) : (in < 455 ? in-2 : (in < 456 ? in : (in < 457 ? (0 == ((in-456)%2) ? in-1 : in) : (in < 458 ? in-2 : (in < 459 ? in : (in < 460 ? (0 == ((in-459)%2) ? in-1 : in) : (in < 461 ? in-2 : (in < 462 ? in : (in < 477 ? (0 == ((in-462)%2) ? in-1 : in) : (in < 478 ? in-79 : (in < 479 ? in : (in < 496 ? (0 == ((in-479)%2) ? in-1 : in) : (in < 497 ? in-422 : (in < 498 ? in : (in < 499 ? (0 == ((in-498)%2) ? in-1 : in) : (in < 500 ? in-2 : (in < 501 ? in : (in < 505 ? in : (in < 547 ? in : (in < 572 ? in : (in < 575 ? in : (in < 577 ? in+10815 : (in < 578 ? in : (in < 583 ? in : (in < 592 ? (0 == ((in-583)%2) ? in-1 : in) : (in < 593 ? in+10783 : (in < 594 ? in+10780 : (in < 595 ? in+10782 : (in < 596 ? in-210 : (in < 597 ? in-206 : (in < 598 ? in : (in < 600 ? in-205 : (in < 601 ? in : (in < 602 ? in-202 : (in < 603 ? in : (in < 604 ? in-203 : (in < 605 ? in+42319 : (in < 608 ? in : (in < 609 ? in-205 : (in < 610 ? in+42315 : (in < 611 ? in : (in < 612 ? in-207 : (in < 613 ? in : (in < 614 ? in+42280 : (in < 615 ? in+42308 : (in < 616 ? in : (in < 617 ? in-209 : (in < 618 ? in-211 : (in < 619 ? in+42308 : (in < 620 ? in+10743 : (in < 621 ? in+42305 : (in < 623 ? in : (in < 624 ? in-211 : (in < 625 ? in : (in < 626 ? in+10749 : (in < 627 ? in-213 : (in < 629 ? in : (in < 630 ? in-214 : (in < 637 ? in : (in < 638 ? in+10727 : (in < 640 ? in : (in < 641 ? in-218 : (in < 642 ? in : (in < 643 ? in+42307 : (in < 644 ? in-218 : (in < 647 ? in : (in < 648 ? in+42282 : (in < 649 ? in-218 : (in < 650 ? in-69 : (in < 652 ? in-217 : (in < 653 ? in-71 : (in < 658 ? in : (in < 659 ? in-219 : (in < 669 ? in : (in < 670 ? in+42261 : (in < 671 ? in+42258 : (in < 837 ? in : (in < 838 ? in+84 : (in < 881 ? in : (in < 887 ? in : (in < 891 ? in : (in < 894 ? in+130 : (in < 912 ? in : (in < 913 ? in+9 : (in < 940 ? in : (in < 941 ? in-38 : (in < 944 ? in-37 : (in < 945 ? in-11 : (in < 962 ? in-32 : (in < 963 ? in-31 : (in < 972 ? in-32 : (in < 973 ? in-64 : (in < 975 ? in-63 : (in < 976 ? in : (in < 977 ? in-62 : (in < 978 ? in-57 : (in < 981 ? in : (in < 982 ? in-47 : (in < 983 ? in-54 : (in < 984 ? in-8 : (in < 985 ? in : (in < 1008 ? (0 == ((in-985)%2) ? in-1 : in) : (in < 1009 ? in-86 : (in < 1010 ? in-80 : (in < 1011 ? in+7 : (in < 1012 ? in-116 : (in < 1013 ? in : (in < 1014 ? in-96 : (in < 1016 ? in : (in < 1019 ? in : (in < 1072 ? in : (in < 1104 ? in-32 : (in < 1120 ? in-80 : (in < 1121 ? in : (in < 1163 ? in : (in < 1218 ? in : (in < 1231 ? (0 == ((in-1218)%2) ? in-1 : in) : (in < 1232 ? in-15 : (in < 1233 ? in : (in < 1377 ? in : (in < 1415 ? in-48 : (in < 1416 ? in-82 : (in < 4304 ? in : (in < 4347 ? in+3008 : (in < 4349 ? in : (in < 4352 ? in+3008 : (in < 5112 ? in : (in < 5118 ? in-8 : (in < 7296 ? in : (in < 7297 ? in-6254 : (in < 7298 ? in-6253 : (in < 7299 ? in-6244 : (in < 7301 ? in-6242 : (in < 7302 ? in-6243 : (in < 7303 ? in-6236 : (in < 7304 ? in-6181 : (in < 7305 ? in+35266 : (in < 7545 ? in : (in < 7546 ? in+35332 : (in < 7549 ? in : (in < 7550 ? in+3814 : (in < 7566 ? in : (in < 7567 ? in+35384 : (in < 7681 ? in : (in < 7830 ? (0 == ((in-7681)%2) ? in-1 : in) : (in < 7831 ? in-7758 : (in < 7832 ? in-7747 : (in < 7833 ? in-7745 : (in < 7834 ? in-7744 : (in < 7835 ? in-7769 : (in < 7836 ? in-59 : (in < 7841 ? in : (in < 7936 ? (0 == ((in-7841)%2) ? in-1 : in) : (in < 7944 ? in+8 : (in < 7952 ? in : (in < 7958 ? in+8 : (in < 7968 ? in : (in < 7976 ? in+8 : (in < 7984 ? in : (in < 7992 ? in+8 : (in < 8000 ? in : (in < 8006 ? in+8 : (in < 8016 ? in : (in < 8017 ? in-7083 : (in < 8018 ? in+8 : (in < 8019 ? in-7085 : (in < 8020 ? in+8 : (in < 8021 ? in-7087 : (in < 8022 ? in+8 : (in < 8023 ? in-7089 : (in < 8024 ? in+8 : (in < 8032 ? in : (in < 8040 ? in+8 : (in < 8048 ? in : (in < 8050 ? in+74 : (in < 8054 ? in+86 : (in < 8056 ? in+100 : (in < 8058 ? in+128 : (in < 8060 ? in+112 : (in < 8062 ? in+126 : (in < 8064 ? in : (in < 8072 ? in-120 : (in < 8080 ? in-128 : (in < 8088 ? in-104 : (in < 8096 ? in-112 : (in < 8104 ? in-56 : (in < 8112 ? in-64 : (in < 8115 ? in+8 : (in < 8116 ? in-7202 : (in < 8117 ? in-7214 : (in < 8118 ? in : (in < 8119 ? in-7205 : (in < 8120 ? in-7206 : (in < 8124 ? in : (in < 8125 ? in-7211 : (in < 8126 ? in : (in < 8127 ? in-7205 : (in < 8130 ? in : (in < 8131 ? in+8 : (in < 8132 ? in-7212 : (in < 8133 ? in-7227 : (in < 8134 ? in : (in < 8135 ? in-7215 : (in < 8136 ? in-7216 : (in < 8140 ? in : (in < 8141 ? in-7221 : (in < 8144 ? in : (in < 8146 ? in+8 : (in < 8147 ? in-7225 : (in < 8148 ? in-7226 : (in < 8150 ? in : (in < 8151 ? in-7229 : (in < 8152 ? in-7230 : (in < 8160 ? in : (in < 8162 ? in+8 : (in < 8163 ? in-7229 : (in < 8164 ? in-7230 : (in < 8165 ? in-7235 : (in < 8166 ? in+7 : (in < 8167 ? in-7233 : (in < 8168 ? in-7234 : (in < 8178 ? in : (in < 8179 ? in+8 : (in < 8180 ? in-7242 : (in < 8181 ? in-7269 : (in < 8182 ? in : (in < 8183 ? in-7245 : (in < 8184 ? in-7246 : (in < 8188 ? in : (in < 8189 ? in-7251 : (in < 8526 ? in : (in < 8527 ? in-28 : (in < 8560 ? in : (in < 8576 ? in-16 : (in < 8580 ? in : (in < 9424 ? in : (in < 9450 ? in-26 : (in < 11312 ? in : (in < 11359 ? in-48 : (in < 11361 ? in : (in < 11365 ? in : (in < 11366 ? in-10795 : (in < 11367 ? in-10792 : (in < 11368 ? in : (in < 11379 ? in : (in < 11382 ? in : (in < 11393 ? in : (in < 11500 ? in : (in < 11507 ? in : (in < 11520 ? in : (in < 11558 ? in-7264 : (in < 11559 ? in : (in < 11560 ? in-7264 : (in < 11565 ? in : (in < 11566 ? in-7264 : (in < 42561 ? in : (in < 42625 ? in : (in < 42787 ? in : (in < 42803 ? in : (in < 42874 ? in : (in < 42879 ? in : (in < 42892 ? in : (in < 42897 ? in : (in < 42900 ? (0 == ((in-42897)%2) ? in-1 : in) : (in < 42901 ? in+48 : (in < 42903 ? in : (in < 42933 ? in : (in < 42947 ? in : (in < 42952 ? in : (in < 42998 ? in : (in < 43859 ? in : (in < 43860 ? in-928 : (in < 43888 ? in : (in < 43968 ? in-38864 : (in < 64256 ? in : (in < 64257 ? in-64186 : (in < 64258 ? in-64187 : (in < 64259 ? in-64188 : (in < 64260 ? in-64189 : (in < 64261 ? in-64190 : (in < 64262 ? in-64178 : (in < 64263 ? in-64179 : (in < 64275 ? in : (in < 64276 ? in-62927 : (in < 64277 ? in-62928 : (in < 64278 ? in-62929 : (in < 64279 ? in-62920 : (in < 64280 ? in-62931 : (in < 65345 ? in : (in < 65371 ? in-32 : (in < 66600 ? in : (in < 66640 ? in-40 : (in < 66776 ? in : (in < 66812 ? in-40 : (in < 68800 ? in : (in < 68851 ? in-64 : (in < 71872 ? in : (in < 71904 ? in-32 : (in < 93792 ? in : (in < 93824 ? in-32 : (in < 125218 ? in : (in < 125252 ? in-34 : (in))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));


// adapted from quicksort example OpenSCAD manual https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#Sorting_a_vector
function unf_matrix_sort(arr, sort_col_num) = !(len(arr)>0) ? [] : let(
  pivot   = arr[floor(len(arr)/2)],
  lesser  = [ for (y = arr) if (y[sort_col_num]  < pivot[sort_col_num]) y ],
  equal   = [ for (y = arr) if (y[sort_col_num] == pivot[sort_col_num]) y ],
  greater = [ for (y = arr) if (y[sort_col_num]  > pivot[sort_col_num]) y ]
) concat(
  unf_matrix_sort(lesser, sort_col_num), equal, unf_matrix_sort(greater, sort_col_num)
);

// Adapted from Mastering OpenSCAD https://mastering-openscad.eu/buch/introduction/
module unf_enbox(size=10000, extend_to_y=true, margin=0){
  module 1d(width=true){
    hull(){
      projection(){
	rotate(width ? [0, 90, 0] : [-90, 0, 0]){
	  linear_extrude(size) children([0:$children-1]);
	}
      }
    }
  }
  translate([margin, margin]){
    offset(delta=margin){
      intersection(){
	1d(true){
	  children([0:$children-1]);
	}
	union(){
	  hull(){
	    if (extend_to_y){ //ensure box goes to y axis b/c text has padding
	      square([0.001, size]);
	    }
	    1d(false){
	      children([0:$children-1]);
	    }
	  }
	}
      }
    }
  }
}

tv = ["H", "e", "l", "l", "o"];
echo (str("tv = ",tv));
ts = unf_vToS(tv);
echo (str("ts = unf_vToS(tv) = ", ts));
echo (str("unf_sub(tv, 1, 3) = ", unf_sub(tv, 1, 3)));
echo (str("unf_sub(ts, 1, 3) = ", unf_sub(ts, 1, 3)));
echo (str("unf_stToLower(ts) = ", unf_stToLower(ts)));
echo (str("unf_stToUpper(ts) = ", unf_stToUpper(ts)));
echo (str("unf_stToNum(\"10\") = ", unf_stToNum("10")));
echo (str("unf_stToNum(\"12.34\") = ", unf_stToNum("12.34")));
echo (str("unf_stToNum(\".1234\") = ", unf_stToNum(".1234")));
echo (str("unf_stToNum(\"0.456\") = ", unf_stToNum("0.456")));
echo (str("unf_stToNum(\"5/6\") = ", unf_stToNum("5/6")));
linear_extrude(1){
  unf_enbox(margin=2){
    text("Hello");
  }
}
color("red"){
  translate([0, 2, 0]){
    linear_extrude(2){
      text("Hello");
    }
  }
}



/**************************** Source of unf_ordToLower() & unf_ordToUpper() ************************************************

<?php

//https://stackoverflow.com/questions/9361303/can-i-get-the-unicode-value-of-a-character-or-vise-versa-with-php - retrieved 3/7/2022
function _uniord($c) {
    if (ord($c[0]) >=0 && ord($c[0]) <= 127)
        return ord($c[0]);
    if (ord($c[0]) >= 192 && ord($c[0]) <= 223)
        return (ord($c[0])-192)*64 + (ord($c[1])-128);
    if (ord($c[0]) >= 224 && ord($c[0]) <= 239)
        return (ord($c[0])-224)*4096 + (ord($c[1])-128)*64 + (ord($c[2])-128);
    if (ord($c[0]) >= 240 && ord($c[0]) <= 247)
        return (ord($c[0])-240)*262144 + (ord($c[1])-128)*4096 + (ord($c[2])-128)*64 + (ord($c[3])-128);
    if (ord($c[0]) >= 248 && ord($c[0]) <= 251)
        return (ord($c[0])-248)*16777216 + (ord($c[1])-128)*262144 + (ord($c[2])-128)*4096 + (ord($c[3])-128)*64 + (ord($c[4])-128);
    if (ord($c[0]) >= 252 && ord($c[0]) <= 253)
        return (ord($c[0])-252)*1073741824 + (ord($c[1])-128)*16777216 + (ord($c[2])-128)*262144 + (ord($c[3])-128)*4096 + (ord($c[4])-128)*64 + (ord($c[5])-128);
    if (ord($c[0]) >= 254 && ord($c[0]) <= 255)    //  error
        return FALSE;
    return 0;
}   //  function _uniord()


//https://stackoverflow.com/questions/9361303/can-i-get-the-unicode-value-of-a-character-or-vise-versa-with-php - retrieved 3/7/2022
function _unichr($o) {
    if (function_exists('mb_convert_encoding')) {
        return mb_convert_encoding('&#'.intval($o).';', 'UTF-8', 'HTML-ENTITIES');
    } else {
        return chr(intval($o));
    }
}   // function _unichr()
    
$toUpper = false;


$first = 0;
$diff = 0;
$last_diff = 0;
$parens = 0;
$stop = 0xFFFFFFFF;
for ($ord = 0; $ord <= $stop; $ord++){
    $char = _unichr($ord);
    $lower_char = $toUpper ? mb_strToUpper($char) : mb_strToLower($char);
    $lower_ord = _uniord($lower_char);
    $new_diff = $lower_ord - $ord;
    if (0 == $lower_ord || 63 == $lower_ord || 38 == $lower_ord){ //these seem to be junk
        $lower_char = $char;
        $lower_ord = $ord;
        $new_diff = 0;
    }
    if ($ord == $stop || $new_diff != $diff && (!((0==$new_diff&&1==abs($diff)&&0==$last_diff) || (1==abs($new_diff)&&0==$diff&&1==abs($last_diff))))){
        if ($ord < $stop){
            echo "in < {$ord} ? ";
        }
        switch ($diff){
            case 0:
                echo "in";
                break;
            case 1:
                echo "(0 == ((in-{$first})%2) ? in+1 : in)";
                break;
            case -1:
                echo "(0 == ((in-{$first})%2) ? in-1 : in)";
                break;
            default:
                echo 'in'.(0>$diff ? '' : '+').$diff;
                break;
        }
        if ($ord == $stop){
            for ($c = 0; $c < $parens; $c++){
                echo ")";
            }
        } else {
            echo " : (";
            $parens++;
            $first = $ord;
        }
    }
    $last_diff = $diff;
    $diff = $new_diff;
}
    
?> */
