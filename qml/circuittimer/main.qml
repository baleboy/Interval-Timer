import QtQuick 1.1
import com.nokia.meego 1.0
import Settings 1.0

PageStackWindow {
    id: appWindow

    initialPage: mainPage

    MainPage {
        id: mainPage
    }

    TimerPage {
        id: timerPage
    }

    Settings {
        id: settings
    }

    Component.onCompleted: theme.inverted = true
}
