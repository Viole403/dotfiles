import Quickshell
import QtQuick
import Quickshell.Widgets

Item {
  id: root

  anchors.centerIn: parent
  implicitWidth:    25
  implicitHeight:   25

  // children go here
  default property alias content: contentItem.children
  property alias popupVisible: popup.visible

  Rectangle {
    anchors.fill: parent
    color: "transparent"

    PopupWindow {
      id: popup
      anchor.item: root
      anchor.edges: Edges.Bottom | Edges.Right
      anchor.gravity: Edges.Bottom | Edges.Left
      anchor.adjustment: PopupAdjustment.FlipY
      color: "transparent"

      implicitWidth: contentItem.implicitWidth + 8
      implicitHeight: contentItem.implicitHeight + 8

      Rectangle {
        color: "white"
        anchors.fill: parent
        radius: 4

        WrapperItem {
          id: contentItem
          anchors.centerIn: parent
        }
      }
    }
  }
}
