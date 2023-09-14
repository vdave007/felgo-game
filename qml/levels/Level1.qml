import QtQuick 2.0
import Felgo 4.0
import "../common" as Common

Common.LevelBase {
    levelName: "Level1"

    speedLimit: 50

    minSpeedForCars: 30

    maxCarsOnRoad: 2
    speedModifier: 1

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
