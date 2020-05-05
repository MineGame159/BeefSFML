using System;
using SFML.System;

namespace SFML.Window
{
	[CRepr]
	public struct VideoMode
	{
		private static VideoMode[] _modes;

		public this(uint32 width, uint32 height) : this(width, height, 32) { }
		public this(uint32 width, uint32 height, uint32 bitsPerPixel)
		{
		    Width = width;
		    Height = height;
		    BitsPerPixel = bitsPerPixel;
		}

		public bool IsValid => sfVideoMode_isValid(this);

		public static VideoMode[] GetFullscreenModes(bool flushOld = false)
		{
			if (!flushOld && _modes.Count > 0) return _modes;
			delete _modes;

			uint32 count;
			VideoMode* modes = sfVideoMode_getFullscreenModes(out count);

			_modes = new VideoMode[count];

			for (uint32 i = 0; i < count; i++) {
				_modes[i] = modes[i];
			}
			
			return _modes;
		}

		public static VideoMode DesktopMode => sfVideoMode_getDesktopMode();
		
		public override void ToString(String strBuffer)
		{
			strBuffer.AppendF("[VideoMode]: Width({}), Height({}), BitsPerPixel({})",
				 Width, Height, BitsPerPixel);
		}

		public uint32 Width;
		public uint32 Height;
		public uint32 BitsPerPixel;

		[Import(CSFML_WINDOW), CLink]
		private static extern VideoMode sfVideoMode_getDesktopMode();

		[Import(CSFML_WINDOW), CLink]
		private static extern VideoMode* sfVideoMode_getFullscreenModes(out uint32 count);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfVideoMode_isValid(VideoMode mode);
	}
}
