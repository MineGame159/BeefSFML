using System;
using SFML.System;

namespace SFML.Network
{
	public class SocketSelector : SFHandle<SocketSelectorHandle>
	{
		public this() : base(sfSocketSelector_create()) {}
		public this(SocketSelector selector) : base(sfSocketSelector_copy(selector._handle)) {}
		public ~this() { sfSocketSelector_destroy(_handle); }

		public void AddTcpListener(TcpListener listener) => sfSocketSelector_addTcpListener(_handle, listener.[Friend]_handle);
		public void AddTcpSocket(TcpSocket socket) => sfSocketSelector_addTcpSocket(_handle, socket.[Friend]_handle);
		public void AddUdpSocket(UdpSocket socket) => sfSocketSelector_addUdpSocket(_handle, socket.[Friend]_handle);

		public void RemoveTcpListener(TcpListener listener) => sfSocketSelector_removeTcpListener(_handle, listener.[Friend]_handle);
		public void RemoveTcpSocket(TcpSocket socket) => sfSocketSelector_removeTcpSocket(_handle, socket.[Friend]_handle);
		public void RemoveUdpSocket(UdpSocket socket) => sfSocketSelector_removeUdpSocket(_handle, socket.[Friend]_handle);

		public void Clear() => sfSocketSelector_clear(_handle);

		public bool Wait(Time timeout) => sfSocketSelector_wait(_handle, timeout) == 1 ? true : false;

		public bool IsTcpListenerReady(TcpListener listener) => sfSocketSelector_isTcpListenerReady(_handle, listener.[Friend]_handle) == 1 ? true : false;
		public bool IsTcpSocketReady(TcpSocket socket) => sfSocketSelector_isTcpSocketReady(_handle, socket.[Friend]_handle) == 1 ? true : false;
		public bool IsUdpSocketReady(UdpSocket socket) => sfSocketSelector_isUdpSocketReady(_handle, socket.[Friend]_handle) == 1 ? true : false;

		// Native functions

		[Import(CSFML_NETWORK), CLink]
		private static extern SocketSelectorHandle sfSocketSelector_create();
		
		[Import(CSFML_NETWORK), CLink]
		private static extern SocketSelectorHandle sfSocketSelector_copy(SocketSelectorHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfSocketSelector_destroy(SocketSelectorHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfSocketSelector_addTcpListener(SocketSelectorHandle handle, TcpSocketHandle socket);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfSocketSelector_addTcpSocket(SocketSelectorHandle handle, TcpSocketHandle socket);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfSocketSelector_addUdpSocket(SocketSelectorHandle handle, UdpSocketHandle socket);

		[Import(CSFML_NETWORK), CLink]
		private static extern void sfSocketSelector_removeTcpListener(SocketSelectorHandle handle, TcpSocketHandle socket);

		[Import(CSFML_NETWORK), CLink]
		private static extern void sfSocketSelector_removeTcpSocket(SocketSelectorHandle handle, TcpSocketHandle socket);

		[Import(CSFML_NETWORK), CLink]
		private static extern void sfSocketSelector_removeUdpSocket(SocketSelectorHandle handle, UdpSocketHandle socket);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfSocketSelector_clear(SocketSelectorHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int sfSocketSelector_wait(SocketSelectorHandle handle, Time timeout);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int sfSocketSelector_isTcpListenerReady(SocketSelectorHandle handle, TcpSocketHandle socket);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int sfSocketSelector_isTcpSocketReady(SocketSelectorHandle handle, TcpSocketHandle socket);

		[Import(CSFML_NETWORK), CLink]
		private static extern int sfSocketSelector_isUdpSocketReady(SocketSelectorHandle handle, UdpSocketHandle socket);
	}
}
