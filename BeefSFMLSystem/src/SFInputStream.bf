using System;
using System.IO;

namespace SFML.System
{
	[CRepr, Ordered]
	public struct SFInputStream
	{
		public function int64 ReadCallback(void* data, int64 size, void* userData);
		public function int64 SeekCallback(int64 position, void* userData);

		public function int64 TellGetSizeCallback(void* userData);

		public ReadCallback Read;
		public SeekCallback Seek;
		public TellGetSizeCallback Tell;
		public TellGetSizeCallback GetSize;
	}

	public class StreamConverter
	{
		///TODO: Implement
	}
}
