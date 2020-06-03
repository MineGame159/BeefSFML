using System;

namespace SFML.System
{
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
		public this(float value) : this(value, value) {}

		public float SquareMagnitude => (X * X) + (Y * Y);
		public float Magnitude => Math.Sqrt(SquareMagnitude);

		public Vector2f Normalized
		{
			get {
				float inverseNormal = 1f / Math.Sqrt(SquareMagnitude);
				return Vector2f((X * inverseNormal), (Y * inverseNormal));
			}
		}

		public static Vector2f Zero => Vector2f(0f, 0f);
		public static Vector2f Right => Vector2f(1f, 0f);
		public static Vector2f Up => Vector2f(0f, 1f);

		public static Vector2f operator+(Vector2f lhs, Vector2f rhs) { return Vector2f(lhs.X + rhs.X, lhs.Y + rhs.Y); }
		public static Vector2f operator+(Vector2f lhs, float scalar) { return Vector2f(lhs.X + scalar, lhs.Y + scalar); }

		public static Vector2f operator-(Vector2f lhs, Vector2f rhs) { return Vector2f(lhs.X - rhs.X, lhs.Y - rhs.Y); }
		public static Vector2f operator-(Vector2f lhs, float scalar) { return Vector2f(lhs.X - scalar, lhs.Y - scalar); }

		public static Vector2f operator*(Vector2f lhs, Vector2f rhs) { return Vector2f(lhs.X * rhs.X, lhs.Y * rhs.Y); }
		public static Vector2f operator*(Vector2f lhs, float scalar) { return Vector2f(lhs.X * scalar, lhs.Y * scalar); }

		public static Vector2f operator/(Vector2f lhs, Vector2f rhs) { return Vector2f(lhs.X / rhs.X, lhs.Y / rhs.Y); }
		public static Vector2f operator/(Vector2f lhs, float scalar) { return Vector2f(lhs.X / scalar, lhs.Y / scalar); }

		public static Vector2f operator-(Vector2f rhs) { return Vector2f(-rhs.X, -rhs.Y); }

		public static implicit operator Vector2f(Vector2i v)  { return Vector2f(v.X, v.Y); }
		public static implicit operator Vector2f(Vector2u32 v) { return Vector2f(v.X, v.Y); }

		public override void ToString(String strBuffer)
		{
			strBuffer.AppendF("[{}, {}]", X, Y);
		}

