import QtQuick 1.1
import com.nokia.extras 1.0
import Settings 1.0

TumblerDialog {
    id: root

    TumblerColumn {
        id: repeatsColumn
        items: repeatsList
    }

    ListModel {
        id: repeatsList
        Component.onCompleted: {
            for (var i =  1 ; i < 100 ; i++) repeatsList.append({"value": i})
            repeatsColumn.selectedIndex = settings.rounds - 1
            console.log("round index at startup: " + repeatsColumn.selectedIndex)
            console.log("rounds at startup: " + repeatsList.get(repeatsColumn.selectedIndex).value)
        }
    }



    titleText: qsTr("Number of repeats")
    columns: [ repeatsColumn ]
    acceptButtonText: qsTr("Ok")
    rejectButtonText: qsTr("Cancel")

    onAccepted: {
        console.log("new rounds: " + repeatsList.get(repeatsColumn.selectedIndex).value)
        settings.rounds = repeatsList.get(repeatsColumn.selectedIndex).value
    }
}

