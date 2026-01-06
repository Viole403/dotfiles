import Quickshell         // for PanelWindow
import Quickshell.Io      // for Process
import QtQuick            // for Text
import QtQuick.Layouts

import Quickshell.Services.SystemTray

import "./clock/"
import "./battery/"
import "./tray/"
import "./workspace/"
import "./wifi/"
import "./volume/"
import "./activewindow/"
import "./mpris/"

import "."

Scope {
  Variants {
    model: Quickshell.screens;

    PanelWindow {
      required property var modelData
      screen: modelData

      color: "#bbffffff"

      anchors {
        top: true
        left: true
        right: true
      }

      margins {
        left: 4
        right: 4
        top: 4
      }

      implicitHeight: 25

      // Left side - Active window and MPRIS
      RowLayout {
        layoutDirection: Qt.LeftToRight
        spacing: 10

        anchors {
          left: parent.left
          leftMargin: 10
          verticalCenter: parent.verticalCenter
        }

        ActiveWindowWidget { }

        MprisWidget { }
      }

      // Center - Workspaces only
      RowLayout {
        layoutDirection: Qt.LeftToRight
        spacing: 0

        anchors {
          horizontalCenter: parent.horizontalCenter
          verticalCenter: parent.verticalCenter
        }

        WorkspaceWidget { }
      }

      RowLayout {
        layoutDirection: Qt.LeftToRight
        spacing: 10

        anchors {
          right: parent.right
          rightMargin: 10
          verticalCenter: parent.verticalCenter
        }

        ClockWidget { }

        VolumeWidget { }

        WifiWidget { }

        BatteryWidget { }
      }

      // Clock is moved into the left RowLayout next to WorkspaceWidget
    }
  }
}
