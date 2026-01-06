import Quickshell
import QtQuick
import QtQuick.Controls
import Quickshell.Hyprland
import QtQuick.Layouts

import "."

Item {
  id: root

  implicitWidth:  rowLayout.implicitWidth
  implicitHeight: rowLayout.implicitHeight

  RowLayout {
    id: rowLayout
    spacing: 2
    anchors.fill: parent

    Repeater {
      // Show workspaces 1-10 (change to 19 if you want more)
      model: 10

      Rectangle {
        id: item

        Layout.preferredWidth:  26
        Layout.preferredHeight: 16

        radius: 4

        property var workspace: {
          // Find the workspace object for this index
          const ws = Hyprland.workspaces.values.find(w => w.id === index + 1)
          return ws || null
        }

        property bool isFocused: workspace ? workspace.focused : false
        property bool hasWindows: workspace ? workspace.toplevels.values.length > 0 : false
        property bool isUrgent: workspace ? workspace.urgent : false

        // Visual styling based on workspace state
        color: {
          if (isFocused) return "#89b4fa"  // Blue for focused workspace
          if (hasWindows) return "#585b70"  // Gray for workspace with windows
          return "transparent"              // Transparent for empty workspace
        }

        border.color: isFocused ? "#cba6f7" : "#45475a"
        border.width: 1

				MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor

					onClicked: {
            // Use dispatch to switch workspace (single argument as "workspace N")
						Hyprland.dispatch("workspace " + (index + 1))
					}
				}

        // Icon or number display
        Item {
          anchors.centerIn: parent
          width: 14
          height: 14

          // Try to show icon if workspace has windows
          Image {
            id: appIcon
            anchors.fill: parent
            visible: hasWindows && source != ""
            fillMode: Image.PreserveAspectFit
            smooth: true

            source: {
              if (!hasWindows || !workspace) return ""

              const toplevels = workspace.toplevels.values
              if (!toplevels || toplevels.length === 0) return ""

              const firstWindow = toplevels[0]
              if (!firstWindow || !firstWindow.lastIpcObject) return ""

              const appClass = firstWindow.lastIpcObject.class ||
                              firstWindow.lastIpcObject.initialClass || ""

              if (appClass) {
                // Try to find desktop entry and get icon
                const desktopEntry = DesktopEntries.byId(appClass + ".desktop") ||
                                    DesktopEntries.heuristicLookup(appClass)

                if (desktopEntry && desktopEntry.icon) {
                  return "image://icon/" + desktopEntry.icon
                }
              }
              return ""
            }
          }

          // Fallback to number if no icon
          Text {
            visible: !appIcon.visible
            anchors.centerIn: parent
            text: index + 1
            font.family: "Nunito"
            font.weight: isFocused ? Font.Bold : Font.DemiBold
            font.pixelSize: 10
            color: {
              if (isUrgent) return "red"
              if (isFocused) return "black"
              if (hasWindows) return "white"
              return "#6c7086"  // Dim for empty workspaces
            }
          }
        }
      }
    }
  }
}
