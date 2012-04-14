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
