using System;
using SFML.System;

namespace SFML.Audio
{
	public class SoundBufferRecorder : SoundRecorder
	{
		public this() : base(sfSoundBufferRecorder_create()) {}
		public ~this() { sfSoundBufferRecorder_destroy(_handle); deleted = true; }

		public override bool Start(uint sampleRate) => sfSoundBufferRecorder_start(_handle, sampleRate) == 1 ? true : false;
		public override void Stop() => sfSoundBufferRecorder_stop(_handle);

		public override uint GetSampleRate() => sfSoundBufferRecorder_getSampleRate(_handle);

		public SoundBufferHandle GetBuffer() => sfSoundBufferRecorder_getBuffer(_handle);

		public override bool SetDevice(String name) => sfSoundBufferRecorder_setDevice(_handle, name.CStr()) == 1 ? true : false;
		public override bool SetDevice(StringView name) => sfSoundBufferRecorder_setDevice(_handle, name.ToScopeCStr!()) == 1 ? true : false;

		public override void GetDevice(String buffer) => buffer.Append(sfSoundBufferRecorder_getDevice(_handle));

		// Native functions
		
		[Import(CSFML_AUDIO), CLink]
		private static extern SoundRecorderHandle sfSoundBufferRecorder_create();
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSoundBufferRecorder_destroy(SoundRecorderHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern int sfSoundBufferRecorder_start(SoundRecorderHandle handle, uint sampleRate);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSoundBufferRecorder_stop(SoundRecorderHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern uint sfSoundBufferRecorder_getSampleRate(SoundRecorderHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern SoundBufferHandle sfSoundBufferRecorder_getBuffer(SoundRecorderHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern int sfSoundBufferRecorder_setDevice(SoundRecorderHandle handle, char8* name);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern char8* sfSoundBufferRecorder_getDevice(SoundRecorderHandle handle);
	}
}
