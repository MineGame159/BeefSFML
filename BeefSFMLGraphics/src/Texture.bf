using System;
using SFML.System;

namespace SFML.Graphics
{
	public class Texture : NativeHandle
	{
		private uint32 _width;
		private uint32 _height;

		public this(uint32 width, uint32 height) : base(sfTexture_create(width, height)) {}
		public this(char8* filename) : base(sfTexture_createFromFile(filename, ref IntRect(0, 0, 0, 0))) {}
		public this(char8* filename, ref IntRect rect) : base(sfTexture_createFromFile(filename, ref rect)) {}

		public void Update(uint8[] pixels)
		{
			Vector2u32 size = GetSize();
			sfTexture_updateFromPixels(_handle, pixels.CArray(), size.X, size.Y, 0, 0);
		}

		public Vector2u32 GetSize() => sfTexture_getSize(_handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void* sfTexture_create(uint32 width, uint32 height);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void* sfTexture_createFromFile(char8* filename, ref IntRect area);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void* sfTexture_createFromStream(void* stream, ref IntRect area);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void* sfTexture_createFromImage(void* image, ref IntRect area);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void* sfTexture_createFromMemory(void* data, uint64 size, ref IntRect area);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void* sfTexture_copy(void* texture);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_destroy(void* texture);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Vector2u32 sfTexture_getSize(void* texture);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void* sfTexture_copyToImage(void* texture);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_updateFromPixels(void* handle, uint8* pixels, uint32 width, uint32 height, uint32 x, uint32 y);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_updateFromTexture(void* handle, void* texture, uint32 x, uint32 y);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_updateFromImage(void* texture, void* image, uint32 x, uint32 y);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_updateFromWindow(void* texture, void* window, uint32 x, uint32 y);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_updateFromRenderWindow(void* texture, void* renderWindow, uint32 x, uint32 y);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_bind(void* texture);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_setSmooth(void* texture, bool smooth);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfTexture_isSmooth(void* texture);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_setSrgb(void* texture, bool sRGB);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfTexture_isSrgb(void* texture);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_setRepeated(void* texture, bool repeated);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfTexture_isRepeated(void* texture);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfTexture_generateMipmap(void* texture);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_swap(void* handle, void* right);

		[Import(CSFML_GRAPHICS), CLink]
		static extern uint32 sfTexture_getNativeHandle(void* shader);

		[Import(CSFML_GRAPHICS), CLink]
		static extern FloatRect sfTexture_getTexCoords(void* texture, IntRect rectangle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern uint32 sfTexture_getMaximumSize();
	}
}
