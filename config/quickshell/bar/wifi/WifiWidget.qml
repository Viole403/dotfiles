import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Controls

import "./.."

Item {
  id: root

  implicitWidth: wifiText.implicitWidth + 10
  implicitHeight: wifiText.implicitHeight

  property int strength: 0
  property int gsmIndex: 0
  property string network: ""

  property bool isGSM:        false
  property bool viewNetworks: false

  function getWifiIcon() {
    if (!network) return isGSM ? "󰣼" : "󰤭"

    if (strength >= 90) {
      return isGSM ? "󰣺" : "󰤨"
    } else if (strength >= 70) {
      return isGSM ? "󰣸" : "󰤥"
    } else if (strength >= 40) {
      return isGSM ? "󰣶" : "󰤢"
    } else if (strength >= 10) {
      return isGSM ? "󰣴" : "󰤟"
    } else {
      return isGSM ? "󰣾" : "󰤯"
    }
  }

  function getTooltipText() {
    return root.network + " · " + root.strength + "%"
  }

  Process {
    id: getActiveConnections
    command: ["sh", "-c", "nmcli -t -f TYPE,STATE con show --active | grep ':activated$' | head -n1 | cut -d: -f1"]
    running: true
    stdout: StdioCollector {
      onStreamFinished: {
        var type = this.text.trim()
        if (type == "802-11-wireless") {
          root.isGSM = false
          setStrength.running = true
          setNetwork.running = true
        }
        else if (type == "gsm") {
          root.isGSM = true
          getGSMIndex.running = true
        }
      }
    }
  }

  Process {
    id: getGSMIndex
    command: ["sh", "-c", "mmcli -L | grep -o '/Modem/[0-9]*' | grep -o '[0-9]*'"]
    running: false
    stdout: StdioCollector {
      onStreamFinished: {
        root.gsmIndex = this.text.trim()
        setStrength.running = true
        setNetwork.running = true
      }
    }
  }

  Process {
    id: setStrength
    // use mmcli or qmicli for modem
    command: ["sh", "-c", isGSM
      ? "mmcli -m " + root.gsmIndex + " | grep 'signal quality' | grep -o '[0-9]*'"
      : "nmcli -f IN-USE,SIGNAL device wifi | grep '*' | grep -o '[0-9]*'"]
    running: false
    stdout: StdioCollector {
      onStreamFinished: root.strength = this.text.trim()
    }
  }

  Process {
    id: setNetwork
    command: ["sh", "-c",  isGSM
      ? "mmcli -m " + root.gsmIndex + " | grep 'operator name' | cut -d: -f2"
      : "nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2"]
    running: false
    stdout: StdioCollector {
      onStreamFinished: root.network = this.text.trim()
    }
  }

  Timer {
    interval: 60000
    running: true
    repeat: true

    onTriggered: {
      getActiveConnections.running = true
    }
  }

  Text {
    id: wifiText
    anchors.centerIn: parent
    text: getWifiIcon()
    font.family: "IntoneMono Nerd Font"
    font.pixelSize: 12
    color: "black"
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true

    onClicked: (event) => {
      root.viewNetworks = !root.viewNetworks
    }
  }

  ContextPopup {
    popupVisible: mouseArea.containsMouse || root.viewNetworks

    Text {
      font.family: "Nunito"
      font.weight: Font.DemiBold
      anchors.centerIn: parent
      text: getTooltipText()
      color: "black"
    }
  }
}
