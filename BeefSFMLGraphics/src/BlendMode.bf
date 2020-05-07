using System;

namespace SFML.Graphics
{
	public enum Factor : uint32
	{
	    Zero,
	    One,
	    SrcColor,
	    OneMinusSrcColor,
	    DstColor,
	    OneMinusDstColor,
	    SrcAlpha,
	    OneMinusSrcAlpha,
	    DstAlpha,
	    OneMinusDstAlpha
	}

	public enum Equation : uint32
	{
	    Add,
	    Subtract,
	    ReverseSubtract
	}

	[CRepr, Ordered]
	public struct BlendMode
	{
		public static readonly BlendMode Alpha = BlendMode(.SrcAlpha, .OneMinusSrcAlpha, .Add, .One, .OneMinusSrcAlpha, .Add);
		public static readonly BlendMode Add = BlendMode(.SrcAlpha, .One, .Add, .One, .One, .Add);
		public static readonly BlendMode Multiply = BlendMode(.DstColor, .Zero);
		public static readonly BlendMode None = BlendMode(.One, .Zero);

		public this(Factor SourceFactor, Factor DestinationFactor) : this(SourceFactor, DestinationFactor, Equation.Add) {}

		public this(Factor SourceFactor, Factor DestinationFactor, Equation BlendEquation) : this(SourceFactor, DestinationFactor, BlendEquation, SourceFactor, DestinationFactor, BlendEquation) {}

		public this(Factor ColorSourceFactor, Factor ColorDestinationFactor, Equation ColorBlendEquation, Factor AlphaSourceFactor, Factor AlphaDestinationFactor, Equation AlphaBlendEquation)
		{
		    ColorSrcFactor = ColorSourceFactor;
		    ColorDstFactor = ColorDestinationFactor;
		    ColorEquation = ColorBlendEquation;
		    AlphaSrcFactor = AlphaSourceFactor;
		    AlphaDstFactor = AlphaDestinationFactor;
		    AlphaEquation = AlphaBlendEquation;
		}

		public Factor ColorSrcFactor;
		public Factor ColorDstFactor;
		public Equation ColorEquation;
		public Factor AlphaSrcFactor;
		public Factor AlphaDstFactor;
		public Equation AlphaEquation;
	}
}
