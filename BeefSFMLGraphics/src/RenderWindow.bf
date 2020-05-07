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

	public class RenderWindow : Window
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

		public ~this() { delete _defaultView; }

		protected override void Destroy() { sfRenderWindow_destroy(_handle); }

		protected override bool PollEvent(out WindowEvent event) { return sfRenderWindow_pollEvent(_handle, out event); }
		public override bool IsOpen()  { return sfRenderWindow_isOpen(_handle); }
		public override void Close() { sfRenderWindow_close(_handle); }
		public override void Display() { sfRenderWindow_display(_handle); } 
		public override void SetMouseCursor(Cursor cursor)  { sfRenderWindow_setMouseCursor(_handle, cursor.[Friend]_handle); }

		public void ResetGLStates() {sfRenderWindow_resetGLStates(_handle);}
		public void PushGLStates() {sfRenderWindow_pushGLStates(_handle);} 
		public void PopGLStates() {sfRenderWindow_popGLStates(_handle);}
		public bool RestoreGLStates() { return sfRenderWindow_restoreGLStates(_handle); }
		public void ClearColor(Color color) { sfRenderWindow_clear(_handle, color); }
 		public void SetVSync(bool enabled) { sfRenderWindow_setVerticalSyncEnabled(_handle, enabled); }
		public void SetFrameLimit(uint32 limit) { sfRenderWindow_setFramerateLimit(_handle, limit); }

		public Vector2i GetRelativeMousePosition() { return sfMouse_getPositionRenderWindow(_handle); }

		public void DrawVertexBuffer(VertexBuffer buffer, ref RenderStates states) { sfRenderWindow_drawVertexBuffer(_handle, buffer.[Friend]_handle, ref states); }
		public void DrawPrimitive(PrimitiveType type, Vertex[] vertices, ref RenderStates states) { sfRenderWindow_drawPrimitives(_handle, vertices.CArray(), (uint32)vertices.Count, type, ref states); }
		public void DrawSprite(Sprite sprite, ref RenderStates states)
		{
			states.Matrix *= sprite.Transform.GetMatrix();
			sfRenderWindow_drawSprite(_handle, sprite.[Friend]_handle, states);
		}

		public Vector2f FromScreenToWorld(Vector2i coords, View referenceView = null) { return sfRenderWindow_mapPixelToCoords(_handle, coords, referenceView == null ? _view.[Friend]_handle : referenceView.[Friend]_handle); } 
		public Vector2i FromWorldToScreen(Vector2f coords, View referenceView = null) { return sfRenderWindow_mapCoordsToPixel(_handle, coords, referenceView == null ? _view.[Friend]_handle : referenceView.[Friend]_handle); }

		public Vector2u32 Size { get { return sfRenderWindow_getSize(_handle); } };

		public void SetView(View toView) { _view = toView; }
		public IntRect GetViewport(View fromView) { return sfRenderWindow_getViewport(_handle, fromView.[Friend]_handle); }

		public override void Dispose()
		{
			if (IsOpen())
				Close();

			base.Dispose();
		}

		protected override void Init()
		{
			_defaultView = new [Friend]View(sfRenderWindow_getDefaultView(_handle), true);
			_view = _defaultView;
		}

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderWindow_drawSprite(WindowHandle handle, SpriteHandle sprite, RenderStates states);
		
		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_drawVertexBuffer(WindowHandle handle, VertexBufferHandle buffer, ref RenderStates states);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern WindowHandle sfRenderWindow_create(VideoMode mode, char8* title, Styles style, ref ContextSettings settings);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern WindowHandle sfRenderWindow_createUnicode(VideoMode mode, uint8* title, Styles style, ref ContextSettings settings);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern WindowHandle sfRenderWindow_createFromHandle(WindowHandle handle, ref ContextSettings settings);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_destroy(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_close(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfRenderWindow_isOpen(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern ContextSettings sfRenderWindow_getSettings(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfRenderWindow_pollEvent(WindowHandle handle, out WindowEvent event);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfRenderWindow_waitEvent(WindowHandle handle, out WindowEvent event);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern Vector2i sfRenderWindow_getPosition(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setPosition(WindowHandle handle, Vector2i position);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern Vector2u32 sfRenderWindow_getSize(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setSize(WindowHandle handle, Vector2u32 size);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setTitle(WindowHandle handle, char8* title);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setUnicodeTitle(WindowHandle handle, uint8* utf32Title);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setIcon(WindowHandle handle, uint32 width, uint32 height, uint8* pixels);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setVisible(WindowHandle handle, bool visible);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setVerticalSyncEnabled(WindowHandle handle, bool enable);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setMouseCursorVisible(WindowHandle handle, bool visible);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setMouseCursorGrabbed(WindowHandle handle, bool grabbed);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setMouseCursor(WindowHandle handle, CursorHandle cursor);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setKeyRepeatEnabled(WindowHandle handle, bool enable);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setFramerateLimit(WindowHandle handle, uint32 limit);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setJoystickThreshold(WindowHandle handle, float threshold);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfRenderWindow_setActive(WindowHandle handle, bool active);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_requestFocus(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfRenderWindow_hasFocus(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_display(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern WindowHandle sfRenderWindow_getSystemHandle(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_clear(WindowHandle handle, Color color);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_setView(WindowHandle handle, void* view);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern WindowHandle sfRenderWindow_getView(void* view);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern ViewHandle sfRenderWindow_getDefaultView(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern IntRect sfRenderWindow_getViewport(WindowHandle handle, ViewHandle targetView);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern Vector2f sfRenderWindow_mapPixelToCoords(WindowHandle handle, Vector2i point, ViewHandle view);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern Vector2i sfRenderWindow_mapCoordsToPixel(WindowHandle handle, Vector2f point, ViewHandle view);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_drawPrimitives(WindowHandle handle, Vertex* vertices, uint32 vertexCount, PrimitiveType type, ref RenderStates renderStates);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_pushGLStates(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_popGLStates(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderWindow_resetGLStates(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern WindowHandle sfRenderWindow_capture(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern Vector2i sfMouse_getPositionRenderWindow(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfMouse_setPositionRenderWindow(Vector2i position, WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern Vector2i sfTouch_getPositionRenderWindow(uint32 finger, WindowHandle relativeTo);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfRenderWindow_saveGLStates(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern bool sfRenderWindow_restoreGLStates(WindowHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern uint sfRenderWindow_getFrameTime(WindowHandle handle);
	}
}
