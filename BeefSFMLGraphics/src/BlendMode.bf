using System;

namespace SFML.Graphics
{
	public enum BlendFactor
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

	public enum BlendEquation
	{
		Add,
		Subtract,
		ReverseSubtract
	}

	[CRepr]
	struct BlendMode
	{
		public BlendFactor ColorSourceFactor;
		public BlendFactor ColorDestinationFactor;
		public BlendEquation ColorEquation;
		public BlendFactor AlphaSourceFactor;
		public BlendFactor AlphaDestinationFactor;
		public BlendEquation AlphaEquation;

		public this(BlendFactor colSrcFactor, BlendFactor colDstFactor) : this(colSrcFactor, colDstFactor, BlendEquation.Add) {}
		public this(BlendFactor colSrcFactor, BlendFactor colDstFactor, BlendEquation colBlendEquation)
		: this(colSrcFactor, colDstFactor, colBlendEquation, colSrcFactor, colDstFactor, colBlendEquation) {}

		public this(BlendFactor colSrcFactor,
			BlendFactor colDstFactor,
			BlendEquation colBlendEquation,
			BlendFactor alphaSrcFactor,
			BlendFactor alphaDstFactor,
			BlendEquation alphaBlendEquation)
			{
				ColorSourceFactor = colSrcFactor;
				ColorDestinationFactor = colDstFactor;
				ColorEquation = colBlendEquation;
				AlphaSourceFactor = alphaSrcFactor;
				AlphaDestinationFactor = alphaDstFactor;
				AlphaEquation = alphaBlendEquation;
			}

		public static readonly BlendMode Alpha = BlendMode(.SourceAlpha, .OneMinusSourceAlpha, .Add, .One, .OneMinusSourceAlpha, .Add);
		public static readonly BlendMode Add = BlendMode(.SourceAlpha, .One, .Add, .One, .One, .Add);
		public static readonly BlendMode Multiply = BlendMode(.DestinationColor, .Zero);
		public static readonly BlendMode None =  BlendMode(.One, .Zero);
	}
}
