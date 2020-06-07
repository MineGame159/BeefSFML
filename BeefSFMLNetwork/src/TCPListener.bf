using System;
using SFML.System;

namespace SFML.Network
{
	public class TcpListener : TcpSocket
	{
		public this() : base(sfTcpListener_create()) {}
		public ~this() { sfTcpListener_destroy(_handle); deleted = true; }

		public override bool Blocking
		{
			get { return sfTcpListener_isBlocking(_handle) == 1 ? true : false; }
			set { sfTcpListener_setBlocking(_handle, value == true ? 1 : 0); }
		}

		public override uint16 GetLocalPort() => sfTcpListener_getLocalPort(_handle);

		public SocketStatus Listen(uint16 port, IpAddress address) => sfTcpListener_listen(_handle, port, address);
		public SocketStatus Accept(TcpSocket connected)
		{
			TcpSocketHandle connectedHandle = connected.[Friend]_handle;
			return sfTcpListener_accept(_handle, &connectedHandle);
		}

		// Native functions
		
		[Import(CSFML_NETWORK), CLink]
		private static extern TcpSocketHandle sfTcpListener_create();
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfTcpListener_destroy(TcpSocketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfTcpListener_setBlocking(TcpSocketHandle handle, int blocking);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int sfTcpListener_isBlocking(TcpSocketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern uint16 sfTcpListener_getLocalPort(TcpSocketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern SocketStatus sfTcpListener_listen(TcpSocketHandle handle, uint16 port, IpAddress address);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern SocketStatus sfTcpListener_accept(TcpSocketHandle handle, TcpSocketHandle* connected);
	}
}
