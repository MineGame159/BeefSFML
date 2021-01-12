using System;
using SFML.Graphics;

namespace SFML.Graphics.GLSL
{
	[CRepr, Ordered]
	public struct Mat3
	{
		private static float[3*3] _m;

		public this(Matrix3x3 m) : this(m.[Friend]_m00, m.[Friend]_m01, m.[Friend]_m02, m.[Friend]_m10, m.[Friend]_m11, m.[Friend]_m12, m.[Friend]_m20, m.[Friend]_m21, m.[Friend]_m22) { }
		public this(float m00, float m01, float m02,
			        float m10, float m11, float m12,
			        float m20, float m21, float m22)
		{
			_m = 
			.(
				m00, m10, m20,
				m01, m11, m21,
				m02, m12, m22
			);
		}
	}

	[CRepr, Ordered]
	public struct Mat4
	{
		private float[4*4] _m;

		public this(Matrix3x3 m) : this(m.[Friend]_m00, m.[Friend]_m01, m.[Friend]_m02, m.[Friend]_m10, m.[Friend]_m11, m.[Friend]_m12, m.[Friend]_m20, m.[Friend]_m21, m.[Friend]_m22, 0, 0, 0, 0, 0, 0, 0) { }
		public this(float m00, float m01, float m02, float m03,
			        float m10, float m11, float m12, float m13,
			        float m20, float m21, float m22, float m23,
			        float m30, float m31, float m32, float m33)
		{
			_m =
			.(
				m00, m10, m20, m30,
				m01, m11, m21, m31,
				m02, m12, m22, m32,
				m03, m13, m23, m33
			);
		}
	}
}
