import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Mpris

Item {
    id: root

    // Find best player from Mpris.players, preferring Spotify > playing > paused
    property var activePlayer: {
        let spotifyPlayer = null
        let playingPlayer = null
        let pausedPlayer = null
        let anyPlayer = null

        for (let player of Mpris.players.values) {
            if (!player) continue

            // Prefer Spotify over other players
            if (player.identity && player.identity.toLowerCase().includes("spotify")) {
                spotifyPlayer = player
                break
            } else if (player.playbackState === MprisPlaybackState.Playing) {
                playingPlayer = player
            } else if (player.playbackState === MprisPlaybackState.Paused) {
                pausedPlayer = player
            } else if (!anyPlayer) {
                anyPlayer = player
            }
        }

        const selected = spotifyPlayer || playingPlayer || pausedPlayer || anyPlayer
        return selected
    }
    readonly property bool hasPlayer: activePlayer !== null
    readonly property string trackTitle: activePlayer?.trackTitle ?? ""
    readonly property string trackArtist: activePlayer?.trackArtist ?? ""

    Layout.fillHeight: true
    Layout.preferredWidth: hasPlayer ? 150 : 0
    implicitWidth: hasPlayer ? 150 : 0
    implicitHeight: 25
    visible: hasPlayer

    // Update position for progress indicator
    Timer {
        running: activePlayer?.playbackState === MprisPlaybackState.Playing
        interval: 1000
        repeat: true
        onTriggered: if (activePlayer) activePlayer.positionChanged()
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        // Open popup on hover
        onEntered: {
            mprisPopupLoader.active = true
            closeTimer.stop()
        }

        // Close popup when mouse leaves
        onExited: {
            closeTimer.restart()
        }

        // Scroll to control volume
        onWheel: (event) => {
            if (!activePlayer || !activePlayer.volumeSupported) return

            const delta = event.angleDelta.y / 120
            const newVolume = Math.max(0, Math.min(1, activePlayer.volume + delta * 0.05))
            activePlayer.volume = newVolume
        }
    }

    // Timer to delay closing the popup
    Timer {
        id: closeTimer
        interval: 300
        onTriggered: {
            if (!mouseArea.containsMouse && !popupHovered) {
                mprisPopupLoader.active = false
            }
        }
    }

    property bool popupHovered: false

    RowLayout {
        id: contentRow
        anchors.centerIn: parent
        spacing: 6

        // Circular progress indicator
        Rectangle {
            Layout.alignment: Qt.AlignVCenter
            width: 18
            height: 18
            radius: 9
            color: "#4489b4fa"

            Rectangle {
                anchors.centerIn: parent
                width: 12
                height: 12
                radius: 6
                color: "#89b4fa"

                Text {
                    anchors.centerIn: parent
                    text: activePlayer?.isPlaying ? "⏸" : "▶"
                    font.pixelSize: 8
                    color: "white"
                }
            }
        }

        Text {
            Layout.alignment: Qt.AlignVCenter
            text: trackTitle || "No media"
            font.pixelSize: 11
            color: "#181825"
            elide: Text.ElideRight
            Layout.maximumWidth: 120
            Layout.fillWidth: true
        }
    }

    // Popup as separate window
    Loader {
        id: mprisPopupLoader
        active: false

        sourceComponent: PopupWindow {
            id: popupWindow
            visible: true
            color: "transparent"

            anchor {
                item: root
                edges: Edges.Bottom
                gravity: Edges.Bottom
                adjustment: PopupAdjustment.Slide
                rect {
                    y: 8
                    width: root.width
                    height: root.height
                }
            }

            implicitWidth: popupContent.implicitWidth
            implicitHeight: popupContent.implicitHeight

            HoverHandler {
                onHoveredChanged: {
                    root.popupHovered = hovered
                    if (!hovered) {
                        closeTimer.restart()
                    } else {
                        closeTimer.stop()
                    }
                }
            }

            MprisPopup {
                id: popupContent
                player: root.activePlayer
            }
        }
    }
}
