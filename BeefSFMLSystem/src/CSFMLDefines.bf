using System;

namespace SFML.System
{
	static {

		#if DEBUG		
			public const String CSFML_AUDIO 	= "csfml-audio-d-2.dll";
			public const String CSFML_SYSTEM 	= "csfml-system-d-2.dll";
			public const String CSFML_WINDOW 	= "csfml-window-d-2.dll";
			public const String CSFML_GRAPHICS 	= "csfml-graphics-d-2.dll";
		#else
			public const String CSFML_AUDIO 	= "csfml-audio-2.dll";
			public const String CSFML_SYSTEM 	= "csfml-system-2.dll";
			public const String CSFML_WINDOW 	= "csfml-window-2.dll";
			public const String CSFML_GRAPHICS 	= "csfml-graphics-2.dll";	
		#endif
	}
}
