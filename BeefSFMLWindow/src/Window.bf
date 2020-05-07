using System;
using System.Collections;
using SFML.System;
using System.Text;

namespace SFML.Window
{
	public delegate void ClosedEvent(Window window);
	public delegate void ResizedEvent(Window window, SizeEventData data);

	public delegate void FocusGainedEvent(Window window);
	public delegate void FocusLostEvent(Window window);

	public delegate void KeyPressedEvent(Window window, KeyEventData data);
	public delegate void KeyReleasedEvent(Window window, KeyEventData data);

	public delegate void MouseMovedEvent(Window window, MouseMoveEventData data);
	public delegate void MouseEnteredEvent(Window window);
	public delegate void MouseLeftEvent(Window window);
	public delegate void MouseWheelScrolledEvent(Window window, MouseWheelScrollEventData data);
	public delegate void MouseButtonPressedEvent(Window window, MouseButtonEventData data);
	public delegate void MouseButtonReleasedEvent(Window window, MouseButtonEventData data);

	public enum Styles
	{
		None = 0,
		Titlebar = 1 << 0,
		Resize = 1 << 1,
		Close = 1 << 2,
		Fullscreen = 1 << 3,
		Default = Titlebar | Resize | Close
	}

	public class Window : SFHandle<WindowHandle>
	{
		public Event<ClosedEvent> ClosedEvent;
		public Event<ResizedEvent> ResizedEvent;

		public Event<FocusGainedEvent> FocusGainedEvent;
		public Event<FocusLostEvent> FocusLostEvent;

		public Event<KeyPressedEvent> KeyPressedEvent;
		public Event<KeyReleasedEvent> KeyReleasedEvent;

		public Event<MouseLeftEvent> MouseLeftEvent;
		public Event<MouseMovedEvent> MouseMovedEvent;
		public Event<MouseEnteredEvent> MouseEnteredEvent;
		public Event<MouseWheelScrolledEvent> MouseScrolledEvent;
		public Event<MouseButtonPressedEvent> MouseButtonPressedEvent;
		public Event<MouseButtonReleasedEvent> MouseButtonReleasedEvent;

		public this(VideoMode mode, uint8[] utf32Title) : this(mode, utf32Title, Styles.Default, ref ContextSettings(0, 0)) {}
		public this(VideoMode mode, uint8[] utf32Title, Styles styles) : this(mode, utf32Title, styles, ref ContextSettings(0, 0)) {}
		public this(VideoMode mode, uint8[] utf32Title, Styles styles, ref ContextSettings settings) : base(sfWindow_createUnicode(mode, utf32Title.CArray(), styles, ref settings)) {}

		public this(VideoMode mode, String title) : this(mode, title, Styles.Default, ref ContextSettings(0, 0)) {}
		public this(VideoMode mode, String title, Styles styles) : this(mode, title, styles, ref ContextSettings(0, 0)) {} 
		public this(VideoMode mode, String title, Styles styles, ref ContextSettings settings) : base(sfWindow_create(mode, title, styles, ref settings)) {}

		protected this(WindowHandle handle) : base(handle) {};

		public ~this() { Destroy(); }

		protected virtual bool PollEvent(out WindowEvent event) { return sfWindow_pollEvent(_handle, out event); }
		public virtual bool IsOpen()  { return sfWindow_isOpen(_handle); }
		public virtual void Close() { sfWindow_close(_handle); }
		public virtual void Display() { sfWindow_display(_handle); } 
		public virtual void SetMouseCursor(Cursor cursor)  { sfWindow_setMouseCursor(_handle, cursor.[Friend]_handle); }

		protected virtual void Destroy()
		{
			sfWindow_destroy(_handle);
		}

		protected virtual void Init() { }

		public override void Dispose()
		{
			if (IsOpen())
				Close();

			base.Dispose();
		}

		public void DispatchEvents()
		{
			WindowEvent event;

			while (PollEvent(out event)) {
				switch (event.Type) {
					case .Closed: {
						ClosedEvent.Invoke(this);
						return;
					}
					case .GainedFocus: {
						FocusGainedEvent.Invoke(this);
						return;
					}
					case .LostFocus: {
						FocusLostEvent.Invoke(this);
						return;
					}
					case .Resized: {
						ResizedEvent.Invoke(this, event.Size);
					}
					case .KeyPressed: {
						KeyPressedEvent.Invoke(this, event.Key);
						return;
					}
					case .KeyReleased: {
						KeyReleasedEvent.Invoke(this, event.Key);
						return;
					}
					case .MouseEntered: {
						MouseEnteredEvent.Invoke(this);
						return;	
					}
					case .MouseLeft: {
						MouseLeftEvent.Invoke(this);
						return;
					}
					case .MouseMoved: {
						MouseMovedEvent.Invoke(this, event.MouseMove);
						return;
					}
					case .MouseButtonPressed: {
						MouseButtonPressedEvent.Invoke(this, event.MouseButton);
						return;
					}
					case .MouseButtonReleased: {
						MouseButtonReleasedEvent.Invoke(this, event.MouseButton);
						return;
					}
					case .MouseWheelScrolled: {
						MouseScrolledEvent.Invoke(this, event.MouseScroll);
						return;
					}
 				default:
				}
			}
		}

		[Import(CSFML_WINDOW), CLink]
		private static extern WindowHandle sfWindow_create(VideoMode mode, char8* title, Styles style, ref ContextSettings settings);

		[Import(CSFML_WINDOW), CLink]
		private static extern WindowHandle sfWindow_createUnicode(VideoMode mode, void* title, Styles style, ref ContextSettings settings);

		[Import(CSFML_WINDOW), CLink]
		private static extern WindowHandle sfWindow_createFromHandle(WindowHandle handle, ref ContextSettings settings);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_destroy(WindowHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfWindow_isOpen(WindowHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_close(WindowHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfWindow_pollEvent(WindowHandle handle, out WindowEvent event);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfWindow_waitEvent(WindowHandle handle, out WindowEvent event);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_display(WindowHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern ContextSettings sfWindow_getSettings(WindowHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern Vector2i sfWindow_getPosition(WindowHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setPosition(WindowHandle handle, Vector2i position);

		[Import(CSFML_WINDOW), CLink]
		private static extern Vector2u32 sfWindow_getSize(WindowHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setSize(WindowHandle handle, Vector2u32 size);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setTitle(WindowHandle handle, char8* title);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setUnicodeTitle(WindowHandle handle, void* title);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setIcon(WindowHandle handle, uint32 width, uint32 height, uint8* pixels);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setVisible(WindowHandle handle, bool visible);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setMouseCursorVisible(WindowHandle handle, bool Show);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setMouseCursorGrabbed(WindowHandle handle, bool grabbed);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setMouseCursor(WindowHandle handle, CursorHandle cursor);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setVerticalSyncEnabled(WindowHandle handle, bool enable);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setKeyRepeatEnabled(WindowHandle handle, bool enable);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfWindow_setActive(WindowHandle handle, bool active);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setFramerateLimit(WindowHandle handle, uint32 limit);

		[Import(CSFML_WINDOW), CLink]
		private static extern uint32 sfWindow_getFrameTime(WindowHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setJoystickThreshold(WindowHandle handle, float threshold);

		[Import(CSFML_WINDOW), CLink]
		private static extern WindowHandle sfWindow_getSystemHandle(WindowHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_requestFocus(WindowHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfWindow_hasFocus(WindowHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern Vector2i sfMouse_getPosition(WindowHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfMouse_setPosition(Vector2i position, WindowHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern Vector2i sfTouch_getPosition(uint32 finger, void* relativeTo);
	}
}
