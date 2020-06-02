using System;
using SFML.System;

namespace SFML.Audio
{
	public class MusicPlayer
	{
		[Import(CSFML_AUDIO), CLink]
		static extern MusicPlayerHandle sfMusic_createFromFile(char8* filename);

		[Import(CSFML_AUDIO), CLink]
		static extern MusicPlayerHandle sfMusic_createFromStream(InputStream stream);

		[Import(CSFML_AUDIO), CLink]
		static extern MusicPlayerHandle sfMusic_createFromMemory(void* data, uint64 size);

		[Import(CSFML_AUDIO), CLink]
		static extern void sfMusic_destroy(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern void sfMusic_play(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern void sfMusic_pause(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern void sfMusic_stop(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern SoundStatus sfMusic_getStatus(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern Time sfMusic_getDuration(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern TimeSpan sfMusic_getLoopPoints(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern TimeSpan sfMusic_setLoopPoints(MusicPlayerHandle handle, TimeSpan timePoints);

		[Import(CSFML_AUDIO), CLink]
		static extern uint sfMusic_getChannelCount(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern uint sfMusic_getSampleRate(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern void sfMusic_setPitch(MusicPlayerHandle handle, float Pitch);

		[Import(CSFML_AUDIO), CLink]
		static extern void sfMusic_setLoop(MusicPlayerHandle handle, bool Loop);

		[Import(CSFML_AUDIO), CLink]
		static extern void sfMusic_setVolume(MusicPlayerHandle handle, float Volume);

		[Import(CSFML_AUDIO), CLink]
		static extern void sfMusic_setPosition(MusicPlayerHandle handle, Vector3f position);

		[Import(CSFML_AUDIO), CLink]
		static extern void sfMusic_setRelativeToListener(MusicPlayerHandle handle, bool Relative);

		[Import(CSFML_AUDIO), CLink]
		static extern void sfMusic_setMinDistance(MusicPlayerHandle handle, float MinDistance);

		[Import(CSFML_AUDIO), CLink]
		static extern void sfMusic_setAttenuation(MusicPlayerHandle handle, float Attenuation);

		[Import(CSFML_AUDIO), CLink]
		static extern void sfMusic_setPlayingOffset(MusicPlayerHandle handle, Time TimeOffset);

		[Import(CSFML_AUDIO), CLink]
		static extern bool sfMusic_getLoop(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern float sfMusic_getPitch(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern float sfMusic_getVolume(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern Vector3f sfMusic_getPosition(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern bool sfMusic_isRelativeToListener(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern float sfMusic_getMinDistance(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern float sfMusic_getAttenuation(MusicPlayerHandle handle);

		[Import(CSFML_AUDIO), CLink]
		static extern Time sfMusic_getPlayingOffset(MusicPlayerHandle handle);
	}
}
