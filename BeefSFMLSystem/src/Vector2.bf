using System;

namespace SFML.System
{
	extension Vector2f {

		public float SquareMagnitude => (X * X) + (Y * Y);
		public float Magnitude => Math.Sqrt(SquareMagnitude);

		public Vector2f Normalized
		{
			get {
				float inverseNormal = 1f / Math.Sqrt(SquareMagnitude);
				return Vector2f((X * inverseNormal), (Y * inverseNormal));
			}
		}

		public Vector2f Zero => Vector2f(0f, 0f);
		public static explicit operator Vector2f(Vector2i v)  { return Vector2f(v.X, v.Y); }
	}

	extension Vector2i {
		public int SquareMagnitude => (X * X) + (Y * Y);
		public int Magnitude => (int)Math.Sqrt(SquareMagnitude);

		public Vector2i Normalized
		{
			get {
				float inverseNormal = 1f / Math.Sqrt(SquareMagnitude);
				return Vector2i((int)(X * inverseNormal), (int)(Y * inverseNormal));
			}
		}

		public Vector2i Zero => Vector2i(0, 0);
	}

	extension Vector2u32 {
		public uint32 SquareMagnitude => (X * X) + (Y * Y);
		public uint32 Magnitude => (uint32)Math.Sqrt(SquareMagnitude);

		public Vector2u32 Normalized
		{
			get {
				float inverseNormal = 1f / Math.Sqrt(SquareMagnitude);
				return Vector2u32((uint32)(X * inverseNormal), (uint32)(Y * inverseNormal));
			}
		}

		public Vector2i Zero => Vector2i(0, 0);
	}

	[CRepr]
	public struct Vector2f
	{
		public float X;
		public float Y;

		public this(float x, float y)
		{
			X = x;
			Y = y;
		}

		public static Vector2f operator+(Vector2f lhs, Vector2f rhs) { return Vector2f(lhs.X + rhs.X, lhs.Y + rhs.Y); }
		public static Vector2f operator-(Vector2f lhs, Vector2f rhs) { return Vector2f((lhs.X - rhs.X), (lhs.Y - rhs.Y)); }
	}

	[CRepr]
	public struct Vector2i : IEquatable<Vector2i>, IHashable
	{
		public int X;
		public int Y;

		public this(int x, int y)
		{
			X = x;
			Y = y;
		}

		public bool Equals(Vector2i other) => (X == other.X && Y == other.Y);
		public int GetHashCode() => (((X << 5) + X) ^ Y);

		public static Vector2i operator+(Vector2i lhs, Vector2i rhs) { return Vector2i(lhs.X + rhs.X, lhs.Y + rhs.Y); }
		public static Vector2i operator-(Vector2i lhs, Vector2i rhs) { return Vector2i((lhs.X - rhs.X), (lhs.Y - rhs.Y)); }

		public override void ToString(System.String strBuffer)
		{
			strBuffer.AppendF("[{}, {}]", X, Y);
		}
	}

	[CRepr]
	public struct Vector2u32 : IEquatable<Vector2u32>, IHashable
	{
		public uint32 X;
		public uint32 Y;

		public this(uint32 x, uint32 y)
		{
			X = x;
			Y = y;
		}

		public bool Equals(Vector2u32 other) => (X == other.X && Y == other.Y);
		public int GetHashCode() => (((X << 5) + X) ^ Y);

		public static Vector2u32 operator+(Vector2u32 lhs, Vector2u32 rhs) { return Vector2u32(lhs.X + rhs.X, lhs.Y + rhs.Y); }
		public static Vector2u32 operator-(Vector2u32 lhs, Vector2u32 rhs) { return Vector2u32((uint32)(lhs.X - rhs.X), (uint32)(lhs.Y - rhs.Y)); }

		public override void ToString(System.String strBuffer)
		{
			strBuffer.AppendF("[{}, {}]", X, Y);
		}
	}
}
