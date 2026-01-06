import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Controls

import "./../"

Item {
  id: root
  
  implicitWidth: batteryText.implicitWidth + 10
  implicitHeight: batteryText.implicitHeight

  property var battery: UPower.displayDevice

  function getBatteryIcon() {
    if (!battery) return "󰂑"

    var charging = battery.state === UPowerDeviceState.Charging || battery.state === UPowerDeviceState.FullyCharged
    var percentage = battery.percentage * 100

    if (percentage > 95) {
      return charging ? "󰂅" : "󰁹"
    } else if (percentage > 85) {
      return charging ? "󰂋" : "󰂂"
    } else if (percentage > 75) {
      return charging ? "󰂊" : "󰂁"
    } else if (percentage > 65) {
      return charging ? "󰢞" : "󰂀"
    } else if (percentage > 55) {
      return charging ? "󰂉" : "󰁿"
    } else if (percentage > 45) {
      return charging ? "󰢝" : "󰁾"
    } else if (percentage > 35) {
      return charging ? "󰂈" : "󰁽"
    } else if (percentage > 25) {
      return charging ? "󰂇" : "󰁼"
    } else if (percentage > 15) {
      return charging ? "󰂆" : "󰁻"
    } else if (percentage > 5) {
      return charging ? "󰢜" : "󰁺"
    } else {
      return charging ? "󰢟" : "󰂎"
    }
  }

  function getBatteryColor() {
    if (!battery) return "red"

    var isCharging = battery.state === UPowerDevice.Charging || battery.state === UPowerDevice.FullyCharged

    if (battery.percentage > 0.15 && battery.percentage < 0.25 && !isCharging) {
      return "darkred"
    } else if (battery.percentage <= 0.15 && !isCharging) {
      return "red"
    }
    return "black"
  }

  function formatTime(seconds) {
    if (seconds <= 0) return "Unknown"

    var hours = Math.floor(seconds / 3600)
    var minutes = Math.floor((seconds % 3600) / 60)

    if (hours > 0) {
      return hours + "h " + minutes + "m"
    } else {
      return minutes + "m"
    }
  }

  function getTooltipText() {
    if (!battery) return "No battery detected"
    
    var percentage = Math.round(battery.percentage * 100)
    var tooltipText = percentage + "%"
    
    if (battery.state === UPowerDeviceState.Charging) {
      if (battery.timeToFull > 0) {
        tooltipText += " - " + formatTime(battery.timeToFull) + " until full"
      }
    } else if (battery.state === UPowerDeviceState.Discharging) {
      if (battery.timeToEmpty > 0) {
        tooltipText += " - " + formatTime(battery.timeToEmpty) + " remaining"
      }
    }
    
    return tooltipText
  }

  Text {
    id: batteryText
    anchors.centerIn: parent
    text: getBatteryIcon()
    font.family: "IntoneMono Nerd Font"
    font.pixelSize: 12
    color: getBatteryColor()
  }

  MouseArea {
    id: mouseArea
    anchors.fill: parent
    hoverEnabled: true
  }

  ContextPopup {
    popupVisible: mouseArea.containsMouse

    Text {
      font.family: "Nunito"
      font.weight: Font.DemiBold
      anchors.centerIn: parent
      text: getTooltipText()
      color: "black"
    }
  }
}
