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
		public static implicit operator FloatRect(IntRect r) { return FloatRect(r.Left, r.Top, r.Width, r.Height); }
	}

	[CRepr, Ordered]
	public struct FloatRect
	{
		public float Left;
		public float Top;
		public float Width;
		public float Height;

		public this(Vector2f position, Vector2f size) : this(position.X, position.Y, size.X, size.Y) {}
		public this(float left, float top, float width, float height)
		{
		    Left = left;
		    Top = top;
		    Width = width;
		    Height = height;
		}


		public bool Contains(float x, float y)
		{
		    float minX = Math.Min(Left, Left + Width);
		    float maxX = Math.Max(Left, Left + Width);
		    float minY = Math.Min(Top, Top + Height);
		    float maxY = Math.Max(Top, Top + Height);

		    return (x >= minX) && (x < maxX) && (y >= minY) && (y < maxY);
		}

		public bool Intersects(FloatRect rect, out FloatRect overlap)
		{
			overlap = FloatRect(0f, 0f, 0f, 0f);

		    float r1MinX = Math.Min(Left, Left + Width);
		    float r1MaxX = Math.Max(Left, Left + Width);
		    float r1MinY = Math.Min(Top, Top + Height);
		    float r1MaxY = Math.Max(Top, Top + Height);

		    float r2MinX = Math.Min(rect.Left, rect.Left + rect.Width);
		    float r2MaxX = Math.Max(rect.Left, rect.Left + rect.Width);
		    float r2MinY = Math.Min(rect.Top, rect.Top + rect.Height);
		    float r2MaxY = Math.Max(rect.Top, rect.Top + rect.Height);

		    float r3Left = Math.Max(r1MinX, r2MinX);
		    float r3Top = Math.Max(r1MinY, r2MinY);
		    float r3Right = Math.Min(r1MaxX, r2MaxX);
		    float r3Bottom = Math.Min(r1MaxY, r2MaxY);

		    if ((r3Left < r3Right) && (r3Top < r3Bottom)) {
				overlap = FloatRect(r3Left, r3Top, r3Right - r3Left, r3Bottom - r3Top);
		        return true;
		    }
			return false;
		}

		public override void ToString(String buffer) => buffer.AppendF("[FloatRect]: Left({}), Top({}), Width({}), Height({})", Left, Top, Width, Height);
		public static explicit operator IntRect(FloatRect r) { return IntRect((int)r.Left, (int)r.Top, (int)r.Width, (int)r.Height); }
	}
}
