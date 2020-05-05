using System;
using SFML.System;
using SFML.Window;

namespace SFML.Graphics
{
	public enum PrimitiveType
	{
		Points,
		Lines,
		LineStrip,
		Triangles,
		TriangleStrip,
		TriangleFan,
		Quads,
	}

	public class RenderWindow : Window, IRenderTarget
	{
		private View _view = null;
		private View _defaultView = null;

		public View CurrentView => _view;
		public View DefaultView => _defaultView;

		public this(VideoMode mode, uint8[] utf32Title) : this(mode, utf32Title, Styles.Default, ref ContextSettings(0, 0)) {}
		public this(VideoMode mode, uint8[] utf32Title, Styles styles) : this(mode, utf32Title, styles, ref ContextSettings(0, 0)) {}
		public this(VideoMode mode, uint8[] utf32Title, Styles styles, ref ContextSettings settings) : base(sfRenderWindow_createUnicode(mode, utf32Title.CArray(), styles, ref settings)) { Init(); }

		public this(VideoMode mode, String title) : this(mode, title, Styles.Default, ref ContextSettings(0, 0)) {}
		public this(VideoMode mode, String title, Styles styles) : this(mode, title, styles, ref ContextSettings(0, 0)) {}
		public this(VideoMode mode, String title, Styles styles, ref ContextSettings settings) : base (sfRenderWindow_create(mode, title, styles, ref settings)) { Init(); }

		public ~this()
		{
			sfRenderWindow_destroy(_handle);
			_windowDestroyed = true;

			if (_view == _defaultView) {
				delete _defaultView;
			} else {
				delete _view;
				delete _defaultView;
			}
		}

		protected override bool PollEvent(out WindowEvent event) => sfRenderWindow_pollEvent(_handle, out event);

		public override bool IsOpen => sfRenderWindow_isOpen(_handle);
		public override void Close() => sfRenderWindow_close(_handle);
		public override void Display() => sfRenderWindow_display(_handle);
		public override void SetMouseCursor(Cursor cursor) => sfRenderWindow_setMouseCursor(_handle, cursor.[Friend]_handle);

		public void ResetGLStates() => sfRenderWindow_resetGLStates(_handle);
		public void PushGLStates() => sfRenderWindow_pushGLStates(_handle);
		public void PopGLStates() => sfRenderWindow_popGLStates(_handle);
		public bool RestoreGLStates() => sfRenderWindow_restoreGLStates(_handle);
		public void ClearColor(Color color) => sfRenderWindow_clear(_handle, color);

		public void DrawVertexBuffer(VertexBuffer buffer, ref RenderStates states) => sfRenderWindow_drawVertexBuffer(_handle, buffer.[Friend]_handle, ref states);
		public void DrawPrimitive(PrimitiveType type, Vertex[] vertices, ref RenderStates states) => sfRenderWindow_drawPrimitives(_handle, vertices.CArray(), (uint32)vertices.Count, type, ref states);

		public Vector2f FromScreenToWorld(Vector2i coords, View referenceView = null) => sfRenderWindow_mapPixelToCoords(_handle, coords, referenceView.[Friend]_handle ?? _view.[Friend]_handle);
		public Vector2i FromWorldToScreen(Vector2f coords, View referenceView = null) => sfRenderWindow_mapCoordsToPixel(_handle, coords, referenceView.[Friend]_handle ?? _view.[Friend]_handle);

		public Vector2u32 Size { get { return sfRenderWindow_getSize(_handle); } };

		public void SetView(View toView) { _view = toView; }
		public IntRect GetViewport(View fromView) => sfRenderWindow_getViewport(_handle, fromView.[Friend]_handle);

		public override void Dispose()
		{
			if (IsOpen)
				Close();

			base.Dispose(true);
		}

		private void Init()
		{
			_defaultView = new [Friend]View(sfRenderWindow_getDefaultView(_handle), true);
			_view = _defaultView;
		}
		
		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_drawVertexBuffer(void* handle, void* buffer, ref RenderStates states);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void* sfRenderWindow_create(VideoMode mode, char8* title, Styles style, ref ContextSettings settings);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void* sfRenderWindow_createUnicode(VideoMode mode, uint8* title, Styles style, ref ContextSettings settings);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void* sfRenderWindow_createFromHandle(void* handle, ref ContextSettings settings);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_destroy(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_close(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfRenderWindow_isOpen(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern ContextSettings sfRenderWindow_getSettings(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfRenderWindow_pollEvent(void* handle, out WindowEvent event);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfRenderWindow_waitEvent(void* handle, out WindowEvent event);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern Vector2i sfRenderWindow_getPosition(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setPosition(void* handle, Vector2i position);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern Vector2u32 sfRenderWindow_getSize(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setSize(void* handle, Vector2u32 size);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setTitle(void* handle, char8* title);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setUnicodeTitle(void* handle, uint8* utf32Title);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setIcon(void* handle, uint32 width, uint32 height, uint8* pixels);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setVisible(void* handle, bool visible);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setVerticalSyncEnabled(void* handle, bool enable);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setMouseCursorVisible(void* handle, bool visible);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setMouseCursorGrabbed(void* handle, bool grabbed);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setMouseCursor(void* window, void* cursor);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setKeyRepeatEnabled(void* handle, bool enable);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setFramerateLimit(void* handle, uint32 limit);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setJoystickThreshold(void* handle, float threshold);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfRenderWindow_setActive(void* handle, bool active);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_requestFocus(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfRenderWindow_hasFocus(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_display(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void* sfRenderWindow_getSystemHandle(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_clear(void* handle, Color color);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setView(void* handle, void* view);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void* sfRenderWindow_getView(void* view);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void* sfRenderWindow_getDefaultView(void* view);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern IntRect sfRenderWindow_getViewport(void* handle, void* targetView);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern Vector2f sfRenderWindow_mapPixelToCoords(void* handle, Vector2i point, void* view);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern Vector2i sfRenderWindow_mapCoordsToPixel(void* handle, Vector2f point, void* view);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_drawPrimitives(void* handle, Vertex* vertices, uint32 vertexCount, PrimitiveType type, ref RenderStates renderStates);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_pushGLStates(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_popGLStates(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_resetGLStates(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void* sfRenderWindow_capture(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern Vector2i sfMouse_getPositionRenderWindow(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfMouse_setPositionRenderWindow(Vector2i position, void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern Vector2i sfTouch_getPositionRenderWindow(uint32 finger, void* relativeTo);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfRenderWindow_saveGLStates(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfRenderWindow_restoreGLStates(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern uint sfRenderWindow_getFrameTime(void* handle);
	}
}
