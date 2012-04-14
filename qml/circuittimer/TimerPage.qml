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
import com.nokia.extras 1.0
import QtMobility.systeminfo 1.1

import Settings 1.0

import "Constants.js" as Const
import "Utils.js" as Utils

Page {
    id: timerPage

    function start() {
        state = "exercising"
        myTimer.countDown = settings.workTime
        myTimer.repeatCount = 1
        myTimer.start()
        myTimer.totalTime = mainPage.totalTime()
        myTimer.playSound(startSound)
    }

    orientationLock: PageOrientation.LockPortrait

    tools: ToolBarLayout {

        LabeledSwitch {
            id: screenSaverSwitch
            text: qsTr("Disable screen saver")
            anchors.centerIn: parent
        }
    }

    Rectangle {
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0.0; color: "grey" }
            GradientStop { position: 0.45; color: "black" }
        }
    }

    NotificationSound {
        id: startSound
        source: settings.sounds === 1 ? "sounds/start.wav" : "sounds/longBeep.wav"
    }

    NotificationSound {
        id: stopSound
        source: settings.sounds === 1 ? "sounds/stop.wav" : "sounds/longBeep.wav"
    }

    NotificationSound {
        id: readySound
        source: settings.sounds === 1 ? "sounds/getready.wav" : "sounds/shortBeep.wav"
    }


    NotificationSound {
        id: almostSound
        source: settings.sounds === 1 ? "sounds/almostdone.wav" : "sounds/shortBeepSequence.wav"
    }

    NotificationSound {
        id: switchSound
        source: settings.sounds === 1 ? "sounds/switch.wav" : "sounds/longBeep.wav"
    }

    ScreenSaver {
        id: screenSaverControl
        screenSaverInhibited: screenSaverSwitch.checked && (timerPage.status === PageStatus.Active)
    }

    TimeLabel {
        id: timerTextLabel
        captionText: timerPage.state === "exercising" ? qsTr("Exercise") : qsTr("Pause")
        timeText: Utils.toTime(myTimer.countDown)
        captionPixelSize: Const.fontLarge
        timePixelSize: Const.fontGinormous

        anchors {
            top: parent.top
            topMargin: Const.bigMargin
            horizontalCenter: parent.horizontalCenter
        }
    }

    TimeLabel {
        id: remainingTimeLabel
        captionText: qsTr("Remaining")
        timeText: Utils.toTime(myTimer.totalTime)

        anchors {
            top: timerTextLabel.bottom
            topMargin: Const.margin
            left: parent.left
            leftMargin: Const.margin
        }
    }

    TimeLabel {
        id: roundsLabel
        captionText: qsTr("Rounds")
        timeText: myTimer.repeatCount + "/" + settings.rounds

        anchors {
            top: remainingTimeLabel.top
            horizontalCenter: parent.horizontalCenter
        }
    }

    TimeLabel {
        id: elapsedTimeLabel
        captionText: qsTr("Elapsed")
        timeText: Utils.toTime(mainPage.totalTime() - myTimer.totalTime)

        anchors {
            top: remainingTimeLabel.top
            right: parent.right
            rightMargin: Const.margin
        }
    }

    Button {
        id: pauseButton
        text: myTimer.running? qsTr("Pause") : qsTr("Resume")
        anchors {
            top: roundsLabel.bottom
            topMargin: Const.bigMargin
            left: parent.left
            leftMargin: Const.margin
        }
        onClicked: { myTimer.running = !myTimer.running }
        width: Const.buttonWidth
    }

    Button {
        id: stopButton
        text: qsTr("Stop")
        anchors {
            top: pauseButton.top
            right: parent.right
            rightMargin: Const.margin
        }
        style: NegativeButtonStyle {}
        width: Const.buttonWidth
        onClicked: { myTimer.stop(); pageStack.pop() }
    }

    Timer {
        id: myTimer

        function playSound(sound)
        {
            if (settings.sounds !== 0)
                sound.play()
        }

        property int countDown
        property int repeatCount
        property int totalTime

        interval: 1000
        repeat: true
        onTriggered: {
            countDown--
            totalTime--

            if (countDown === 5)
            {
                if(timerPage.state === "recovering")
                    playSound(readySound)
                else
                    playSound(almostSound)
            }

            if (countDown === 0) {
                if (timerPage.state === "exercising") {
                    if ((settings.breakTime !== 0) || (repeatCount ===  settings.rounds))
                        playSound(stopSound)
                    else
                        playSound(switchSound)

                    if (repeatCount ===  settings.rounds) {
                        parent.state = ""
                        stop()
                        pageStack.pop()
                    }
                    else {
                        if (settings.breakTime !== 0) {
                            timerPage.state = "recovering"
                            countDown = settings.breakTime
                        }
                        else {
                            countDown = settings.workTime
                            repeatCount++
                        }

                    }
                }
                else {
                    playSound(startSound)
                    timerPage.state = "exercising"
                    countDown = settings.workTime
                    repeatCount++
                }
            }
        }
    }


    states: [
        State {
            name: "exercising"
        },
        State {
            name: "recovering"
        }
    ]

}
