import Felgo 4.0
import QtQuick 2.0
import "../common"

SceneBase {
    id:gameScene
    // the filename of the current level gets stored here, it is used for loading the
    property string activeLevelFileName
    // the currently loaded level gets stored here
    property variant activeLevel

    property UpgradeManager upgradeManager

    // set the name of the current level, this will cause the Loader to load the corresponding level
    function setLevel(fileName) {
        activeLevelFileName = fileName
    }

    GameState{
        id: gameState
    }

    // background
    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#202020"
        Text {
            anchors.centerIn: parent
            text: parent.width + "," + parent.height
        }
    }

    Image {
        source: Qt.resolvedUrl("../../assets/img/board.png")
        anchors {
            left: parent.gameWindowAnchorItem.left
            right: parent.gameWindowAnchorItem.right
            bottom: gameScene.bottom
            top: road.bottom
        }
        fillMode: Image.TileHorizontally
    }

    // The road. Currently just a rectangle as placeholder.
    Road {
        id: road

        anchors {
            left: parent.gameWindowAnchorItem.left
            right: parent.gameWindowAnchorItem.right
            top: gameScene.top
        }

        PoliceZone {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }
    }

    UtilityBelt {
        id: utilityBelt

        gameState: gameState
        upgradeManager: gameScene.upgradeManager

        anchors {
            bottom: parent.bottom
            left: parent.gameWindowAnchorItem.left
            right: parent.gameWindowAnchorItem.right
        }

        onSirenClicked: {
            gameState.sirenRunning = !gameState.sirenRunning;
        }

        onTicketBookClicked: {
            ticketBook.open();
        }
    }

    TicketBook {
        id: ticketBook
    }


    PhysicsWorld {
    }

    // back button to leave scene
    MenuButton {
        text: "Back to menu"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: gameScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: gameScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: {
            backButtonPressed()
            activeLevel = undefined
            activeLevelFileName = ""
        }
    }

    // load levels at runtime
    Loader {
        id: loader
        source: activeLevelFileName != "" ? "../levels/" + activeLevelFileName : ""

        onSourceChanged: {
            entityManager.removeAllEntities();
        }

        onLoaded: {
            // since we did not define a width and height in the level item itself, we are doing it here
            item.width = gameScene.width;
            item.height = gameScene.height;
            item.gameState = gameState;
            item.upgradeManager = upgradeManager;
            // store the loaded level as activeLevel for easier access
            activeLevel = item;
        }
    }

    // we connect the gameScene to the loaded level
    Connections {
        target: activeLevel !== undefined ? activeLevel : null
    }
}
