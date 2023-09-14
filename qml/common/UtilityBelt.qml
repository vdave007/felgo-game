import QtQuick 2.0
import "../entities"
import "../common"
Item {
    id: root

    // reference to the game state
    property GameState gameState
    property UpgradeManager upgradeManager

    signal speedGunClicked
    signal sirenClicked
    signal beltClicked
    signal ticketBookClicked
    signal carDocumentsClicked

    onSpeedGunClicked: {
        if(entityManager.getEntityArrayByType("SpeedGun").length === 0){
            speedGunIcon.enabled = false;
            speedGunIcon.opacity = 0.2;
            let position = mapToItem(gameScene.gameWindowAnchorItem, speedGunIcon.x, speedGunMouseArea.mouseY-50);
            console.log("Pos", position);
            entityManager.createEntityFromUrlWithProperties(
                        Qt.resolvedUrl("../entities/SpeedGun.qml"),
                        {"initialXPos": position.x, "initialYPos": position.y, "z": 100,
                            "upgradeManager": upgradeManager,
                            "gameState": gameState
                        }
                        )
        }
    }

    onBeltClicked: {
        entityManager.removeEntitiesByFilter(["SpeedGun"])
        speedGunIcon.enabled = true;
        speedGunIcon.opacity = 1;
    }

    Image {
        id: belt
        source: Qt.resolvedUrl("../../assets/img/belt.png")
        height: 30
        anchors {
            bottom: parent.bottom
            left: parent.left
            right: parent.right
        }
        fillMode: Image.TileHorizontally
    }

    MouseArea {
        id: beltMouseArea
        anchors.fill: belt

        onClicked: {
            beltClicked();
        }
    }

    CustomToggle {
        id: siren
        toggled: gameState.sirenRunning

        width: 40
        height: 20
        rotation: 270
        scale: 2
        anchors {
            bottom: belt.bottom
            bottomMargin: 40
            right: belt.right
        }

        onClicked: sirenClicked()
    }

    Image {
        id: speedGunIcon

        source: Qt.resolvedUrl("../../assets/img/radar-gun-mini.png")

        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
        }

        MouseArea {
            id: speedGunMouseArea
            anchors.fill: parent

            onClicked: {
                speedGunClicked();
            }
        }
    }

    Image {
        id: money

        source: Qt.resolvedUrl("../../assets/img/money.png")
        anchors {
            bottom: parent.bottom
            right: ticketBook.left
        }

        StyledText {
            anchors.centerIn: parent
            text: upgradeManager.money.value
        }
    }

    TicketBookMini {
        id: ticketBook

        anchors {
            bottom: parent.bottom
            right: speedGunIcon.left
        }

        onClicked: {
            ticketBookClicked();
        }

    }

    CarDocumentsMini {
        id: carDocuments
        width: visible ? 64 : 0
        visible: gameState.hasStoppedCar
        anchors {
            bottom: parent.bottom
            left: speedGunIcon.right
        }

        onClicked: {
            carDocumentsClicked();
        }
    }
}
