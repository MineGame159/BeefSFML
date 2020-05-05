using System;
using SFML.Graphics;

namespace SFML.Graphics.GLSL
{
	[CRepr, Ordered]
	public struct Mat3
	{
		private float[] _m;

		public this(float m00, float m01, float m02,
			        float m10, float m11, float m12,
			        float m20, float m21, float m22)
		{
			_m = new float[3 * 3]
			{
				m00, m10, m20,
				m01, m11, m21,
				m02, m12, m22
			};
		}
	}

	[CRepr, Ordered]
	public struct Mat4
	{
		private float[] _m;

		public this(float m00, float m01, float m02, float m03,
			        float m10, float m11, float m12, float m13,
			        float m20, float m21, float m22, float m23,
			        float m30, float m31, float m32, float m33)
		{
			_m = new float[4 * 4]
			{
				m00, m10, m20, m30,
				m01, m11, m21, m31,
				m02, m12, m22, m32,
				m03, m13, m23, m33
			};
		}
	}
}
