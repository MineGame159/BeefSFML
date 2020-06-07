using System;
using SFML.System;

namespace SFML.Network
{
	public class TcpSocket : SFHandle<TcpSocketHandle>
	{
		protected bool deleted;

		public this(TcpSocketHandle handle) : base(handle) {}
		public this() : base(sfTcpSocket_create()) {}
		public ~this() { if (!deleted) sfTcpSocket_destroy(_handle); }

		public virtual bool Blocking
		{
			get { return sfTcpSocket_isBlocking(_handle) == 1 ? true : false; }
			set { sfTcpSocket_setBlocking(_handle, value == true ? 1 : 0); }
		}

		public virtual uint16 GetLocalPort() => sfTcpSocket_getLocalPort(_handle);
		public IpAddress GetRemoteAddress() => sfTcpSocket_getRemoteAddress(_handle);
		public uint16 GetRemotePort() => sfTcpSocket_getRemotePort(_handle);

		public SocketStatus Connect(IpAddress remoteAddress, uint16 remotePort, Time timeout) => sfTcpSocket_connect(_handle, remoteAddress, remotePort, timeout);
		public void Disconnect() => sfTcpSocket_disconnect(_handle);

		public SocketStatus Send(uint8* data, uint64 size) => sfTcpSocket_send(_handle, data, size);
		public SocketStatus SendPartial(uint8* data, uint64 size, ref uint64 sent) => sfTcpSocket_sendPartial(_handle, data, size, &sent);
		public SocketStatus SendPacket(Packet packet) => sfTcpSocket_sendPacket(_handle, packet.[Friend]_handle);

		public SocketStatus Receive(uint8* data, uint64 size, ref uint64 received) => sfTcpSocket_receive(_handle, data, size, &received);
		public SocketStatus ReceivePacket(Packet packet) => sfTcpSocket_receivePacket(_handle, packet.[Friend]_handle);

		// Native functions

		[Import(CSFML_NETWORK), CLink]
		private static extern TcpSocketHandle sfTcpSocket_create();
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfTcpSocket_destroy(TcpSocketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfTcpSocket_setBlocking(TcpSocketHandle handle, int blocking);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int sfTcpSocket_isBlocking(TcpSocketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern uint16 sfTcpSocket_getLocalPort(TcpSocketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern IpAddress sfTcpSocket_getRemoteAddress(TcpSocketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern uint16 sfTcpSocket_getRemotePort(TcpSocketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern SocketStatus sfTcpSocket_connect(TcpSocketHandle handle, IpAddress remoteAddress, uint16 remotePort, Time timeout);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfTcpSocket_disconnect(TcpSocketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern SocketStatus sfTcpSocket_send(TcpSocketHandle handle, void* data, uint64 sizeInBytes);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern SocketStatus sfTcpSocket_sendPartial(TcpSocketHandle handle, void* data, uint64 sizeInBytes, uint64* sent);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern SocketStatus sfTcpSocket_receive(TcpSocketHandle handle, void* data, uint64 sizeInBytes, uint64* received);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern SocketStatus sfTcpSocket_sendPacket(TcpSocketHandle handle, PacketHandle packet);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern SocketStatus sfTcpSocket_receivePacket(TcpSocketHandle handle, PacketHandle packet);
	}
}
