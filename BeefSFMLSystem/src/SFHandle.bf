using System;

namespace SFML.System
{
	public abstract class SFHandle<T> : IDisposable
	{
		protected T _handle;
		public this() {}
		public this(T handle) { _handle = handle; }
		public ~this() {  }

		public virtual void Dispose() { delete this; }
	}
}
