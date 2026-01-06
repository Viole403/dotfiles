import Quickshell
import QtQuick
import Quickshell.Hyprland

Item {
  id: root

  implicitWidth: 200
  implicitHeight: appText.implicitHeight

  Text {
    id: appText
    anchors.left: parent.left
    anchors.verticalCenter: parent.verticalCenter
    width: parent.width - 20

    text: {
      if (Hyprland.activeToplevel) {
        // Get class from IPC object
        const appClass = Hyprland.activeToplevel.lastIpcObject?.class ||
                        Hyprland.activeToplevel.lastIpcObject?.initialClass ||
                        ""

        if (appClass) {
          // Try to find desktop entry by ID (with .desktop suffix)
          let desktopEntry = DesktopEntries.byId(appClass + ".desktop")

          // If not found, try heuristic lookup
          if (!desktopEntry) {
            desktopEntry = DesktopEntries.heuristicLookup(appClass)
          }

          // Return the friendly name if found, otherwise the class
          if (desktopEntry && desktopEntry.name) {
            return desktopEntry.name
          }

          // Fallback to class name
          return appClass
        }
      }
      return "Desktop"
    }

    font.family: "Nunito"
    font.weight: Font.DemiBold
    color: "black"
    elide: Text.ElideRight
  }
}
