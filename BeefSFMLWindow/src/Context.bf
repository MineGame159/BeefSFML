using System;
using SFML.System;

namespace SFML.Window
{
	class Context : SFHandle<ContextHandle>
	{
		public this() : base(sfContext_create()) {}
		public ~this() { sfContext_destroy(_handle); }

		public bool SetActive(bool active) => sfContext_setActive(_handle, active);
		
		public ContextSettings ContextSettings => sfContext_getSettings(_handle);


		public static bool IsExtensionAvailable(StringView name) => sfContext_isExtensionAvailable(name.ToScopeCStr!());

		public static void* GetFunction(StringView name) => sfContext_getFunction(name.ToScopeCStr!());

		// Native functions

		[Import(CSFML_WINDOW), CLink]
		private static extern ContextHandle sfContext_create();

		[Import(CSFML_WINDOW), CLink]
		private static extern void sfContext_destroy(ContextHandle context);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfContext_setActive(ContextHandle context, bool active);

		[Import(CSFML_WINDOW), CLink]
		static extern ContextSettings sfContext_getSettings(ContextHandle handle);

		[Import(CSFML_WINDOW), CLink]
		private static extern bool sfContext_isExtensionAvailable(void* name);

		[Import(CSFML_WINDOW), CLink]
		private static extern void* sfContext_getFunction(void* name);

		[Import(CSFML_WINDOW), CLink]
		private static extern ContextHandle sfContext_getActiveContext();
	}
}
