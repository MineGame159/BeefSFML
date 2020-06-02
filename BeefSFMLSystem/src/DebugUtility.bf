using System;

namespace SFML.System
{
	static  sealed class DebugUtility
	{
		public static mixin DebugMessage(String message)
		{
			#if DEBUG
				Console.WriteLine(message);
			#endif			
		}
	}
}
