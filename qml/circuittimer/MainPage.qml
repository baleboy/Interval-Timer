import QtQuick 1.1
import com.nokia.meego 1.0
import com.nokia.extras 1.0
import Settings 1.0

import "Constants.js" as Const
import "Utils.js" as Utils

Page {

    id: mainPage

    function dialogTime(dialog) {
        return dialog.minute * 60 + dialog.second
    }

    function totalTime() {
        return (settings.rounds - 1)*(settings.breakTime + settings.workTime) +
                                    settings.workTime
    }

    orientationLock: PageOrientation.LockPortrait

    SoundDialog {
        id: soundDialog
    }

    RoundsDialog {
        id: roundsDialog
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "grey" }
            GradientStop { position: 0.15; color: "black" }
        }
    }

    Label {
        id: title
        text: qsTr("Interval Timer")
        anchors {
            top: parent.top
            topMargin: Const.margin
            left: parent.left
            leftMargin: Const.margin
        }
        font.pixelSize: Const.fontLarge
    }

    AboutButton {
        anchors {
            top: parent.top
            topMargin: 3
            right: parent.right
        }
    }


    Column {

        id: buttonCol

        spacing: Const.spacing
        anchors {
            top: title.bottom
            topMargin: Const.bigMargin
            horizontalCenter: parent.horizontalCenter
        }

        TumblerButton {
            id: button2
            text: qsTr("Exercise for ") + Utils.toTime(settings.workTime)
            width: Const.tumblerButtonWidth
            onClicked: exerciseDialog.open()
        }

        TumblerButton {
            id: button3
            text: settings.breakTime !== 0 ? (qsTr("Rest for ") + Utils.toTime(settings.breakTime)) :
                                             qsTr("No rest")
            width: Const.tumblerButtonWidth
            onClicked: recoveryDialog.open()
            enabled: settings.rounds > 1
        }

        TumblerButton {
            id: button1
            text: settings.rounds > 1 ? qsTr("Repeat ") + settings.rounds + qsTr(" times") : qsTr("No repeats")
            width: Const.tumblerButtonWidth
            onClicked: roundsDialog.open()
        }

        TumblerButton {
            id: button4
            text: qsTr("Audio cues: ") + soundDialog.selected
            width: Const.tumblerButtonWidth
            onClicked: soundDialog.open()
        }

        LabeledSwitch {
            id: switch1
            text: qsTr("Vibration")
            anchors.horizontalCenter: parent.horizontalCenter
            onCheckedChanged: settings.vibra = checked
            Component.onCompleted: checked = settings.vibra
        }
    }

    TimeLabel {
        id: totalTimeLabel
        captionText: qsTr("Total time")
        timeText: Utils.toTime(totalTime())
        captionPixelSize: Const.fontMedium
        timePixelSize: Const.fontHuge

        anchors {
            top: buttonCol.bottom
            topMargin: Const.bigMargin
            horizontalCenter: parent.horizontalCenter
        }
    }

    Button{
        id: startButton
        anchors {
            top: totalTimeLabel.bottom
            topMargin: Const.margin
            horizontalCenter: parent.horizontalCenter
        }
        text: qsTr("Start!")
        onClicked: { pageStack.push(timerPage); timerPage.start() }
        width: Const.buttonWidth
        style: PositiveButtonStyle {}
    }


    TimePickerDialog {
         id: exerciseDialog
         titleText: "Exercise time"
         acceptButtonText: qsTr("Ok")
         rejectButtonText: qsTr("Cancel")
         fields: DateTime.Minutes | DateTime.Seconds
         minute: settings.workTimeMin
         second: settings.workTimeSec

         onAccepted: {
             if ((minute !== 0) || (second !== 0)) {
                 settings.workTimeMin = minute
                 settings.workTimeSec = second
             }
         }
    }

    TimePickerDialog {
         id: recoveryDialog
         titleText: "Recovery time"
         acceptButtonText: qsTr("Ok")
         rejectButtonText: qsTr("Cancel")
         fields: DateTime.Minutes | DateTime.Seconds
         minute: settings.breakTimeMin
         second: settings.breakTimeSec

         onAccepted: {
             settings.breakTimeMin = minute
             settings.breakTimeSec = second
         }
    }

}
