using System;
using SFML.System;

namespace SFML.Window
{
	public enum SensorType
	{
		Accelerometer,
		Gyroscope,
		Magnetometer,
		Gravity,
		UserAcceleration,
		Orientation,
		TypeCount
	}

	public static class Sensor
	{
		public static bool IsAvailable(SensorType sensor) => sfSensor_isAvailable(sensor);

		public static void SetEnabled(SensorType sensor, bool enabled) => sfSensor_setEnabled(sensor, enabled);

		public static Vector3f GetValue(SensorType sensor) => sfSensor_getValue(sensor);

		// Native functions

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfSensor_isAvailable(SensorType sensor);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfSensor_setEnabled(SensorType sensor, bool enabled);

		[Import(CSFML_WINDOW), CLink]
		private static extern Vector3f sfSensor_getValue(SensorType sensor);
	}
}
