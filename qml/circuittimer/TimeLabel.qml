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


import QtQuick 1.1
import "Constants.js" as Const

Item {

    id: root

    property alias timeText: time.text
    property alias captionText: caption.text

    property alias timePixelSize: time.font.pixelSize
    property alias captionPixelSize: caption.font.pixelSize

    property int margin: Const.smallMargin

    height: caption.height + margin + time.height
    width: Math.max(caption.width, time.width)

    Text {
        id: caption
        font.family: "Nokia Pure Text"
        color: "white"
        font.pixelSize: Const.fontSmall

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
        }
    }

    Text {
        id: time
        font.family: "Nokia Pure Text T"
        color: "white"
        font.pixelSize: Const.fontLarge

        anchors {
            top: caption.bottom
            topMargin: margin
            horizontalCenter: parent.horizontalCenter
        }
    }
}


