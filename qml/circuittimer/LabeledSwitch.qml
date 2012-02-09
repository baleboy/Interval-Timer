import QtQuick 1.1
import com.nokia.meego 1.0
import "Constants.js" as Const

Item {

    property alias checked: onOff.checked
    property alias text: switchText.text

    width: switchText.width + onOff.width + Const.margin
    height: onOff.height

    Label {
        id: switchText
        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
        }
    }

    Switch {
        id: onOff
        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
        }
    }
}

