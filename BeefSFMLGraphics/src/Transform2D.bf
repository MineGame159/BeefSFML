using System;
using SFML.System;

namespace SFML.Graphics
{
	//sf::Transformable
	class Transform2D
	{
		private Matrix3x3 _matrix;

		private Vector2f _position;
		private Vector2f _scale;
		private Vector2f _origin;
		private float _rotation;


		private bool _matrixIsDirty = true;

		public this() {
			_matrix = Matrix3x3.Identity;
			_position = Vector2f.Zero;
			_scale = Vector2f(1, 1);
			_origin = Vector2f.Zero;
			_rotation = 0;
		}

		public Vector2f Position
		{
			get { return _position; }
			set {
				_position = value;
				_matrixIsDirty = true;
			}
		}

		public float Rotation
		{
			get { return _rotation; }
			set {
				_rotation = value;
				_matrixIsDirty = true;
			}
		}

		public Vector2f Scale
		{
			get { return _scale; }
			set {
				_scale = value;
				_matrixIsDirty = true;
			}
		}

		public Vector2f Origin
		{
			get { return _origin; }
			set {
				_origin = value;
				_matrixIsDirty = true;
			}
		}

		public Matrix3x3 GetMatrix()
		{

			if (_matrixIsDirty) {
				_matrixIsDirty = false;

				float angle = -_rotation * Math.PI_f / 180.0f;
				float cosine = Math.Cos(angle);
				float sine = Math.Sin(angle);

				float scaleCosX = _scale.X * cosine;
				float scaleCosY = _scale.Y * cosine;

				float scaleSinX = _scale.X * sine;
				float scaleSinY = _scale.Y * sine;

				float tx = -(_origin.X) * scaleCosX - -(_origin.Y) * scaleSinY + _position.X;
				float ty = _origin.X * scaleSinX - _origin.Y * scaleCosY + _position.Y;

				_matrix = Matrix3x3(scaleCosX, scaleSinY, tx,
								   -scaleSinX, scaleCosY, ty,
									0.0f, 0.0f, 1.0f);
			}

			return _matrix;
			
		}
	}
}
