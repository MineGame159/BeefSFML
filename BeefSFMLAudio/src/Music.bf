using System;
using System.IO;
using SFML.System;

namespace SFML.Audio
{
	[CRepr]
	public struct SFTimeSpan
	{
		public Time offset;
		public Time length;

		public this(Time offset, Time length)
		{
			this.offset = offset;
			this.length = length;
		}
	}

	public class Music : SFHandle<MusicHandle>
	{
		public this(StringView filename) : base(sfMusic_createFromFile(filename.ToScopeCStr!())) {}
		public this(uint8* data, uint64 size) : base(sfMusic_createFromMemory(data, size)) {}
		public this(Stream stream) : base(sfMusic_createFromStream(scope SFStreamAdapter(stream).GetCompatibleStream())) {}
		public ~this() { sfMusic_destroy(_handle); }

		public bool Loop
		{
			get { return sfMusic_getLoop(_handle) == 1 ? true : false; }
			set { sfMusic_setLoop(_handle, value == true ? 1 : 0); }
		}

		public SFTimeSpan LoopPoints
		{
			get { return sfMusic_getLoopPoints(_handle); }
			set { sfMusic_setLoopPoints(_handle, value); }
		}

		public float Pitch
		{
			get { return sfMusic_getPitch(_handle); }
			set { sfMusic_setPitch(_handle, value); }
		}

		public float Volume
		{
			get { return sfMusic_getVolume(_handle); }
			set { sfMusic_setVolume(_handle, value); }
		}

		public Vector3f Position
		{
			get { return sfMusic_getPosition(_handle); }
			set { sfMusic_setPosition(_handle, value); }
		}

		public bool RelativeToListener
		{
			get { return sfMusic_isRelativeToListener(_handle) == 1 ? true : false; }
			set { sfMusic_setRelativeToListener(_handle, value == true ? 1 : 0); }
		}

		public float MinDistance
		{
			get { return sfMusic_getMinDistance(_handle); }
			set { sfMusic_setMinDistance(_handle, value); }
		}

		public float Attenuation
		{
			get { return sfMusic_getAttenuation(_handle); }
			set { sfMusic_setAttenuation(_handle, value); }
		}

		public Time PlayingOffset
		{
			get { return sfMusic_getPlayingOffset(_handle); }
			set { sfMusic_setPlayingOffset(_handle, value); }
		}

		public void Play() => sfMusic_play(_handle);
		public void Pause() => sfMusic_pause(_handle);
		public void Stop() => sfMusic_stop(_handle);

		public Time GetDuration() => sfMusic_getDuration(_handle);
		public SoundStatus GetStatus() => sfMusic_getStatus(_handle);

		public uint GetChannelCount() => sfMusic_getChannelCount(_handle);
		public uint GetSampleRate() => sfMusic_getSampleRate(_handle);

		// Native functions

		[Import(CSFML_AUDIO), CLink]
		private static extern MusicHandle sfMusic_createFromFile(char8* filename);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern MusicHandle sfMusic_createFromMemory(void* data, uint64 sizeInBytes);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern MusicHandle sfMusic_createFromStream(InputStream stream);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfMusic_destroy(MusicHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfMusic_setLoop(MusicHandle handle, int loop);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern int sfMusic_getLoop(MusicHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern Time sfMusic_getDuration(MusicHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern SFTimeSpan sfMusic_getLoopPoints(MusicHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfMusic_setLoopPoints(MusicHandle handle, SFTimeSpan loopPoints);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfMusic_play(MusicHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfMusic_pause(MusicHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfMusic_stop(MusicHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern uint sfMusic_getChannelCount(MusicHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern uint sfMusic_getSampleRate(MusicHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern SoundStatus sfMusic_getStatus(MusicHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfMusic_setPitch(MusicHandle handle, float pitch);

		[Import(CSFML_AUDIO), CLink]
		private static extern float sfMusic_getPitch(MusicHandle handle);

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfMusic_setVolume(MusicHandle handle, float volume);

		[Import(CSFML_AUDIO), CLink]
		private static extern float sfMusic_getVolume(MusicHandle handle);

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfMusic_setPosition(MusicHandle handle, Vector3f position);

		[Import(CSFML_AUDIO), CLink]
		private static extern Vector3f sfMusic_getPosition(MusicHandle handle);

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfMusic_setRelativeToListener(MusicHandle handle, int relative);

		[Import(CSFML_AUDIO), CLink]
		private static extern int sfMusic_isRelativeToListener(MusicHandle handle);

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfMusic_setMinDistance(MusicHandle handle, float distance);

		[Import(CSFML_AUDIO), CLink]
		private static extern float sfMusic_getMinDistance(MusicHandle handle);

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfMusic_setAttenuation(MusicHandle handle, float attenuation);

		[Import(CSFML_AUDIO), CLink]
		private static extern float sfMusic_getAttenuation(MusicHandle handle);

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfMusic_setPlayingOffset(MusicHandle handle, Time timeOffset);

		[Import(CSFML_AUDIO), CLink]
		private static extern Time sfMusic_getPlayingOffset(MusicHandle handle);
	}
}
