import QtQuick 2.0
import Felgo 4.0
import "../entities" as Entities
import "../common" as Common

Common.LevelBase {
    levelName: "Level1"

    property int carCounter: 0

    Common.MenuButton {
        text: "SpawnACar"
        // anchor the button to the gameWindowAnchorItem to be on the edge of the screen on any device
        anchors {
            centerIn: parent
        }

        onClicked: {
            let theId = "car_id_" + carCounter;
            let theSpeed = Math.random() * (200 - 30) + 30;
            carCounter = carCounter + 1;
            entityManager.createEntityFromUrlWithProperties(Qt.resolvedUrl("../entities/VehicleEntity.qml"),
                                                            {"x": 0, "y": 50, "entityId": theId, "velocity" : theSpeed});
        }
    }
}
