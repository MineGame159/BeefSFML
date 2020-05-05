using System;
using SFML.System;
using SFML.Window;

namespace SFML.Graphics
{
	public class View : NativeHandle
	{
		private readonly bool _default = false;

		public this() : base(sfView_create()) { }
		private this(void* handle, bool isDefault) : base(handle) { _default = isDefault; }

		public override void Dispose()
		{

			Console.WriteLine("Disposing some crap");
			if (!_default)
				sfView_destroy(_handle);

			base.Dispose();
		}

		public Vector2f Center
		{
			get { return sfView_getCenter(_handle); }
			set { sfView_setCenter(_handle, value); }
		};

		public Vector2f Size
		{
			get { return sfView_getSize(_handle); }
			set { sfView_setSize(_handle, value); }
		}

		public float Rotation
		{
			get { return sfView_getRotation(_handle); }
			set { sfView_setRotation(_handle, value); }
		}

		public FloatRect Viewport
		{
			get { return sfView_getViewport(_handle); }
			set { sfView_setViewport(_handle, value); }
		}

		public void Reset(FloatRect rectangle) => sfView_reset(_handle, rectangle);
		public void Move(Vector2f offset) => sfView_move(_handle, offset);
		public void Zoom(float factor) => sfView_zoom(_handle, factor);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void* sfView_create();

		[Import(CSFML_GRAPHICS), CLink]
		static extern void* sfView_createFromRect(FloatRect vect);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void* sfView_copy(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_destroy(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_setCenter(void* handle, Vector2f center);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_setSize(void* handle, Vector2f size);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_setRotation(void* handle, float angle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_setViewport(void* handle, FloatRect viewport);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_reset(void* handle, FloatRect rectangle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Vector2f sfView_getCenter(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Vector2f sfView_getSize(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern float sfView_getRotation(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern FloatRect sfView_getViewport(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_move(void* handle, Vector2f offset);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_rotate(void* handle, float angle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_zoom(void* handle, float factor);
	}
}
