/*

Copyright (C) 2012 Francesco Balestrieri

This file is part of Interval Timer for N9

Interval Timer for N9 is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Interval Timer for N9 is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Interval Timer for N9.  If not, see <http://www.gnu.org/licenses/>.

*/


.pragma library

function zeroPad(n)
{
    return (n < 10 ? "0" : "") + n
}

function toTime(sec)
{
    var mod = Math.abs(sec)
    return (sec < 0 ? "-" : "") +
            (mod >= 3600 ? Math.floor(mod / 3600) + ':' : '') +
            zeroPad(Math.floor((mod % 3600) / 60)) + ':' +
            zeroPad(Math.floor((mod % 60)))
}
