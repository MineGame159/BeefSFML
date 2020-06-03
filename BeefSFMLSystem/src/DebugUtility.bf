using System;

namespace SFML.System
{
	static  sealed class DebugUtility
	{
		public static mixin DebugMessage(Object obj)
		{
#if DEBUG
			Console.WriteLine(obj);
#endif
		}

		public static mixin DebugMessage(String fmt, params Object[] args) {
#if DEBUG
			Console.WriteLine(fmt, args);
#endif
		}

		public static mixin DebugMessage(String message)
		{
#if DEBUG
				Console.WriteLine(message);
#endif			
		}

		public static mixin DebugMessage() {
#if DEBUG
			Console.WriteLine();
#endif
		}
	}
}
