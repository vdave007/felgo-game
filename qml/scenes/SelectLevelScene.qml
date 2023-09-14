import Felgo 4.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: selectLevelScene

    // signal indicating that a level has been selected
    signal levelPressed(string selectedLevel)

    Image {
        source: Qt.resolvedUrl("../../assets/img/tile.png")
        anchors.fill: parent.gameWindowAnchorItem
        fillMode: Image.Tile
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: selectLevelScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: selectLevelScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: backButtonPressed()
    }

    // levels to be selected
    Grid {
        anchors.centerIn: parent
        spacing: 10
        columns: 1
        MenuButton {
            text: "Easy"
            onClicked: {
                levelPressed("Level1.qml")
            }
        }
        MenuButton {
            text: "Medium"
            onClicked: {
                levelPressed("Level2.qml")
            }
        }
        MenuButton {
            text: "Hard"
            onClicked: {
                levelPressed("Level3.qml")
            }
        }
        MenuButton {
            text: "Impossible"
            onClicked: {
                levelPressed("LevelImpossible.qml")
            }
        }
    }
}
