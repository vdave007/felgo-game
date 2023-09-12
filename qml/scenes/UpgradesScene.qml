import QtQuick 2.0
import Felgo 4.0
import "../common"

SceneBase {
    id: upgradesScene

    Component.onCompleted: {
       initializeUpgrades();
    }

    property var sirenUpgrade

    Storage {
        id: storage
    }

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
        text: "Reset"
        anchors.top: backButton.bottom
        anchors.topMargin: 10
        anchors.right: backButton.right

        onClicked: {
            storage.clearAll();
            sirenUpgrade = undefined;
            initializeUpgrades();
        }
    }

    Column {
        anchors.centerIn: parent

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
                    text: "0"
                }
            }

            MenuButton {
                width: 20
                height: 20
                text: "+"

                onClicked: {
                    if(sirenUpgrade.value < 10) {
                        sirenUpgrade.value++;
                        sirenUpgradeText.text = sirenUpgrade.value
                        storage.setValue(sirenUpgrade.id, sirenUpgrade);
                    }
                }
            }
        }
    }

    function initializeUpgrades() {
        sirenUpgrade = storage.getValue("sirenUpgrade")

        if(!sirenUpgrade) {
          sirenUpgrade = {id: "sirenUpgrade", value: 1, description: "Siren upgrade"}
          storage.setValue(sirenUpgrade.id, sirenUpgrade)
        }

        sirenUpgradeText.text = sirenUpgrade.value
    }

}
