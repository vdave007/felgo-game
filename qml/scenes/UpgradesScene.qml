import QtQuick 2.0
import Felgo 4.0
import "../common"

SceneBase {
    id: upgradesScene

    property UpgradeManager upgradeManager

    Rectangle {
        anchors.fill: parent.gameWindowAnchorItem
        color: "#49a349"
    }

    // back button to leave scene
    MenuButton {
        id: backButton
        text: "Back"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors.right: upgradesScene.gameWindowAnchorItem.right
        anchors.rightMargin: 10
        anchors.top: upgradesScene.gameWindowAnchorItem.top
        anchors.topMargin: 10
        onClicked: backButtonPressed()
    }

    MenuButton {
        id: resetButton
        text: "Reset"
        anchors.top: backButton.bottom
        anchors.topMargin: 10
        anchors.right: backButton.right

        onClicked: {
            upgradeManager.resetUpgrades();
        }
    }

    Column {
        anchors.top: resetButton.bottom
        anchors.topMargin: 10
        anchors.right: resetButton.right

        Text {
            text: "Debug enabled:"
        }

        CustomToggle {
            width: 40
            height: 20

            toggled: upgradeManager.debugModifier

            onClicked: {
                upgradeManager.debugModifier = !upgradeManager.debugModifier;
            }
        }
    }

    Column {
        anchors.centerIn: parent

        Text {
            text: `Current money: ${upgradeManager.money.value}`
        }

        Row {
            spacing: 5

            Text {
                text: "Siren upgrade: "
            }

            Rectangle {
                color: "gray"
                width: 20
                height: 20

                Text {
                    id: sirenUpgradeText
                    anchors.centerIn: parent
                    text: upgradeManager.sirenUpgrade.value
                }
            }

            MenuButton {
                width: 20
                height: 20
                text: "+"

                onClicked: {
                    upgradeManager.upgradeSiren();
                }
            }
        }

        Row {
            spacing: 5

            Text {
                text: "Speed Gun upgrade: "
            }

            Rectangle {
                color: "gray"
                width: 20
                height: 20

                Text {
                    id: speedGunUpgradeText
                    anchors.centerIn: parent
                    text: upgradeManager.speedGunUpgrade.value
                }
            }

            MenuButton {
                width: 20
                height: 20
                text: "+"

                onClicked: {
                    upgradeManager.upgradeSpeedGun();
                }
            }
        }
    }

}
