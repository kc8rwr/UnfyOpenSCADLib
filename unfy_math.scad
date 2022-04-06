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

//A rounding function that allows rounding to places other than ones
function unf_round(num, place=0) = round(num / pow(10, place)) * pow(10, place);

echo(str("unf_round(52.43, 3)=", unf_round(52.43, 3)));
echo(str("unf_round(52.43, 2)=", unf_round(52.4, 2)));
echo(str("unf_round(52.43, 1)=", unf_round(52.4, 1)));
echo(str("unf_round(52.43)=", unf_round(52.43)));
echo(str("unf_round(52.43, -1)=", unf_round(52.43, -1)));
echo(str("unf_round(52.43, -2)=", unf_round(52.43, -2)));
echo(str("unf_round(52.43, -3)=", unf_round(52.43, -3)));
