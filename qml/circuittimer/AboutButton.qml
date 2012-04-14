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
import com.nokia.meego 1.0

ToolIcon {

    iconSource: "images/info.png"

    onClicked: query.open()

    QueryDialog {
        id: query

        icon: "images/icon.png"
        titleText: "Interval Timer 1.1"
        message: "(c) 2012 Francesco Balestrieri and Jarkko Autio\n\nSounds and icon by Eric Le Roux"

        acceptButtonText: "Send Feedback"
        onAccepted: Qt.openUrlExternally("mailto:bale@balenet.com?subject=Feedback about Interval Timer 1.1")
        rejectButtonText: "Close"
    }
}
