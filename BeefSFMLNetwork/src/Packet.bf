using System;
using SFML.System;

namespace SFML.Network
{
	public class Packet : SFHandle<PacketHandle>
	{
		public this() : base(sfPacket_create()) {}
		public this(Packet packet) : base(sfPacket_copy(packet._handle)) {}
		public ~this() { sfPacket_destroy(_handle); }

		public void Append(uint8* data, uint64 size) => sfPacket_append(_handle, data, size);
		public void Clear() => sfPacket_clear(_handle);
		public Span<uint8> GetData() => Span<uint8>((uint8*) sfPacket_getData(_handle), (int) sfPacket_getDataSize(_handle));

		public bool EndOfPacket() => sfPacket_endOfPacket(_handle) == 1 ? true : false;
		public bool CanRead() => sfPacket_canRead(_handle) == 1 ? true : false;

		public bool ReadBool() => sfPacket_readBool(_handle) == 1 ? true : false;
		public int8 ReadInt8() => sfPacket_readInt8(_handle);
		public uint8 ReadUint8() => sfPacket_readUint8(_handle);
		public int16 ReadInt16() => sfPacket_readInt16(_handle);
		public uint16 ReadUint16() => sfPacket_readUint16(_handle);
		public int32 ReadInt32() => sfPacket_readInt32(_handle);
		public uint32 ReadUint32() => sfPacket_readUint32(_handle);
		public float ReadFloat() => sfPacket_readFloat(_handle);
		public double ReadDouble() => sfPacket_readDouble(_handle);
		public void ReadString(String buffer)
		{
			var length = ReadUint32();
			var str = new:ScopedAlloc! char8[length]*;
			sfPacket_readString(_handle, str);
			buffer.Append(str, length);
		}

		public void WriteBool(bool value) => sfPacket_writeBool(_handle, value == true ? 1 : 0);
		public void WriteInt8(int8 value) => sfPacket_writeInt8(_handle, value);
		public void WriteUint8(uint8 value) => sfPacket_writeUint8(_handle, value);
		public void WriteInt16(int16 value) => sfPacket_writeInt16(_handle, value);
		public void WriteUint16(uint16 value) => sfPacket_writeUint16(_handle, value);
		public void WriteInt32(int32 value) => sfPacket_writeInt32(_handle, value);
		public void WriteUint32(uint32 value) => sfPacket_writeUint32(_handle, value);
		public void WriteFloat(float value) => sfPacket_writeFloat(_handle, value);
		public void WriteDouble(double value) => sfPacket_writeDouble(_handle, value);
		public void WriteString(Span<char8> value)
		{
			WriteUint32((.) value.Length);
			sfPacket_writeString(_handle, value.Ptr);
		}
		public void WriteString(String value) => WriteString(Span<char8>(value.CStr(), value.Length));
		public void WriteString(StringView value) => WriteString(Span<char8>(value.ToScopeCStr!(), value.Length));

		// Native functions

		[Import(CSFML_NETWORK), CLink]
		private static extern PacketHandle sfPacket_create();
		
		[Import(CSFML_NETWORK), CLink]
		private static extern PacketHandle sfPacket_copy(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfPacket_destroy(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfPacket_append(PacketHandle handle, void* data, uint64 sizeInBytes);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfPacket_clear(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void* sfPacket_getData(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern uint64 sfPacket_getDataSize(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int sfPacket_endOfPacket(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int sfPacket_canRead(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int sfPacket_readBool(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int8 sfPacket_readInt8(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern uint8 sfPacket_readUint8(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int16 sfPacket_readInt16(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern uint16 sfPacket_readUint16(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int32 sfPacket_readInt32(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern uint32 sfPacket_readUint32(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern float sfPacket_readFloat(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern double sfPacket_readDouble(PacketHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfPacket_readString(PacketHandle handle, char8* string);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfPacket_writeBool(PacketHandle handle, int value);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfPacket_writeInt8(PacketHandle handle, int8 value);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfPacket_writeUint8(PacketHandle handle, uint8 value);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfPacket_writeInt16(PacketHandle handle, int16 value);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfPacket_writeUint16(PacketHandle handle, uint16 value);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfPacket_writeInt32(PacketHandle handle, int32 value);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfPacket_writeUint32(PacketHandle handle, uint32 value);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfPacket_writeFloat(PacketHandle handle, float value);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfPacket_writeDouble(PacketHandle handle, double value);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfPacket_writeString(PacketHandle handle, char8* value);
	}
}
