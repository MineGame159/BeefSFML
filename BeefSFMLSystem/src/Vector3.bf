using System;

namespace SFML.System
{
	extension Vector3f {

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
		public static explicit operator Vector2f(Vector3f v)  { return Vector2f(v.X, v.Y); }
	}


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

		public static Vector3f operator+(Vector3f lhs, Vector3f rhs) { return Vector3f((lhs.X + rhs.X), (lhs.Y + rhs.Y), (lhs.Z + rhs.Z)); }
		public static Vector3f operator-(Vector3f lhs, Vector3f rhs) { return Vector3f((lhs.X - rhs.X), (lhs.Y - rhs.Y), (lhs.Z - rhs.Z)); }
	}
}
