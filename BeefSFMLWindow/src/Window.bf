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

	public class Window : NativeHandle
	{
		protected bool _windowDestroyed;

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

		protected this(void* handle) : base(handle) {};

		public ~this()
		{
			if(!_windowDestroyed)
				sfWindow_destroy(_handle);
		}

		protected virtual bool PollEvent(out WindowEvent event) => sfWindow_pollEvent(_handle, out event);
		public virtual bool IsOpen => sfWindow_isOpen(_handle);
		public virtual void Close() => sfWindow_close(_handle);
		public virtual void Display() => sfWindow_display(_handle);
		public virtual void SetMouseCursor(Cursor cursor) => sfWindow_setMouseCursor(_handle, cursor.[Friend]_handle);


		protected virtual void Dispose(bool skipToBase)
		{
			if (skipToBase) {
				base.Dispose();
				return;
			}

			Dispose();
		}

		public override void Dispose()
		{
			if (IsOpen)
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
		private static extern void* sfWindow_create(VideoMode mode, char8* title, Styles style, ref ContextSettings settings);

		[Import(CSFML_WINDOW), CLink]
		private static extern void* sfWindow_createUnicode(VideoMode mode, void* title, Styles style, ref ContextSettings settings);

		[Import(CSFML_WINDOW), CLink]
		private static extern void* sfWindow_createFromHandle(void* handle, ref ContextSettings settings);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_destroy(void* handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfWindow_isOpen(void* handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_close(void* handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfWindow_pollEvent(void* handle, out WindowEvent event);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfWindow_waitEvent(void* handle, out WindowEvent event);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_display(void* handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern ContextSettings sfWindow_getSettings(void* handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern Vector2i sfWindow_getPosition(void* handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setPosition(void* handle, Vector2i position);

		[Import(CSFML_WINDOW), CLink]
		private static extern Vector2u32 sfWindow_getSize(void* handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setSize(void* handle, Vector2u32 size);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setTitle(void* handle, char8* title);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setUnicodeTitle(void* handle, void* title);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setIcon(void* handle, uint32 width, uint32 height, uint8* pixels);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setVisible(void* handle, bool visible);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setMouseCursorVisible(void* handle, bool Show);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setMouseCursorGrabbed(void* handle, bool grabbed);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setMouseCursor(void* handle, void* cursor);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setVerticalSyncEnabled(void* handle, bool enable);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setKeyRepeatEnabled(void* handle, bool enable);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfWindow_setActive(void* handle, bool active);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setFramerateLimit(void* handle, uint32 limit);

		[Import(CSFML_WINDOW), CLink]
		private static extern uint32 sfWindow_getFrameTime(void* handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_setJoystickThreshold(void* handle, float threshold);

		[Import(CSFML_WINDOW), CLink]
		private static extern void* sfWindow_getSystemHandle(void* handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfWindow_requestFocus(void* handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfWindow_hasFocus(void* handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern Vector2i sfMouse_getPosition(void* handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfMouse_setPosition(Vector2i position, void* handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern Vector2i sfTouch_getPosition(uint32 finger, void* relativeTo);
	}
}
