using System;
using SFML.System;

namespace SFML.Network
{
	public class UdpSocket : SFHandle<UdpSocketHandle>
	{
		public this() : base(sfUdpSocket_create()) {}
		public ~this() { sfUdpSocket_destroy(_handle); }

		public bool Blocking
		{
			get { return sfUdpSocket_isBlocking(_handle) == 1 ? true : false; }
			set { sfUdpSocket_setBlocking(_handle, value == true ? 1 : 0); }
		}

		public uint16 GetLocalPort() => sfUdpSocket_getLocalPort(_handle);

		public SocketStatus Bind(uint16 port, IpAddress address) => sfUdpSocket_bind(_handle, port, address);
		public void Unbind() => sfUdpSocket_unbind(_handle);

		public SocketStatus Send(uint8* data, uint64 size, IpAddress remoteAddress, uint16 remotePort) => sfUdpSocket_send(_handle, data, size, remoteAddress, remotePort);
		public SocketStatus SendPacket(Packet packet, IpAddress remoteAddress, uint16 remotePort) => sfUdpSocket_sendPacket(_handle, packet.[Friend]_handle, remoteAddress, remotePort);

		public SocketStatus Receive(uint8* data, uint64 size, ref uint64 received, IpAddress remoteAddress, uint16 remotePort) => sfUdpSocket_receive(_handle, data, size, &received, remoteAddress, remotePort);
		public SocketStatus ReceivePacket(Packet packet, IpAddress remoteAddress, uint16 remotePort) => sfUdpSocket_receivePacket(_handle, packet.[Friend]_handle, remoteAddress, remotePort);

		public static uint GetMaxDatagramSize() => sfUdpSocket_maxDatagramSize();

		// Native functions

		[Import(CSFML_NETWORK), CLink]
		private static extern UdpSocketHandle sfUdpSocket_create();
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfUdpSocket_destroy(UdpSocketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfUdpSocket_setBlocking(UdpSocketHandle handle, int blocking);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int sfUdpSocket_isBlocking(UdpSocketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern uint16 sfUdpSocket_getLocalPort(UdpSocketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern SocketStatus sfUdpSocket_bind(UdpSocketHandle handle, uint16 port, IpAddress address);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfUdpSocket_unbind(UdpSocketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern SocketStatus sfUdpSocket_send(UdpSocketHandle handle, void* data, uint64 size, IpAddress remoteAddress, uint16 remotePort);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern SocketStatus sfUdpSocket_receive(UdpSocketHandle handle, void* data, uint64 size, uint64* received, IpAddress remoteAddress, uint16 remotePort);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern SocketStatus sfUdpSocket_sendPacket(UdpSocketHandle handle, PacketHandle packet, IpAddress remoteAddress, uint16 remotePort);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern SocketStatus sfUdpSocket_receivePacket(UdpSocketHandle handle, PacketHandle packet, IpAddress remoteAddress, uint16 remotePort);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern uint sfUdpSocket_maxDatagramSize();
	}
}
