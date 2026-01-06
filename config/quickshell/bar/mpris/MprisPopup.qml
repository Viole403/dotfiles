import QtQuick
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects
import Quickshell.Services.Mpris

Rectangle {
    id: root

    property var player: null
    readonly property bool hasPlayer: player !== null

    implicitWidth: 358
    implicitHeight: 140
    color: "#eff1f5"
    radius: 12

    function formatTime(seconds) {
        if (!seconds || seconds < 0) return "0:00"
        const mins = Math.floor(seconds / 60)
        const secs = Math.floor(seconds % 60)
        return mins + ":" + (secs < 10 ? "0" : "") + secs
    }

    RowLayout {
        anchors {
            fill: parent
            leftMargin: 12
            rightMargin: 12
            topMargin: 12
            bottomMargin: 12
        }
        spacing: 12

        // Album art (left side, bordered)
        Rectangle {
            Layout.preferredWidth: 100
            Layout.preferredHeight: 100
            color: "#ccd0da"
            radius: 6
            border.color: "#9399b2"
            border.width: 1

            Image {
                anchors.fill: parent
                anchors.margins: 1
                source: player?.trackArtUrl ?? ""
                fillMode: Image.PreserveAspectCrop

                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Item {
                        width: 100
                        height: 100
                        Rectangle {
                            anchors.centerIn: parent
                            width: parent.width
                            height: parent.height
                            radius: 5
                        }
                    }
                }
            }

            Text {
                anchors.centerIn: parent
                text: "🎵"
                font.pixelSize: 32
                visible: parent.children[0].status !== Image.Ready
            }
        }

        // Right side: all controls stacked vertically
        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 4

            // Row 1: Title + Play/Pause button
            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                Text {
                    Layout.fillWidth: true
                    text: player?.trackTitle ?? "Unknown Title"
                    font.pixelSize: 14
                    font.weight: Font.DemiBold
                    color: "#4c4f69"
                    elide: Text.ElideRight
                }

                Rectangle {
                    width: 32
                    height: 32
                    radius: 16
                    color: playMouse.containsMouse ? "#e6e9ef" : "transparent"

                    MouseArea {
                        id: playMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: player?.togglePlaying()
                    }

                    Text {
                        anchors.centerIn: parent
                        text: player?.isPlaying ? "⏸" : "▶"
                        font.pixelSize: 16
                        color: "#4c4f69"
                    }
                }
            }

            // Row 2: Artist
            Text {
                Layout.fillWidth: true
                text: player?.trackArtist ?? "Unknown Artist"
                font.pixelSize: 12
                color: "#6c6f85"
                elide: Text.ElideRight
            }

            // Row 3: Time + Volume icon + Volume slider
            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                Text {
                    text: formatTime(player?.position ?? 0) + " / " + formatTime(player?.length ?? 0)
                    font.pixelSize: 10
                    color: "#6c6f85"
                    Layout.preferredWidth: 70
                }

                Text {
                    // These hex codes correspond to Nerd Font symbols
                    // \uf026 = Vol Off, \uf027 = Vol Down, \uf028 = Vol Up
                    text: {
                        if (!player) return "\uf026"
                        const vol = player.volume
                        if (vol === 0) return "\ufb5e" // Muted Speaker icon
                        if (vol < 0.5) return "\uf027" // Volume Low
                        return "\uf028"                // Volume High
                    }

                    // Crucial: Set the family to the Nerd Font you installed
                    font.family: "Symbols Nerd Font"
                    font.pixelSize: 16
                    color: "#4c4f69"

                    // Optional: Add a MouseArea to toggle mute
                    MouseArea {
                        anchors.fill: parent
                        onClicked: if(player) player.volume = (player.volume > 0 ? 0 : 0.5)
                    }
                }

                // Volume slider
                Rectangle {
                    Layout.fillWidth: true
                    height: 4
                    color: "#ccd0da"
                    radius: 2

                    Rectangle {
                        width: parent.width * (player?.volume ?? 0)
                        height: parent.height
                        color: "#89b4fa"
                        radius: 2
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: (mouse) => {
                            if (player && player.volumeSupported) {
                                player.volume = mouse.x / width
                            }
                        }
                        onPositionChanged: (mouse) => {
                            if (pressed && player && player.volumeSupported) {
                                player.volume = Math.max(0, Math.min(1, mouse.x / width))
                            }
                        }
                    }
                }
            }

            // Row 4: Previous + Progress + Next
            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                // Previous button
                Rectangle {
                    width: 32 // Increased slightly for better click area
                    height: 32
                    radius: 16
                    color: (player?.canGoPrevious ?? false) ? (prevMouse.containsMouse ? "#e6e9ef" : "transparent") : "transparent"
                    opacity: (player?.canGoPrevious ?? false) ? 1 : 0.4

                    MouseArea {
                        id: prevMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: (player?.canGoPrevious ?? false) ? Qt.PointingHandCursor : Qt.ArrowCursor
                        enabled: player?.canGoPrevious ?? false
                        onClicked: player?.previous()
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "\uf048" // Nerd Font: Backward/Skip Back
                        font.family: "Symbols Nerd Font"
                        font.pixelSize: 16
                        color: "#4c4f69"
                    }
                }

                // Progress slider
                Rectangle {
                    Layout.fillWidth: true
                    height: 4
                    color: "#ccd0da"
                    radius: 2

                    Rectangle {
                        width: parent.width * ((player?.position ?? 0) / Math.max(1, player?.length ?? 1))
                        height: parent.height
                        color: "#89b4fa"
                        radius: 2
                    }

                    MouseArea {
                        anchors.fill: parent
                        enabled: player?.canSeek ?? false
                        onClicked: (mouse) => {
                            if (player && player.canSeek) {
                                player.position = (mouse.x / width) * player.length
                            }
                        }
                        onPositionChanged: (mouse) => {
                            if (pressed && player && player.canSeek) {
                                player.position = Math.max(0, Math.min(1, mouse.x / width)) * player.length
                            }
                        }
                    }
                }

                // Next button
                Rectangle {
                    width: 32
                    height: 32
                    radius: 16
                    color: (player?.canGoNext ?? false) ? (nextMouse.containsMouse ? "#e6e9ef" : "transparent") : "transparent"
                    opacity: (player?.canGoNext ?? false) ? 1 : 0.4

                    MouseArea {
                        id: nextMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: (player?.canGoNext ?? false) ? Qt.PointingHandCursor : Qt.ArrowCursor
                        enabled: player?.canGoNext ?? false
                        onClicked: player?.next()
                    }

                    Text {
                        anchors.centerIn: parent
                        text: "\uf051" // Nerd Font: Forward/Skip Forward
                        font.family: "Symbols Nerd Font"
                        font.pixelSize: 16
                        color: "#4c4f69"
                    }
                }
            }
        }
    }
}
