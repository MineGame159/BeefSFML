using System;
using SFML.System;

namespace SFML.Graphics
{
	public class RectangleShape : Shape
	{
		private Vector2f _size;

		public Vector2f Size {
			get { return _size; }
			set {
				_size = value;
				Update();
			}
		}

		public this(Vector2f size) { Size = size; }

		protected override Vector2f GetPoint(uint32 index)
		{
			switch (index) {
				case 0: return Vector2f.Zero;
				case 1: return Vector2f(_size.X, 0);
				case 2: return Vector2f(_size.X, _size.Y);
				case 3: return Vector2f(0, _size.Y);
				default: return Vector2f.Zero;
			}
		}

		protected override uint32 GetPointCount() => 4;
	}
}
