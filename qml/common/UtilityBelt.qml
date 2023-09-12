import QtQuick 2.0

Rectangle {
    id: belt

    signal speedGunClicked
    signal beltClicked

    onSpeedGunClicked: {
        if(entityManager.getEntityArrayByType("SpeedGun").length === 0){
            speedGunIcon.enabled = false;
            speedGunIcon.opacity = 0.2;
            let position = mapToItem(gameScene, beltMouseArea.mouseX, speedGunMouseArea.mouseY+15);
            console.log("Pos", position);
            entityManager.createEntityFromUrlWithProperties(
                        Qt.resolvedUrl("../entities/SpeedGun.qml"),
                        {"x": position.x, "y": position.y}
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
    }
}
