import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Services.SystemTray;
import QtQuick.Layouts

import "."
import "./.."

Item {
  id: root

  implicitWidth:  rowLayout.implicitWidth
  implicitHeight: rowLayout.implicitHeight

  RowLayout {
    id: rowLayout
    spacing: 10
    layoutDirection: Qt.LeftToRight
    anchors.fill: parent

    Repeater {
      model: SystemTray.items;

      Rectangle {
        id: item

	  		Layout.preferredWidth:  16
	  		Layout.preferredHeight: 16

        color: "transparent"

        // ContextPopup {
        //   popupVisible: mouseArea.containsMouse
        //   Text { text: "I'm visible!" }
        //   // TrayTooltip {
        //   //   id: menu
        //   // }
        // }

        QsMenuAnchor {
          id: menuAnchor
          anchor.item: item
          anchor.gravity: Edges.Bottom | Edges.Left
          menu: modelData.menu
        }

        MouseArea {
          id: mouseArea

          hoverEnabled: true
          anchors.fill: parent
          acceptedButtons: Qt.LeftButton | Qt.RightButton
          onClicked: (event) => {
            switch (event.button) {
              case Qt.LeftButton:
                  modelData.activate();
                  break;
              case Qt.RightButton:
                  menuAnchor.open()
                  break;
            }
            event.accepted = true;
          }
        }

        Image {
	  	  	 width:             parent.width
	  	  	 height:            parent.height
	  	  	 antialiasing:      true
	  	  	 source:            modelData.icon
	  	  	 sourceSize.width:  width
	  	  	 sourceSize.height: height
           anchors.centerIn:  parent
           fillMode:          Image.PreserveAspectFit
           smooth:            true

           // Fallback for missing icons
           Rectangle {
             anchors.fill: parent
             visible: parent.status === Image.Error || parent.status === Image.Null
             color: "#89b4fa"
             radius: 3

             Text {
               anchors.centerIn: parent
               text: "?"
               color: "white"
               font.pixelSize: 10
               font.bold: true
             }
           }
	  	  }
      }
    }
  }
}
