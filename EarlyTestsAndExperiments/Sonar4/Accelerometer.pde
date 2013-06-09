
// sensor reading code: start listening to the sensor on sketch start, stop
// listening on exit, and create a special class that extends the built-in
// SensorEventListener to read the sensor data into an array
void onResume() {
  super.onResume();
  sensorManager = (SensorManager)getSystemService(Context.SENSOR_SERVICE);
  sensorListener = new SensorListener();
  accelerometer = sensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
  sensorManager.registerListener(sensorListener, accelerometer, SensorManager.SENSOR_DELAY_GAME);  // see top comments for speed options
}
void onPause() {
  sensorManager.unregisterListener(sensorListener);
  super.onPause();
}

class SensorListener implements SensorEventListener {
  void onSensorChanged(SensorEvent event) {
    if (event.sensor.getType() == Sensor.TYPE_ACCELEROMETER) {
      accelData = event.values;
    }
  }
  void onAccuracyChanged(Sensor sensor, int accuracy) {
    // nothing here, but this method is required for the code to work...
  }
}

