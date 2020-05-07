using System;
using SFML.System;
using SFML.Window;

namespace SFML.Graphics
{
	public class View : SFHandle<ViewHandle>
	{
		protected bool _isDefaultView;

		public this() : base(sfView_create()) { }
		private this(ViewHandle handle, bool defaultView) : base(handle) { _isDefaultView = defaultView; }
		public ~this()
		{
			if (!_isDefaultView)
				sfView_destroy(_handle);
		}

		public override void Dispose()
		{
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
		private static extern ViewHandle sfView_create();

		[Import(CSFML_GRAPHICS), CLink]
		static extern ViewHandle sfView_createFromRect(FloatRect vect);

		[Import(CSFML_GRAPHICS), CLink]
		static extern ViewHandle sfView_copy(ViewHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_destroy(ViewHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_setCenter(ViewHandle handle, Vector2f center);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_setSize(ViewHandle handle, Vector2f size);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_setRotation(ViewHandle handle, float angle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_setViewport(ViewHandle handle, FloatRect viewport);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_reset(ViewHandle handle, FloatRect rectangle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Vector2f sfView_getCenter(ViewHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Vector2f sfView_getSize(ViewHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern float sfView_getRotation(ViewHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern FloatRect sfView_getViewport(ViewHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_move(ViewHandle handle, Vector2f offset);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_rotate(ViewHandle handle, float angle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfView_zoom(ViewHandle handle, float factor);
	}
}
