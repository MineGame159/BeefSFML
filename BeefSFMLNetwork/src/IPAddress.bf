using System;
using SFML.System;

namespace SFML.Network
{
	[CRepr]
	public struct IpAddress
	{
		private static char8[16] STR;

		public static IpAddress NONE = FromBytes(0, 0, 0, 0);
		public static IpAddress ANY = FromBytes(0, 0, 0, 0);
		public static IpAddress LOCALHOST = FromBytes(127, 0, 0, 1);
		public static IpAddress BROADCAST = FromBytes(255, 255, 255, 255);

		public char8[16] address;

		private this(char8[16] address) { this.address = address; }

		public static IpAddress FromString(StringView address) => sfIpAddress_fromString(address.ToScopeCStr!());
		public static IpAddress FromBytes(uint8 byte0, uint8 byte1, uint8 byte2, uint8 byte3) => sfIpAddress_fromBytes(byte0, byte1, byte2, byte3);
		public static IpAddress FromInt(uint32 address) => sfIpAddress_fromInteger(address);

		public static IpAddress GetLocalAddress() => sfIpAddress_getLocalAddress();
		public static IpAddress GetPublicAddress(Time timeout) => sfIpAddress_getPublicAddress(timeout);

		public uint32 ToInt() => sfIpAddress_toInteger(this);

		public override void ToString(String strBuffer)
		{
			sfIpAddress_toString(this, &STR);
			strBuffer.Append(&STR);
		}

		// Native functions
		
		[Import(CSFML_NETWORK), CLink]
		private static extern IpAddress sfIpAddress_fromString(char8* address);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern IpAddress sfIpAddress_fromBytes(uint8 byte0, uint8 byte1, uint8 byte2, uint8 byte3);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern IpAddress sfIpAddress_fromInteger(uint32 address);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfIpAddress_toString(IpAddress address, char8* string);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern uint32 sfIpAddress_toInteger(IpAddress address);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern IpAddress sfIpAddress_getLocalAddress();
		
		[Import(CSFML_NETWORK), CLink]
		private static extern IpAddress sfIpAddress_getPublicAddress(Time timeout);
	}
}
