using System;

namespace SFML.System
{
	public abstract class SFHandle<T> : IDisposable
	{
		protected readonly T _handle;
		public this() {}
		public this(T handle) { _handle = handle; }

		public virtual void Dispose() { delete this; }
	}
}
