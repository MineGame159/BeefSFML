using System;
using SFML.System;

namespace SFML.Graphics
{
	[CRepr, Ordered]
	public struct IntRect
	{
		public int Left;
		public int Top;
		public int Width;
		public int Height;

		public this(Vector2i position, Vector2i size) : this(position.X, position.Y, size.X, size.Y) {}
		public this(int left, int top, int width, int height)
		{
		    Left = left;
		    Top = top;
		    Width = width;
		    Height = height;
		}

		public bool Contains(int x, int y)
		{
		    int minX = Math.Min(Left, Left + Width);
		    int maxX = Math.Max(Left, Left + Width);
		    int minY = Math.Min(Top, Top + Height);
		    int maxY = Math.Max(Top, Top + Height);

		    return ( x >= minX ) && ( x < maxX ) && ( y >= minY ) && ( y < maxY );
		}

		public bool Intersects(IntRect rect, out IntRect overlap)
		{
			overlap = IntRect(0, 0, 0, 0);

		    int r1MinX = Math.Min(Left, Left + Width);
		    int r1MaxX = Math.Max(Left, Left + Width);
		    int r1MinY = Math.Min(Top, Top + Height);
		    int r1MaxY = Math.Max(Top, Top + Height);

		    int r2MinX = Math.Min(rect.Left, rect.Left + rect.Width);
		    int r2MaxX = Math.Max(rect.Left, rect.Left + rect.Width);
		    int r2MinY = Math.Min(rect.Top, rect.Top + rect.Height);
		    int r2MaxY = Math.Max(rect.Top, rect.Top + rect.Height);

		    int r3Left = Math.Max(r1MinX, r2MinX);
		    int r3Top = Math.Max(r1MinY, r2MinY);
		    int r3Right = Math.Min(r1MaxX, r2MaxX);
		    int r3Bottom = Math.Min(r1MaxY, r2MaxY);

		    if ((r3Left < r3Right) && (r3Top < r3Bottom)) {
				overlap = IntRect(r3Left, r3Top, r3Right - r3Left, r3Bottom - r3Top);
		        return true;
		    }
			return false;
		}

		public override void ToString(String buffer) => buffer.AppendF("[Int32Rect]: Left({}), Top({}), Width({}), Height({})", Left, Top, Width, Height);
		public static explicit operator IntRect(FloatRect r) { return IntRect((.)r.Left, (.)r.Top, (.)r.Width, (.)r.Height); }
	}
}
