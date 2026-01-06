import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

// Tooltip for system tray items
Rectangle {
    id: root

    property string text: ""

    implicitWidth: tooltipText.implicitWidth + 16
    implicitHeight: tooltipText.implicitHeight + 12

    color: "#eff1f5"
    radius: 6
    border.color: "#bcc0cc"
    border.width: 1

    Text {
        id: tooltipText
        anchors.centerIn: parent
        text: root.text
        font.pixelSize: 11
        color: "#4c4f69"
    }
}
