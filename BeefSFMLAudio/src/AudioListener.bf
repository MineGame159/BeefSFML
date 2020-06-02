using System;
using SFML.System;

namespace SFML.Audio
{
	public static class AudioListener
	{
		public static float GlobalVolume {
			get { return sfListener_getGlobalVolume(); }
			set { sfListener_setGlobalVolume(value); }
		}

		public static Vector3f Position {
			get { return sfListener_getPosition(); }
			set { sfListener_setPosition(value); }
		}

		public static Vector3f Direction {
			get { return sfListener_getDirection(); }
			set { sfListener_setDirection(value); }
		}

		public static Vector3f UpVector {
			get { return sfListener_getUpVector(); }
			set { sfListener_setUpVector(value); }
		}

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfListener_setGlobalVolume(float volume);

		[Import(CSFML_AUDIO), CLink]
		private static extern float sfListener_getGlobalVolume();

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfListener_setPosition(Vector3f position);

		[Import(CSFML_AUDIO), CLink]
		private static extern Vector3f sfListener_getPosition();

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfListener_setDirection(Vector3f direction);

		[Import(CSFML_AUDIO), CLink]
		private static extern Vector3f sfListener_getDirection();

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfListener_setUpVector(Vector3f upVector);

		[Import(CSFML_AUDIO), CLink]
		private static extern Vector3f sfListener_getUpVector();
	}
}
