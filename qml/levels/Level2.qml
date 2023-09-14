import QtQuick 2.0
import Felgo 4.0
import "../common" as Common

Common.LevelBase {
    levelName: "Level2"

    speedLimit: 70

    minSpeedForCars: 50

    maxCarsOnRoad: 3
    speedModifier: 1.5

    Column {
        anchors.centerIn: parent;
        Common.MenuButton {
            visible: upgradeManager.debugModifier
            text: "SpawnACar"

            onClicked: {
                spawnCar();
            }
        }
    }
}
