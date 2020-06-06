using System;

namespace SFML.System
{
	[CRepr]
	public struct Time
	{
		private int64 microseconds = 0;

		private this() {}

		public static Time FromMicroseconds(int64 microseconds) => sfMicroseconds(microseconds);
		public static Time FromMilliseconds(int32 milliseconds) => sfMilliseconds(milliseconds);
		public static Time FromSeconds(float seconds) => sfSeconds(seconds);

		public int64 Microseconds
		{
			get { return sfTime_asMicroseconds(this); }
		}

		public int32 Milliseconds
		{
			get { return sfTime_asMilliseconds(this); }
		}

		public float Seconds
		{
			get { return sfTime_asSeconds(this); }
		}

		// Native functions
		
		[Import(CSFML_SYSTEM), CLink]
		private static extern Time sfMicroseconds(int64 microseconds);
		
		[Import(CSFML_SYSTEM), CLink]
		private static extern Time sfMilliseconds(int32 milliseconds);
		
		[Import(CSFML_SYSTEM), CLink]
		private static extern Time sfSeconds(float seconds);

		[Import(CSFML_SYSTEM), CLink]
		private static extern int64 sfTime_asMicroseconds(Time time);

		[Import(CSFML_SYSTEM), CLink]
		private static extern int32 sfTime_asMilliseconds(Time time);

		[Import(CSFML_SYSTEM), CLink]
		private static extern float sfTime_asSeconds(Time time);
	}
}
