using System;
using SFML.System;

namespace SFML.Audio
{
	public enum SoundStatus	: uint32
	{
	    Stopped,
	    Paused,
	    Playing
	}

	public class Sound : SFHandle<SoundHandle>
	{
		public this() : base(sfSound_create()) {}
		public this(Sound sound) : base(sfSound_copy(sound._handle)) {}
		public ~this() { sfSound_destroy(_handle); }

		public bool Loop
		{
			get { return sfSound_getLoop(_handle) == 1 ? true : false; }
			set { sfSound_setLoop(_handle, value == true ? 1 : 0); }
		}

		public float Pitch
		{
			get { return sfSound_getPitch(_handle); }
			set { sfSound_setPitch(_handle, value); }
		}

		public float Volume
		{
			get { return sfSound_getVolume(_handle); }
			set { sfSound_setVolume(_handle, value); }
		}

		public Vector3f Position
		{
			get { return sfSound_getPosition(_handle); }
			set { sfSound_setPosition(_handle, value); }
		}

		public bool RelativeToListener
		{
			get { return sfSound_isRelativeToListener(_handle) == 1 ? true : false; }
			set { sfSound_setRelativeToListener(_handle, value == true ? 1 : 0); }
		}

		public float MinDistance
		{
			get { return sfSound_getMinDistance(_handle); }
			set { sfSound_setMinDistance(_handle, value); }
		}

		public float Attenuation
		{
			get { return sfSound_getAttenuation(_handle); }
			set { sfSound_setAttenuation(_handle, value); }
		}

		public Time PlayingOffset
		{
			get { return sfSound_getPlayingOffset(_handle); }
			set { sfSound_setPlayingOffset(_handle, value); }
		}

		public void Play() => sfSound_play(_handle);
		public void Pause() => sfSound_pause(_handle);
		public void Stop() => sfSound_stop(_handle);

		public void SetBuffer(SoundBuffer buffer) => sfSound_setBuffer(_handle, buffer.[Friend]_handle);
		public void SetBufferRaw(SoundBufferHandle buffer) => sfSound_setBuffer(_handle, buffer);
		public SoundStatus GetStatus() => sfSound_getStatus(_handle);

		// Native functions

		[Import(CSFML_AUDIO), CLink]
		private static extern SoundHandle sfSound_create();

		[Import(CSFML_AUDIO), CLink]
		private static extern SoundHandle sfSound_copy(SoundHandle hangle);

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSound_destroy(SoundHandle handle);

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSound_play(SoundHandle handle);

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSound_pause(SoundHandle handle);

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSound_stop(SoundHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSound_setBuffer(SoundHandle handle, SoundBufferHandle buffer);

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSound_setLoop(SoundHandle handle, int loop);

		[Import(CSFML_AUDIO), CLink]
		private static extern int sfSound_getLoop(SoundHandle handle);

		[Import(CSFML_AUDIO), CLink]
		private static extern SoundStatus sfSound_getStatus(SoundHandle handle);

		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSound_setPitch(SoundHandle handle, float pitch);

		[Import(CSFML_AUDIO), CLink]
		private static extern float sfSound_getPitch(SoundHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSound_setVolume(SoundHandle handle, float volume);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern float sfSound_getVolume(SoundHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSound_setPosition(SoundHandle handle, Vector3f position);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern Vector3f sfSound_getPosition(SoundHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSound_setRelativeToListener(SoundHandle handle, int relative);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern int sfSound_isRelativeToListener(SoundHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSound_setMinDistance(SoundHandle handle, float distance);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern float sfSound_getMinDistance(SoundHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSound_setAttenuation(SoundHandle handle, float attenuation);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern float sfSound_getAttenuation(SoundHandle handle);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern void sfSound_setPlayingOffset(SoundHandle handle, Time timeOffset);
		
		[Import(CSFML_AUDIO), CLink]
		private static extern Time sfSound_getPlayingOffset(SoundHandle handle);
	}
}
