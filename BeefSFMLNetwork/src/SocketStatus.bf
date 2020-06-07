namespace SFML.Network
{
	public enum SocketStatus
	{
		Done,         // The socket has sent / received the data
		Ready,        // The socket is not ready to send / receive data yet
		Partial,      // The socket sent a part of the data
		Disconnected, // The TCP socket has been disconnected
		Error         // An unexpected error happened
	}
}
