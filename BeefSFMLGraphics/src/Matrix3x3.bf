using System;
using SFML.System;

namespace SFML.Graphics
{
	[CRepr, Ordered]
	public struct Matrix3x3
	{
		private float _m00, _m01, _m02;
		private float _m10, _m11, _m12;
		private float _m20, _m21, _m22;

		public this(float m00, float m01, float m02, float m10,
		float m11, float m12, float m20, float m21, float m22)
		{
			_m00 = m00;
			_m01 = m01;
			_m02 = m02;
			_m10 = m10;
			_m11 = m11;
			_m12 = m12;
			_m20 = m20;
			_m21 = m21;
			_m22 = m22;
		}

		public static Matrix3x3 Identity => Matrix3x3(1f, 0f, 0f,
											   		  0f, 1f, 0f,
			                                   		  0f, 0f, 1f);

		public Matrix3x3 Inverse => sfTransform_getInverse(this);
		public Vector2f TransformPoint(Matrix3x3 matrix, Vector2f point) => sfTransform_transformPoint(matrix, point);
 		public FloatRect TransformRect(Matrix3x3 matrix, FloatRect rectangle) => sfTransform_transformRect(matrix, rectangle);

		public void CombineWith(Matrix3x3 other) => sfTransform_combine(this, other);
		public void Translate(ref Matrix3x3 matrix, float x, float y) => sfTransform_translate(matrix, x, y);
		public void Rotate(ref Matrix3x3 matrix, float angle) => sfTransform_rotate(matrix, angle);
 		public void RotateWithCenter(float angle, float cX, float cY) => sfTransform_rotateWithCenter(this, angle, cX, cY);
		public void Scale(float x, float y) => sfTransform_scale(this, x, y);
		public void ScaleWithCenter(float x, float y, float cX, float cY)  => sfTransform_scaleWithCenter(this, x, y, cX, cY);

		public bool MatrixEqualsTo(Matrix3x3 other) =>  sfTransform_equal(this, other);

		public static explicit Matrix3x3 operator *(Matrix3x3 left, Matrix3x3 right)
		{
			left.CombineWith(right);
			return left;
		}

		[Import(CSFML_GRAPHICS), CLink]
		private static extern Matrix3x3 sfTransform_getInverse(Matrix3x3 transform);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern Vector2f sfTransform_transformPoint(Matrix3x3 transform, Vector2f point);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern FloatRect sfTransform_transformRect(Matrix3x3 transform, FloatRect rectangle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfTransform_combine(Matrix3x3 transform, Matrix3x3 other);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfTransform_translate(Matrix3x3 transform, float x, float y);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfTransform_rotate(Matrix3x3 transform, float angle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfTransform_rotateWithCenter(Matrix3x3 transform, float angle, float centerX, float centerY);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfTransform_scale(Matrix3x3 transform, float scaleX, float scaleY);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfTransform_scaleWithCenter(Matrix3x3 transform, float scaleX, float scaleY, float centerX, float centerY);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfTransform_equal(Matrix3x3 left, Matrix3x3 right);
	}
}
