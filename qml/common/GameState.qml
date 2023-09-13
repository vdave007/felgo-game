import QtQuick 2.0

Item {
    readonly property bool gameRunning: gameScene.enabled
    readonly property bool hasStoppedCar: stoppedCar != undefined
    property var stoppedCar: undefined

    onGameRunningChanged: {
        reset();
    }

    signal carStopped(var car)
    signal carReleased(var car)

    // flag indicating if the siren is running
    property bool sirenRunning: false
    property int lastValidMeasurement: -1
    property string lastValidMeasurmentVehicleId: ""
    property int speedLimit: 0

    function reset() {
        sirenRunning = false;
        lastValidMeasurement = -1;
        lastValidMeasurmentVehicleId = "";
        stoppedCar = undefined;
    }

    function issueTicket(car) {
        // TODO: maybe add a notification or something here?
        console.log("Issuing ticket for:", car.licensePlate)
        if (checkTicketValidity() === true) {
            // Give money!
        } else {
            // Take money!
        }

        carReleased(car);
    }

    function checkTicketValidity() {
        if (!hasStoppedCar) {
            return false;
        }
        if (stoppedCar.licensePlate !== lastValidMeasurmentVehicleId) {
            console.log("Wrong license plate!");
            return false;
        }
        if (lastValidMeasurement <= 0) {
            console.log("Invalid speed measurement");
            return false;
        }
        if (lastValidMeasurement <= speedLimit) {
            console.log("Speed not under speed limit!");
            return false;
        }

        console.log(`Ticket issued for speeding. Speed was ${lastValidMeasurement} at a ${speedLimit} zone!`);
        return true;
    }

    onCarStopped: {
        console.log("Stopped a car", car)
        stoppedCar = car;
    }

    onCarReleased: {
        stoppedCar = undefined;
    }
}
