import QtQuick 2.0

Item {
    readonly property bool gameRunning: gameScene.enabled

    onGameRunningChanged: {
        reset();
    }

    // flag indicating if the siren is running
    property bool sirenRunning: false
    property int lastValidMeasurement: -1
    property string lastValidMeasurmentVehicleId: ""

    function reset() {
        sirenRunning = false;
        lastValidMeasurement = -1;
        lastValidMeasurmentVehicleId = "";
    }
}
