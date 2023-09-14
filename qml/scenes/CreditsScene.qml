import Felgo 4.0
import QtQuick 2.0
import "../common"

SceneBase {
    id:creditsScene

    Image {
        source: Qt.resolvedUrl("../../assets/img/tile.png")
        anchors.fill: parent.gameWindowAnchorItem
        fillMode: Image.Tile
    }

    // back button to leave scene
    MenuButton {
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: creditsScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: creditsScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: backButtonPressed()
    }

    // credits
    Text {
        text: "Credits to: Vincze David :)"
        color: "white"
        anchors.centerIn: parent
    }
}
