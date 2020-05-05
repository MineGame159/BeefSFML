using System;

namespace SFML.System
{
	public abstract class NativeHandle : IDisposable
	{
		protected void* _handle = null;

		public this(void* handle) { _handle = handle; }
		public ~this() { _handle = null; }

		public virtual void Dispose() { delete this; }
	}
}
