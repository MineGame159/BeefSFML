using System;
using System.IO;

namespace SFML.System
{
	function int64 InputStreamReadFunc(void* data, int64 size, void* userData);
	function int64 InputStreamSeekFunc(int64 position, void* userData);
	function int64 InputStreamTellFunc(void* userData);
	function int64 InputStreamSizeFunc(void* userData);

	[CRepr, Ordered]
	public struct InputStream
	{
		public InputStreamReadFunc Read;
		public InputStreamSeekFunc Seek;
		public InputStreamTellFunc Tell;
		public InputStreamSizeFunc GetSize;
		public void* UserData;
	}
	
	public class SFStreamAdapter
	{
		private InputStream _sfStream;

		public this(Stream stream)
		{
			_sfStream.Read = => Read;
			_sfStream.Seek = => Seek;
			_sfStream.Tell = => Tell;
			_sfStream.GetSize = => GetSize;
			_sfStream.UserData = Internal.UnsafeCastToPtr(stream);
		}

		private static int64 Read(void* data, int64 size, void* userData)
		{
			let stream = (Stream)Internal.UnsafeCastToObject(userData);
			let span = Span<uint8>((uint8*)data, size);

			switch (stream.TryRead(span)) {
				case .Ok(int val): return val;
				case .Err: Runtime.FatalError("Bad stream in SFStreamAdapter");
			}
		}

		private static int64 Seek(int64 position, void* userData)
		{
			let stream = (Stream)Internal.UnsafeCastToObject(userData);

			switch (stream.Seek(position, .Absolute)) {
				case .Ok: return stream.Position;
				case .Err: Runtime.FatalError("Bad stream in SFStreamAdapter");
			}
		}

		private static int64 Tell(void* userData)
		{
			let stream = (Stream)Internal.UnsafeCastToObject(userData);
			return stream.Position;
		}

		private static int64 GetSize(void* userData)
		{
			let stream = (Stream)Internal.UnsafeCastToObject(userData);
			return stream.Length;
		}

		public InputStream GetCompatibleStream() => _sfStream;
	}
}