		public bool Equals(Vector2i other) => (X == other.X && Y == other.Y);
		public int GetHashCode() => ((((int32)X << 5) + (int32)X) ^ (int32)Y);
	}

	[CRepr]
	public struct Vector2i : IEquatable<Vector2i>, IHashable
	{
		public int32 X;
		public int32 Y;

		public this(int32 x, int32 y)
		{
			X = x;
			Y = y;
		}
		public this(int32 value) : this(value, value) {}

		public int32 SquareMagnitude => (X * X) + (Y * Y);
		public int32 Magnitude => (int32)Math.Sqrt(SquareMagnitude);

		public Vector2i Normalized
		{
			get {
				float inverseNormal = 1f / Math.Sqrt(SquareMagnitude);
				return Vector2i((int32)(X * inverseNormal), (int32)(Y * inverseNormal));
			}
		}

		public static Vector2i Zero => Vector2i(0, 0);
		public static Vector2f Right => Vector2f(1f, 0f);
		public static Vector2f Up => Vector2f(0f, 1f);

		public static Vector2i operator+(Vector2i lhs, Vector2i rhs) { return Vector2i(lhs.X + rhs.X, lhs.Y + rhs.Y); }
		public static Vector2i operator+(Vector2i lhs, float scalar) { return Vector2i((int32)(lhs.X + scalar), (int32)(lhs.Y + scalar)); }

		public static Vector2i operator-(Vector2i lhs, Vector2i rhs) { return Vector2i(lhs.X - rhs.X, lhs.Y - rhs.Y); }
		public static Vector2i operator-(Vector2i lhs, float scalar) { return Vector2i((int32)(lhs.X - scalar), (int32)(lhs.Y - scalar)); }

		public static Vector2i operator*(Vector2i lhs, Vector2i rhs) { return Vector2i(lhs.X * rhs.X, lhs.Y * rhs.Y); }
		public static Vector2i operator*(Vector2i lhs, float scalar) { return Vector2i((int32)(lhs.X * scalar), (int32)(lhs.Y * scalar)); }

		public static Vector2i operator/(Vector2i lhs, Vector2i rhs) { return Vector2i(lhs.X / rhs.X, lhs.Y / rhs.Y); }
		public static Vector2i operator/(Vector2i lhs, float scalar) { return Vector2i((int32)(lhs.X / scalar), (int32)(lhs.Y / scalar)); }
		
		public static Vector2i operator-(Vector2i rhs) { return Vector2i(-rhs.X, -rhs.Y); }

		public static explicit operator Vector2i(Vector2u32 v) { return Vector2i((int32)v.X, (int32)v.Y); }
		public static explicit operator Vector2i(Vector2f v)  { return Vector2i((int32)v.X, (int32)v.Y); }

		public override void ToString(String strBuffer)
		{
			strBuffer.AppendF("[{}, {}]", X, Y);
		}

		public bool Equals(Vector2i other) => (X == other.X && Y == other.Y);
		public int GetHashCode() => (((X << 5) + X) ^ Y);
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
		public this(uint32 value) : this(value, value) {}

		public uint32 SquareMagnitude => (X * X) + (Y * Y);
		public uint32 Magnitude => (uint32)Math.Sqrt(SquareMagnitude);

		public Vector2u32 Normalized
		{
			get {
				float inverseNormal = 1f / Math.Sqrt(SquareMagnitude);
				return Vector2u32((uint32)(X * inverseNormal), (uint32)(Y * inverseNormal));
			}
		}

		public static Vector2u32 Zero => Vector2u32(0, 0);
		public static Vector2u32 Right => Vector2u32(1, 0);
		public static Vector2u32 Up => Vector2u32(0, 1);

		public static Vector2u32 operator+(Vector2u32 lhs, Vector2u32 rhs) { return Vector2u32(lhs.X + rhs.X, lhs.Y + rhs.Y); }
		public static Vector2u32 operator+(Vector2u32 lhs, float scalar) { return Vector2u32((uint32)(lhs.X + scalar), (uint32)(lhs.Y + scalar)); }

		public static Vector2u32 operator-(Vector2u32 lhs, Vector2u32 rhs) { return Vector2u32((uint32) (lhs.X - rhs.X), (uint32) (lhs.Y - rhs.Y)); }
		public static Vector2u32 operator-(Vector2u32 lhs, float scalar) { return Vector2u32((uint32)(lhs.X - scalar), (uint32)(lhs.Y - scalar)); }

		public static Vector2u32 operator*(Vector2u32 lhs, Vector2u32 rhs) { return Vector2u32(lhs.X * rhs.X, lhs.Y * rhs.Y); }
		public static Vector2u32 operator*(Vector2u32 lhs, float scalar) { return Vector2u32((uint32)(lhs.X * scalar), (uint32)(lhs.Y * scalar)); }

		public static Vector2u32 operator/(Vector2u32 lhs, Vector2u32 rhs) { return Vector2u32(lhs.X / rhs.X, lhs.Y / rhs.Y); }
		public static Vector2u32 operator/(Vector2u32 lhs, float scalar) { return Vector2u32((uint32)(lhs.X / scalar), (uint32)(lhs.Y / scalar)); }

		public static Vector2u32 operator-(Vector2u32 rhs) { return Vector2u32((uint32)-rhs.X, (uint32)-rhs.Y); }

		public static explicit operator Vector2u32(Vector2i v) { return Vector2u32((uint32)v.X, (uint32)v.Y); }
		public static explicit operator Vector2u32(Vector2f v)  { return Vector2u32((uint32)v.X, (uint32)v.Y); }

		public override void ToString(String strBuffer)
		{
			strBuffer.AppendF("[{}, {}]", X, Y);
		}

		public bool Equals(Vector2u32 other) => (X == other.X && Y == other.Y);
		public int GetHashCode() => (((X << 5) + X) ^ Y);
	}
}
