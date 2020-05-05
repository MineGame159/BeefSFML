using System;


namespace SFML.Graphics.GLSL
{
	[CRepr, Ordered]
	public struct Vec4<T>
	{
		public T X;
		public T Y;
		public T Z;
		public T W;

		public this(T x, T y, T z, T w)
		{
			X = x;
			Y = y;
			Z = z;
			W = w;
		}
	}

	[CRepr, Ordered]
	public struct Vec3<T>
	{
		public T X;
		public T Y;
		public T Z;

		public this(T x, T y, T z)
		{
			X = x;
			Y = y;
			Z = z;
		}
	}

	[CRepr, Ordered]
	public struct Vec2<T>
	{
		public T X;
		public T Y;

		public this(T x, T y)
		{
			X = x;
			Y = y;
		}
	}
}
