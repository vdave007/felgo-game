import QtQuick 2.0
import Felgo 4.0
import "../entities" as Entities
import "../common" as Common

Common.LevelBase {
    levelName: "Level1"

    maxSpeedForCars: 130
    minSpeedForCars: 30

    maxCarsOnRoad: 2
    speedModifier: 1

    Column {
        anchors.centerIn: parent;
        Common.MenuButton {
            text: "SpawnACar"

            onClicked: {
                spawnCar();
            }
        }

        Common.MenuButton {
            text: "Siren -" +speedModifier


            onClicked: {
                if (speedModifier == 1) {
                    speedModifier = 0.75;
                } else {
                    speedModifier = 1;
                }
            }
        }
    }
}
