using System;
using System.Collections;
using SFML.System;

namespace SFML.Audio
{
	function int SoundRecorderStartCallback(void* userData);
	function int SoundRecorderProcessCallback(int16* samples, uint64 size, void* userData);
	function void SoundRecorderStopCallback(void* userData);

	public class SoundRecorder : SFHandle<SoundRecorderHandle>
	{
		protected bool deleted;

		public this(SoundRecorderHandle handle) : base(handle) {}
		public this(SoundRecorderStartCallback onStart, SoundRecorderProcessCallback onProcess, SoundRecorderStopCallback onStop, void* userData) : base(sfSoundRecorder_create(onStart, onProcess, onStop, userData)) {}
		public ~this() { if (!deleted) sfSoundRecorder_destroy(_handle); }

		public uint ChannelCount
		{
			get { return sfSoundRecorder_getChannelCount(_handle); }
			set { sfSoundRecorder_setChannelCount(_handle, value); }
		}

		public virtual bool Start(uint sampleRate) => sfSoundRecorder_start(_handle, sampleRate) == 1 ? true : false;
		public virtual void Stop() => sfSoundRecorder_stop(_handle);

		public virtual uint GetSampleRate() => sfSoundRecorder_getSampleRate(_handle);
		public bool IsAvailable() => sfSoundRecorder_isAvailable(_handle) == 1 ? true : false;
		public void SetProcessingInterval(Time interval) => sfSoundRecorder_setProcessingInterval(_handle, interval);

		public virtual bool SetDevice(String name) => sfSoundRecorder_setDevice(_handle, name.CStr()) == 1 ? true : false;
		public virtual bool SetDevice(StringView name) => sfSoundRecorder_setDevice(_handle, name.ToScopeCStr!()) == 1 ? true : false;

		public virtual void GetDevice(String buffer) => buffer.Append(sfSoundRecorder_getDevice(_handle));

		public static void GetAvailableDevices(List<String> buffer)
		{
			uint64 count = 0;
			char8** devices = sfSoundRecorder_getAvailableDevices(&count);
			for (uint64 i < count) buffer.Add(new String(devices[i]));
		}

		public static void GetDefaultDevice(String buffer) => buffer.Append(sfSoundRecorder_getDefaultDevice());

		// Native functions

		[Import(CSFML_AUDIO), CLink]
		private static extern SoundRecorderHandle sfSoundRecorder_create(SoundRecorderStartCallback onStart, SoundRecorderProcessCallback onProcess, SoundRecorderStopCallback onStop, void* userData);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSoundRecorder_destroy(SoundRecorderHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern int sfSoundRecorder_start(SoundRecorderHandle handle, uint sampleRate);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSoundRecorder_stop(SoundRecorderHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern uint sfSoundRecorder_getSampleRate(SoundRecorderHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern int sfSoundRecorder_isAvailable(SoundRecorderHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSoundRecorder_setProcessingInterval(SoundRecorderHandle handle, Time interval);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern char8** sfSoundRecorder_getAvailableDevices(uint64* count);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern char8* sfSoundRecorder_getDefaultDevice();
		
		[Import(CSFML_AUDIO), CLink]
		private static extern int sfSoundRecorder_setDevice(SoundRecorderHandle handle, char8* name);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern char8* sfSoundRecorder_getDevice(SoundRecorderHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSoundRecorder_setChannelCount(SoundRecorderHandle handle, uint channelCount);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern uint sfSoundRecorder_getChannelCount(SoundRecorderHandle handle);
	}
}
