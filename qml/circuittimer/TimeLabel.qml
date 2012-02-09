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


