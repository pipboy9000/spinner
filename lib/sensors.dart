import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class Sensors {
  static List<double>? _userAccelerometerValues;
  static List<double>? _accelerometerValues;
  static List<double>? _gyroscopeValues;
  static List<double>? _magnetometerValues;
  static final _streamSubscriptions = <StreamSubscription<dynamic>>[];

  // Private constructor to prevent direct instantiation
  Sensors._privateConstructor() {
    _streamSubscriptions.add(
      userAccelerometerEvents.listen(
        (UserAccelerometerEvent event) {
          _userAccelerometerValues = <double>[event.x, event.y, event.z];
        },
        onError: (e) {
          print("Sensors error");
          print(e.toString());
        },
        cancelOnError: true,
      ),
    );
    _streamSubscriptions.add(
      accelerometerEvents.listen(
        (AccelerometerEvent event) {
          _accelerometerValues = <double>[event.x, event.y, event.z];
        },
        onError: (e) {
          print("Sensors error");
          print(e.toString());
        },
        cancelOnError: true,
      ),
    );
    _streamSubscriptions.add(
      gyroscopeEvents.listen(
        (GyroscopeEvent event) {
          _gyroscopeValues = <double>[event.x, event.y, event.z];
        },
        onError: (e) {
          print("Sensors error");
          print(e.toString());
        },
        cancelOnError: true,
      ),
    );
    _streamSubscriptions.add(
      magnetometerEvents.listen(
        (MagnetometerEvent event) {
          _magnetometerValues = <double>[event.x, event.y, event.z];
        },
        onError: (e) {
          print("Sensors error");
          print(e.toString());
        },
        cancelOnError: true,
      ),
    );
  }

  // The instance of the singleton class
  static final Sensors _instance = Sensors._privateConstructor();

  // Factory constructor to provide access to the instance
  factory Sensors() {
    return _instance;
  }

  void dispose() {
    for (final subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  List<double>? getAcc() {
    // final userAccelerometer = _userAccelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    // final accelerometer = _accelerometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    // final gyroscope = _gyroscopeValues?.map((double v) => v.toStringAsFixed(1)).toList();
    // final magnetometer = _magnetometerValues?.map((double v) => v.toStringAsFixed(1)).toList();
    // return accelerometer;
    return _accelerometerValues;
  }
}
