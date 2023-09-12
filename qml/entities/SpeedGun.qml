import QtQuick
import Felgo

EntityBase {
    id: speedGunBase

    entityId: "entity"
    entityType: "SpeedGun"

    property var targetedVehicle: undefined
    property int timeToFixate: 3000
    property int lastValidMeasurement: -1

    Rectangle {
        id: pointer
        color: "red"

        height: 5
        width: 5
        radius: 20

        anchors {
            bottom: display.top
            horizontalCenter: display.horizontalCenter
        }
    }

    Rectangle {
        id: display
        width: 50
        height: 50
        opacity: 1
        color: "transparent"

        anchors {
            bottom: handle.top
            horizontalCenter: handle.horizontalCenter
        }

        border.color: 'black'
        border.width: 10

        Text {
            anchors.centerIn: display
            text: lastValidMeasurement <= 0 ? "-" : lastValidMeasurement
        }
    }

    Rectangle {
        id: handle
        color: "black"
        width: 20
        height: 30
        anchors {
            bottom: speedGunBase.bottom
            horizontalCenter: speedGunBase.horizontalCenter
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            drag {
                target: speedGunBase
                axis: Drag.XandYAxis
            }
        }
    }

    Timer {
        id: fixateTimer

        running: false
        interval: speedGunBase.timeToFixate
        repeat: false

        onTriggered: {
            lastValidMeasurement = !targetedVehicle ? -1 : targetedVehicle.finalSpeed
        }

        function restartFixateTimer() {
            lastValidMeasurement = -1;
            fixateTimer.restart();
        }

        function forceStopFixateTimer() {
            lastValidMeasurement = -1;
            fixateTimer.stop();
        }
    }

    BoxCollider {
        anchors.fill: pointer
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
            when: !fixateTimer.running && lastValidMeasurement <= 0
            PropertyChanges { target: display; color: "red"}
        },
        State {
            name: "progress"
            when: fixateTimer.running
            PropertyChanges { target: display; color: "yellow"}
        },
        State {
            name: "success"
            when: !fixateTimer.running && lastValidMeasurement > 0
            PropertyChanges { target: display; color: "green"}
        }

    ]

}
