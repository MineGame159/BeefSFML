using System;

namespace SFML.Graphics
{
	public enum Factor : uint32
	{
	    Zero,
	    One,
	    SourceColor,
	    OneMinusSourceColor,
	    DestinationColor,
	    OneMinusDestinationColor,
	    SourceAlpha,
	    OneMinusSourceAlpha,
	    DestinationAlpha,
	    OneMinusDestinationAlpha
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
		public static readonly BlendMode Alpha = BlendMode(.SourceAlpha, .OneMinusSourceAlpha, .Add, .One, .OneMinusSourceAlpha, .Add);
		public static readonly BlendMode Add = BlendMode(.SourceAlpha, .One, .Add, .One, .One, .Add);
		public static readonly BlendMode Multiply = BlendMode(.DestinationColor, .Zero);
		public static readonly BlendMode None = BlendMode(.One, .Zero);

		public this(Factor sourceFactor, Factor destinationFactor) : this(sourceFactor, destinationFactor, Equation.Add) {}
		public this(Factor sourceFactor, Factor destinationFactor, Equation blendEquation) : this(sourceFactor, destinationFactor, blendEquation, sourceFactor, destinationFactor, blendEquation) {}
		public this(Factor colorSourceFactor, Factor colorDestinationFactor, Equation colorBlendEquation, Factor alphaSourceFactor, Factor alphaDestinationFactor, Equation alphaBlendEquation)
		{
		    ColorSourceFactor = colorSourceFactor;
		    ColorDestinationFactor = colorDestinationFactor;
		    ColorEquation = colorBlendEquation;
		    AlphaSourceFactor = alphaSourceFactor;
		    AlphaDestinationFactor = alphaDestinationFactor;
		    AlphaEquation = alphaBlendEquation;
		}

		public Factor ColorSourceFactor;
		public Factor ColorDestinationFactor;
		public Equation ColorEquation;
		public Factor AlphaSourceFactor;
		public Factor AlphaDestinationFactor;
		public Equation AlphaEquation;
	}
}
