import QtQuick
import Felgo 4.0
import "../common"

EntityBase {
    id: speedGunBase

    entityId: "entity"
    entityType: "SpeedGun"

    property GameState gameState
    property UpgradeManager upgradeManager

    property var targetedVehicle: undefined
    property int timeToFixate: upgradeManager.speedGunInitialTimeToFixate * upgradeManager.speedGunModifier

    property int initialXPos: 0
    property int initialYPos: 0

    x: initialXPos
    y: initialYPos

    Image {
        id: speedGunAsset
        source: Qt.resolvedUrl("../../assets/img/radar-gun.png")
        anchors {
            bottom: speedGunBase.bottom
            horizontalCenter: speedGunBase.horizontalCenter
        }

        Column {
            anchors {
                horizontalCenter: speedGunAsset.horizontalCenter
                top: speedGunAsset.top
                topMargin: 20
            }
            Text {
                text: gameState.lastValidMeasurement <= 0 ? "-" : gameState.lastValidMeasurement
            }
            Text {
                font.pixelSize: 3
                text: gameState.lastValidMeasurmentVehicleId
            }
        }
    }

    MouseArea {
        id: mouseArea
        width: 20
        height: 40
        anchors {
            bottom: speedGunBase.bottom
            horizontalCenter: speedGunBase.horizontalCenter
        }
        drag {
            target: speedGunBase
            axis: Drag.XandYAxis
        }

        onReleased: {
            speedGunBase.x = initialXPos;
            speedGunBase.y = initialYPos;
        }
    }

    Timer {
        id: fixateTimer

        running: false
        interval: speedGunBase.timeToFixate
        repeat: false

        onTriggered: {
            gameState.lastValidMeasurement = !targetedVehicle ? -1 : targetedVehicle.finalSpeed
            gameState.lastValidMeasurmentVehicleId = !targetedVehicle ? "" : targetedVehicle.entityId
        }

        function restartFixateTimer() {
            gameState.lastValidMeasurement = -1;
            gameState.lastValidMeasurmentVehicleId = "";
            fixateTimer.restart();
        }

        function forceStopFixateTimer() {
            gameState.lastValidMeasurement = -1;
            gameState.lastValidMeasurmentVehicleId = "";
            fixateTimer.stop();
        }
    }

    BoxCollider {
        height: 5
        width: 5

        anchors {
            top: speedGunAsset.top
            topMargin: 3
            horizontalCenter: speedGunAsset.horizontalCenter
        }
        collisionTestingOnlyMode: true

        property int colliderCounter: 0

        fixture.onBeginContact: {
            var body = other.getBody();
            targetedVehicle = body.target;
            fixateTimer.restartFixateTimer();
            colliderCounter++;
        }

        fixture.onEndContact: {
            colliderCounter--;
            if (colliderCounter == 0) {
                if (fixateTimer.running) {
                    fixateTimer.forceStopFixateTimer();
                }
                targetedVehicle = undefined;
            }
        }
    }

    state: "invalid"

    states: [
        State {
            name: "invalid"
            when: !fixateTimer.running && gameState.lastValidMeasurement <= 0
            PropertyChanges { target: speedGunAsset; source: Qt.resolvedUrl("../../assets/img/radar-gun-error.png")}
        },
        State {
            name: "progress"
            when: fixateTimer.running
            PropertyChanges { target: speedGunAsset; source: Qt.resolvedUrl("../../assets/img/radar-gun-loading.png")}
        },
        State {
            name: "success"
            when: !fixateTimer.running && gameState.lastValidMeasurement > 0
            PropertyChanges { target: speedGunAsset; source: Qt.resolvedUrl("../../assets/img/radar-gun.png")}
        }

    ]

}
