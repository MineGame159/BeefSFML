using System;

namespace SFML.Window
{
	public enum ContextAttribute
	{
		Default = 0,
		Core = 1 << 0,
		Debug = 1 << 2
	}

	[CRepr]
	public struct ContextSettings
	{
		public uint32 DepthBits;
		public uint32 StencilBits;
		public uint32 AntialiasingLevel;
		public uint32 VersionMajor;
		public uint32 VersionMinor;
		public ContextAttribute ContextFlags;
		public bool SRGBCapable;

		public this(uint32 depthBits, uint32 stencilBits) : this(depthBits, stencilBits, 0) {}
		public this(uint32 depthBits, uint32 stencilBits, uint32 antialiasingLevel) : this(depthBits, stencilBits, antialiasingLevel, 2, 0, ContextAttribute.Default, false) {}
		public this(uint32 depthBits, uint32 stencilBits, uint32 antialiasingLevel, uint32 versionMajor, uint32 versionMinor, ContextAttribute flags, bool sRGBCapable)
		{
			DepthBits = depthBits;
			StencilBits = stencilBits;
			AntialiasingLevel = antialiasingLevel;
			VersionMajor = versionMajor;
			VersionMinor = versionMinor;
			ContextFlags = flags;
			SRGBCapable = sRGBCapable;
		}

		public override void ToString(String strBuffer)
		{
			strBuffer.AppendF("[ContextSettings]: DepthBits({}), StencilBits({}), AntialiasingLevel({}), VersionMajor({}), VersionMinor({}), ContextFlags({})",
				 DepthBits, StencilBits, AntialiasingLevel, VersionMajor, VersionMinor, ContextFlags);
		}
	}
}
