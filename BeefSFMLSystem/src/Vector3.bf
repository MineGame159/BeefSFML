using System;

namespace SFML.System
{
	[CRepr]
	struct Vector3f
	{
		public float X;
		public float Y;
		public float Z;

		public this(float x, float y, float z)
		{
			X = x;
			Y = y;
			Z = z;
		}
		public this(float value) : this(value, value, value) {}

		public float SquareMagnitude => (X * X) + (Y * Y) + (Z * Z);
		public float Magnitude => Math.Sqrt(SquareMagnitude);

		public Vector3f Normalized
		{
			get {
				float inverseNormal = 1f / Math.Sqrt(SquareMagnitude);
				return Vector3f((X * inverseNormal), (Y * inverseNormal), (Z * inverseNormal));
			}
		}

		public Vector3f Zero => Vector3f(0, 0, 0);

		public static Vector3f operator+(Vector3f lhs, Vector3f rhs) { return Vector3f(lhs.X + rhs.X, lhs.Y + rhs.Y, lhs.Z + rhs.Z); }
		public static Vector3f operator+(Vector3f lhs, float scalar) { return Vector3f(lhs.X + scalar, lhs.Y + scalar, lhs.Z + scalar); }

		public static Vector3f operator-(Vector3f lhs, Vector3f rhs) { return Vector3f(lhs.X - rhs.X, lhs.Y - rhs.Y, lhs.Z - rhs.Z); }
		public static Vector3f operator-(Vector3f lhs, float scalar) { return Vector3f(lhs.X - scalar, lhs.Y - scalar, lhs.Z - scalar); }

		public static Vector3f operator*(Vector3f lhs, Vector3f rhs) { return Vector3f(lhs.X * rhs.X, lhs.Y * rhs.Y, lhs.Z * rhs.Z); }
		public static Vector3f operator*(Vector3f lhs, float scalar) { return Vector3f(lhs.X * scalar, lhs.Y * scalar, lhs.Z * scalar); }

		public static Vector3f operator/(Vector3f lhs, Vector3f rhs) { return Vector3f(lhs.X / rhs.X, lhs.Y / rhs.Y, lhs.Z / rhs.Z); }
		public static Vector3f operator/(Vector3f lhs, float scalar) { return Vector3f(lhs.X / scalar, lhs.Y / scalar, lhs.Z / scalar); }

		public static Vector3f operator-(Vector3f rhs) { return Vector3f(-rhs.X, -rhs.Y, -rhs.Z); }

		public override void ToString(String strBuffer)
		{
			strBuffer.AppendF("[{}, {}, {}]", X, Y, Z);
		}

		public bool Equals(Vector3f other) => (X == other.X && Y == other.Y && Z == other.Z);
		[Inline]
		private int CombineHashCodes(int a, int b) => (((a << 5) + a) ^ b);
		public int GetHashCode()
		{
			int hash = X.GetHashCode();
			hash = CombineHashCodes(hash, Y.GetHashCode());
			hash = CombineHashCodes(hash, Z.GetHashCode());
			return hash;
		}
	}
}
