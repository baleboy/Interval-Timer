import QtQuick 1.1
import com.nokia.extras 1.0
import Settings 1.0

TumblerDialog {
    id: root

    property string selected: soundList.get(soundColumn.selectedIndex).name

    ListModel {
        id: soundList

        ListElement {
            name: "None"
        }
        ListElement {
            name: "Voice"
        }
        ListElement {
            name: "Beep"
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
