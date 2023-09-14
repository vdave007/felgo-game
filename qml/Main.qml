import Felgo 4.0
import QtQuick 2.0
import "scenes"
import "common"

GameWindow {
    id: window
    screenWidth: 480
    screenHeight: 320

    // create and remove entities at runtime
    EntityManager {
        id: entityManager
        entityContainer: gameScene
    }

    UpgradeManager {
        id: upgradeManager
    }

    // menu scene
    MenuScene {
        id: menuScene
        // listen to the button signals of the scene and change the state according to it
        onSelectLevelPressed: window.state = "selectLevel"
        onCreditsPressed: window.state = "credits"
        onUpgradesPressed: window.state = "upgrades"
        // the menu scene is our start scene, so if back is pressed there we ask the user if he wants to quit the application
        onBackButtonPressed: {
            nativeUtils.displayMessageBox(qsTr("Really quit the game?"), "", 2);
        }
        // listen to the return value of the MessageBox
        Connections {
            target: nativeUtils
            onMessageBoxFinished: {
                // only quit, if the activeScene is menuScene - the messageBox might also get opened from other scenes in your code
                if(accepted && window.activeScene === menuScene)
                    Qt.quit()
            }
        }
    }

    // scene for selecting levels
    SelectLevelScene {
        id: selectLevelScene
        onLevelPressed: selectedLevel => {
                            // selectedLevel is the parameter of the levelPressed signal
                            gameScene.setLevel(selectedLevel)
                            window.state = "game"

                        }
        onBackButtonPressed: window.state = "menu"
    }

    // credits scene
    CreditsScene {
        id: creditsScene
        onBackButtonPressed: window.state = "menu"
    }

    // game scene to play a level
    GameScene {
        id: gameScene

        upgradeManager: upgradeManager
        onBackButtonPressed: window.state = "selectLevel"

        //Setting it to Level 1 to easytest
        activeLevelFileName: "Level1.qml"
    }

    UpgradesScene {
        id: upgradesScene

        upgradeManager: upgradeManager
        onBackButtonPressed: window.state = "menu"
    }

    // menuScene is our first scene, so set the state to menu initially
    state: "menu"
    activeScene: menuScene

    // state machine, takes care reversing the PropertyChanges when changing the state, like changing the opacity back to 0
    states: [
        State {
            name: "menu"
            PropertyChanges {target: menuScene; opacity: 1}
            PropertyChanges {target: window; activeScene: menuScene}
        },
        State {
            name: "selectLevel"
            PropertyChanges {target: selectLevelScene; opacity: 1}
            PropertyChanges {target: window; activeScene: selectLevelScene}
        },
        State {
            name: "credits"
            PropertyChanges {target: creditsScene; opacity: 1}
            PropertyChanges {target: window; activeScene: creditsScene}
        },
        State {
            name: "game"
            PropertyChanges {target: gameScene; opacity: 1}
            PropertyChanges {target: window; activeScene: gameScene}
        },
        State {
            name: "upgrades"
            PropertyChanges {target: upgradesScene; opacity: 1}
            PropertyChanges {target: window; activeScene: upgradesScene}
        }
    ]
}
