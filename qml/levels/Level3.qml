import QtQuick 2.0
import Felgo 4.0
import "../common" as Common

Common.LevelBase {
    levelName: "Level3"

    speedLimit: 90

    minSpeedForCars: 60

    maxCarsOnRoad: 4
    speedModifier: 2
    chanceForIgnorants: 0.5

    Column {
        anchors.centerIn: parent;
        Common.MenuButton {
            visible: true
            text: "SpawnACar"

            onClicked: {
                spawnCar();
            }
        }
    }
}
