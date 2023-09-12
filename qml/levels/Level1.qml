import QtQuick 2.0
import Felgo 4.0
import "../entities" as Entities
import "../common" as Common

Common.LevelBase {
    levelName: "Level1"

    speedLimit: 50

    maxSpeedForCars: 130
    minSpeedForCars: 30

    maxCarsOnRoad: 2
    speedModifier: 1

    Column {
        anchors.centerIn: parent;
        Common.MenuButton {
            visible: false
            text: "SpawnACar"

            onClicked: {
                spawnCar();
            }
        }
    }
}
