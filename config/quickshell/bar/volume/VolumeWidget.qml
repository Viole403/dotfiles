import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Controls

import "./../"

Item {
  id: root
  
  implicitWidth: volumeText.implicitWidth + 10
  implicitHeight: volumeText.implicitHeight

  property PwNode sink: Pipewire.defaultAudioSink
  
  PwObjectTracker {
    objects: [ sink ]
  }

  function getVolumeIcon() {
    // FIX: Added !sink check to prevent reading properties of null
    if (!Pipewire.ready || !sink || !sink.audio) return "󰝟"
    if (sink.audio.muted) return "󰖁"

    var vol = sink.audio.volume

    if (vol >= 0.67) {
      return "󰕾"
    } else if (vol >= 0.33) {
      return "󰖀"
    } else {
      return "󰕿"
    }
  }

  function getTooltipText() {
    // FIX: Guard against null sink during startup
    if (!sink || !sink.audio) return "Connecting to audio..."
    
    return (sink.description ? sink.description + " · " : "") + (sink.audio.muted ? "Muted" : Math.round(sink.audio.volume * 100) + "%")
  }

  Text {
    id: volumeText
    anchors.centerIn: parent
    text: getVolumeIcon()
    font.family: "IntoneMono Nerd Font"
    font.pixelSize: 12
    color: "black"
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true

    onClicked: (event) => {
      // FIX: Ensure sink exists before attempting to toggle mute
      if (sink && sink.audio) {
          sink.audio.muted = !sink.audio.muted
      }
    }
  }

  ContextPopup {
    // FIX: Ensure popup only tries to render if sink is valid
    popupVisible: mouseArea.containsMouse && sink !== null

    Text {
      font.family: "Nunito"
      font.weight: Font.DemiBold
      anchors.centerIn: parent
      text: getTooltipText()
      color: "black"
    }
  }
}