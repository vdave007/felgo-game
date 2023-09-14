import Felgo 4.0
import QtQuick 2.0
import "../common"

SceneBase {
    id: menuScene

    // signal indicating that the selectLevelScene should be displayed
    signal selectLevelPressed
    // Signal indicating that the upgrades scene should be displayed
    signal upgradesPressed
    // signal indicating that the creditsScene should be displayed
    signal creditsPressed

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#47688e"
    }


    Image {
        source: Qt.resolvedUrl("../../assets/img/tile.png")
        anchors.fill: parent.gameWindowAnchorItem
        fillMode: Image.Tile
    }

    Image {
        id: logo
        source: Qt.resolvedUrl("../../assets/img/logo.png")
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: menuColumn.top
        }
    }

    AnimatedSprite {
        id: sirenSprite
        anchors.right: menuScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.bottom: menuScene.gameWindowAnchorItem.bottom
        anchors.bottomMargin: 10
        running: true
        frameCount:5
        frameWidth: 64
        frameHeight: 64
        source: Qt.resolvedUrl("../../assets/img/siren.png")

        // update the animation 20 times per second
        frameRate: 5
    }

    // menu
    Column {
        id: menuColumn
        anchors.centerIn: parent
        spacing: 10
        MenuButton {
            text: "Levels"
            onClicked: selectLevelPressed()
        }
        MenuButton {
            text: "Upgrades"
            onClicked: upgradesPressed()
        }

        MenuButton {
            text: "Credits"
            onClicked: creditsPressed()
        }
    }
}
