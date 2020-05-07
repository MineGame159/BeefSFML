using System;
using SFML.System;

namespace SFML.Window
{
	class Context : SFHandle<ContextHandle>
	{
		public this() : base(sfContext_create()) {}
		public ~this() { sfContext_destroy(_handle); }

		public static bool SetActive(Context context, bool active) => sfContext_setActive(context.[Friend]_handle, active);
		public ContextSettings ContextSettings => sfContext_getSettings(_handle);

		[Import(CSFML_WINDOW), CLink]
		static extern ContextHandle sfContext_create();

		[Import(CSFML_WINDOW), CLink]
		static extern void sfContext_destroy(ContextHandle context);

		[Import(CSFML_WINDOW), CLink]
		static extern bool sfContext_setActive(ContextHandle context, bool active);

		[Import(CSFML_WINDOW), CLink]
		static extern ContextSettings sfContext_getSettings(ContextHandle handle);
	}
}
