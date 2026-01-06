pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
  id: root
  readonly property string time: {
    // The passed format string matches the default output of
    // the `date` command.
    Qt.formatDateTime(clock.date, "dddd d MMMM · hh:mm")
  }

  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
