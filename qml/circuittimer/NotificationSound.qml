import QtQuick 1.1
import QtMultimediaKit 1.1
import QtMobility.feedback 1.1
import QtMobility.systeminfo 1.1
import Policy 1.0 // exported in main.cpp
import Settings 1.0

Item {

    property alias source: sound.source
    property alias volume: sound.volume

    function play() {
        if (deviceInfo.currentProfile !== DeviceInfo.SilentProfile)
            audioResource.acquire()
        else // don't acquire the resource or the music will break for nothing
            if (settings.vibra)
                vibra.start()
    }

    ResourceHandler {
        id: audioResource
    }

    DeviceInfo {
        id: deviceInfo
        monitorCurrentProfileChanges:true
    }

    SoundEffect {
        id: sound
        volume: 1.0
        onPlayingChanged: if (!playing) audioResource.release()
    }

    HapticsEffect {
        id: vibra
        attackIntensity: 0.0
        attackTime: 250
        intensity: 1.0
        duration: 500
        fadeTime: 250
        fadeIntensity: 0.0
    }

    Connections {
        target: audioResource
        onAcquired: { console.log("playing") ; sound.play(); if (settings.vibra) vibra.start() }
    }
}
