using System;
using SFML.System;

namespace SFML.Graphics
{
	public class CircleShape : Shape
	{
		private float _radius;
		private uint32 _pointCount;

		public this(float radius, uint32 pointCount)
		{
			var pointCount;
			Radius = radius;
			SetPointCount(pointCount);
		}

		public float Radius {
			get { return _radius; }
			set {
				_radius = value;
				Update();
			}
		}

		protected override Vector2f GetPoint(uint32 index)
		{
		    float angle = (float)(index * 2 * Math.PI_f / _pointCount - Math.PI_f / 2);
		    float x = (float)Math.Cos(angle) * _radius;
		    float y = (float)Math.Sin(angle) * _radius;

		    return Vector2f(_radius + x, _radius + y);
		}

		protected override uint32 GetPointCount() => _pointCount;

		public void SetPointCount(uint32 count)
		{
			var count;
			if (count < 3) {
				count = 3;
				DebugUtility.DebugMessage!("Point count too low! Point count must be greater than 2 to produce a valid shape. Increased count to 3.");
			}

			_pointCount = count;
			Update();
		}
	}
}
