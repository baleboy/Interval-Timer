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
import com.nokia.extras 1.0
import Settings 1.0

TumblerDialog {
    id: root

    property string selected: soundList.get(soundColumn.selectedIndex).value

    ListModel {
        id: soundList

        ListElement {
            value: "None"
        }
        ListElement {
            value: "Voice"
        }
        ListElement {
            value: "Beep"
        }
    }

    TumblerColumn {
        id: soundColumn
        items: soundList
    }

    titleText: "Audio cues"
    columns: [ soundColumn ]
    acceptButtonText: qsTr("Ok")
    rejectButtonText: qsTr("Cancel")

    onAccepted: {
        console.log("new sound: " + soundColumn.selectedIndex )
        settings.sounds = soundColumn.selectedIndex
    }

    Component.onCompleted: {
        soundColumn.selectedIndex = settings.sounds
        console.log("sound at startup: " + settings.sounds )
    }
}
