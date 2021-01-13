using System;
using SFML.System;
using System.IO;

namespace SFML.Graphics
{
	public class Texture : SFHandle<TextureHandle>, IDisposable
	{
		private uint32 _width;
		private uint32 _height;

		public bool Repeated => sfTexture_isRepeated(_handle);
		public bool IsSRGB => sfTexture_isSrgb(_handle);
		public bool IsSmooth => sfTexture_isSmooth(_handle);

		public Vector2u32 Size => sfTexture_getSize(_handle); 

		public this(uint32 width, uint32 height) { sfTexture_create(width, height); }
		public this(String filename) : base(0)
		{
			let copy = scope String(filename);
			FileUtility.ToRelativePath(copy);
			_handle = sfTexture_createFromFile(copy, IntRect(0, 0, 0, 0));
		}

		public this(String filename, IntRect rect) : base(0)
		{
			let copy = scope String(filename);
			FileUtility.ToRelativePath(copy);
			_handle = sfTexture_createFromFile(copy, rect);
		}

		public this(Stream stream) : base(0)
		{
			let adapter = scope SFStreamAdapter(stream);
			_handle = sfTexture_createFromStream(adapter.GetCompatibleStream(), IntRect(0, 0, 0, 0));
		}

		public this(Stream stream, IntRect area) : base(0)
		{
			let adapter = scope SFStreamAdapter(stream);
			_handle = sfTexture_createFromStream(adapter.GetCompatibleStream(), area);
		}

		public this(uint8[] bytes) : base(0)
		{
			_handle = sfTexture_createFromMemory(bytes.CArray(), (uint64)bytes.Count, IntRect(0, 0, 0, 0));
		}

		public this(uint8[] bytes, IntRect rect) : base(0)
		{
			_handle = sfTexture_createFromMemory(bytes.CArray(), (uint64)bytes.Count, rect);
		}

		private this(TextureHandle fromHandle) : base(fromHandle) { };

		public void Update(uint8[] pixels)
		{
			Vector2u32 size = Size;
			sfTexture_updateFromPixels(_handle, pixels.CArray(), size.X, size.Y, 0, 0);
		}

		public static uint32 MaximumSize => sfTexture_getMaximumSize();
		public static void Bind(Texture texture) => sfTexture_bind(texture._handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern TextureHandle sfTexture_create(uint32 width, uint32 height);

		[Import(CSFML_GRAPHICS), CLink]
		static extern TextureHandle sfTexture_createFromFile(char8* filename,  IntRect area);

		[Import(CSFML_GRAPHICS), CLink]
		static extern TextureHandle sfTexture_createFromStream(InputStream stream, IntRect area);

		[Import(CSFML_GRAPHICS), CLink]
		static extern TextureHandle sfTexture_createFromImage(TextureHandle image, IntRect area);

		[Import(CSFML_GRAPHICS), CLink]
		static extern TextureHandle sfTexture_createFromMemory(void* data, uint64 size, IntRect area);

		[Import(CSFML_GRAPHICS), CLink]
		static extern TextureHandle sfTexture_copy(TextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_destroy(TextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Vector2u32 sfTexture_getSize(TextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern TextureHandle sfTexture_copyToImage(TextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_updateFromPixels(TextureHandle handle, uint8* pixels, uint32 width, uint32 height, uint32 x, uint32 y);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_updateFromTexture(TextureHandle handle, TextureHandle texture, uint32 x, uint32 y);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_updateFromImage(TextureHandle handle, TextureHandle image, uint32 x, uint32 y);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_updateFromWindow(TextureHandle handle, TextureHandle window, uint32 x, uint32 y);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_updateFromRenderWindow(TextureHandle handle, WindowHandle windowHandle, uint32 x, uint32 y);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_bind(TextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_setSmooth(TextureHandle handle, bool smooth);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfTexture_isSmooth(TextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_setSrgb(TextureHandle handle, bool sRGB);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfTexture_isSrgb(TextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_setRepeated(TextureHandle handle, bool repeated);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfTexture_isRepeated(TextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfTexture_generateMipmap(TextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfTexture_swap(TextureHandle handle, TextureHandle right);

		[Import(CSFML_GRAPHICS), CLink]
		static extern uint32 sfTexture_getNativeHandle(ShaderHandle shader);

		[Import(CSFML_GRAPHICS), CLink]
		static extern FloatRect sfTexture_getTexCoords(TextureHandle handle, IntRect rectangle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern uint32 sfTexture_getMaximumSize();
	}
}
