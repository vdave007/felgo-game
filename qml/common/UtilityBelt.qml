import QtQuick 2.0

Item {
    id: root

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
                        {"x": 430, "y": 315, "z": 100,
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

    Row {
        spacing: 10
        anchors {
            right: belt.right
            rightMargin: 10
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
