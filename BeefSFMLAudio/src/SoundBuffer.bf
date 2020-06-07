using System;
using System.IO;
using SFML.System;

namespace SFML.Audio
{
	public class SoundBuffer : SFHandle<SoundBufferHandle>
	{
		public this(SoundBufferHandle handle) : base(handle) {}
		public this(StringView filename) : base(sfSoundBuffer_createFromFile(filename.ToScopeCStr!())) {}
		public this(uint8* data, uint64 size) : base(sfSoundBuffer_createFromMemory(data, size)) {}
		public this(Stream stream) : base(sfSoundBuffer_createFromStream(scope SFStreamAdapter(stream).GetCompatibleStream())) {}
		public this(int16* samples, uint64 sampleCount, uint channelCount, uint sampleRate) : base(sfSoundBuffer_createFromSamples(samples, sampleCount, channelCount, sampleRate)) {}
		public this(SoundBuffer buffer) : base(sfSoundBuffer_copy(buffer._handle)) {}
		public ~this() { sfSoundBuffer_destroy(_handle); }

		public bool SaveToFile(StringView filename) => sfSoundBuffer_saveToFile(_handle, filename.ToScopeCStr!()) == 1 ? true : false;

		public Span<int16> GetSamples() => Span<int16>(sfSoundBuffer_getSamples(_handle), (int) sfSoundBuffer_getSampleCount(_handle));
		public uint GetSampleRate() => sfSoundBuffer_getSampleRate(_handle);
		public uint GetChannelCount() => sfSoundBuffer_getChannelCount(_handle);
		public Time GetDuration() => sfSoundBuffer_getDuration(_handle);

		// Native functions

		[Import(CSFML_AUDIO), CLink]
		private static extern SoundBufferHandle sfSoundBuffer_createFromFile(char8* filename);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern SoundBufferHandle sfSoundBuffer_createFromMemory(void* data, uint64 sizeInBytes);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern SoundBufferHandle sfSoundBuffer_createFromStream(InputStream stream);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern SoundBufferHandle sfSoundBuffer_createFromSamples(int16* samples, uint64 sampleCount, uint channelCount, uint sampleRate);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern SoundBufferHandle sfSoundBuffer_copy(SoundBufferHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSoundBuffer_destroy(SoundBufferHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern int sfSoundBuffer_saveToFile(SoundBufferHandle handle, char8* filename);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern int16* sfSoundBuffer_getSamples(SoundBufferHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern uint64 sfSoundBuffer_getSampleCount(SoundBufferHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern uint sfSoundBuffer_getSampleRate(SoundBufferHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern uint sfSoundBuffer_getChannelCount(SoundBufferHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern Time sfSoundBuffer_getDuration(SoundBufferHandle handle);
	}
}
