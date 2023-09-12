import QtQuick 2.0

Rectangle {
    id: belt

    // reference to the game state
    property GameState gameState
    property UpgradeManager upgradeManager

    signal speedGunClicked
    signal sirenClicked
    signal beltClicked

    onSpeedGunClicked: {
        if(entityManager.getEntityArrayByType("SpeedGun").length === 0){
            speedGunIcon.enabled = false;
            speedGunIcon.opacity = 0.2;
            let position = mapToItem(gameScene, beltMouseArea.mouseX, speedGunMouseArea.mouseY+15);
            console.log("Pos", position);
            entityManager.createEntityFromUrlWithProperties(
                        Qt.resolvedUrl("../entities/SpeedGun.qml"),
                        {"x": position.x, "y": position.y, "z": 100, "upgradeLevel": upgradeManager.speedGunUpgrade.value}
                        )
        }
    }

    onBeltClicked: {
        entityManager.removeEntitiesByFilter(["SpeedGun"])
        speedGunIcon.enabled = true;
        speedGunIcon.opacity = 1;
    }

    color: "orange"

    height: 30

    anchors {
        bottom: parent.bottom
        left: parent.left
        right: parent.right
    }

    MouseArea {
        id: beltMouseArea
        anchors.fill: parent

        onClicked: {
            beltClicked();
        }
    }

    Row {
        spacing: 10
        anchors {
            horizontalCenter: belt.horizontalCenter
            top: belt.top
            bottom: belt.bottom
        }

        Rectangle {
            id: speedGunIcon
            color: "black"
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                id: speedGunMouseArea
                anchors.fill: parent

                onClicked: {
                    speedGunClicked();
                }
            }
        }

        Rectangle {
            id: siren
            color: gameState.sirenRunning ? "red" : "blue"

            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter

            MouseArea {
                id: sirenMouseArea
                anchors.fill: parent

                onClicked: {
                    sirenClicked();
                }
            }
        }
    }
}
