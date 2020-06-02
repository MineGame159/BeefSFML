using System;
using SFML.System;

namespace SFML.Graphics
{
	public class ConvexShape : Shape
	{

		private Vector2f[] _points;

		public this(ref uint32 pointCount) { SetPointCount(ref pointCount); }

		public ~this() { delete _points; }

		protected override uint32 GetPointCount() => (uint32)_points.Count;
		protected override Vector2f GetPoint(uint32 index) => _points[index];

		public void SetPointCount(ref uint32 count)
		{
			if (count < 3) {
				count = 3;
				DebugUtility.DebugMessage!("Point count too low! Point count must be greater than 2 to produce a valid shape. Increased count to 3.");
			}

			if (_points == null) {
				_points = new Vector2f[count];
			} else if (count > _points.Count - 1) {
				delete _points;
				_points = new Vector2f[count];
			}

			Update();
		}

		public Result<void> SetPoint(uint32 index, Vector2f point)
		{
			if (index > _points.Count - 1)
				return .Err;

			_points[index] = point;
			Update();

			return .Ok;
		}
	}
}
