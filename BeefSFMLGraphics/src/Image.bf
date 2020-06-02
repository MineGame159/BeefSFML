using System;
using SFML.System;

namespace SFML.Graphics
{
	public class Image : SFHandle<ImageHandle>
	{
		public this(uint32 width, uint32 height, Color color) : base(sfImage_createFromColor(width, height, color)) {}
		public this(uint32 width, uint32 height, uint8[] pixels) : base(sfImage_createFromPixels(width, height, pixels.CArray())) {}
		public this(Image copyFrom) : base(sfImage_copy(copyFrom._handle)) {} 
		public this(StringView filename) : base(0)
		{
			let copy = scope String(filename);
			FileUtility.ToRelativePath(copy);
			_handle = sfImage_createFromFile(copy);
		}

		public ~this() { sfImage_destroy(_handle); }

		public bool SaveToFile(StringView filename)
		{
			let copy = scope String(filename);
			FileUtility.ToRelativePath(copy);
			return sfImage_saveToFile(_handle, copy);
		}

		public void CreateMaskFromColor(Color color, uint8 alpha) => sfImage_createMaskFromColor(_handle, color, alpha);
		public void CopyImage(Image source, uint32 destinationX, uint32 destinationY, IntRect sourceRect, bool ignoreAlpha = true)
			=> sfImage_copyImage(_handle, source.[Friend]_handle, destinationX, destinationY, sourceRect, !ignoreAlpha);

		public void SetPixel(uint32 x, uint32 y, Color color) => sfImage_setPixel(_handle, x, y, color);
		public Color GetPixel(uint32 x, uint32 y) => sfImage_getPixel(_handle, x, y);
		public Vector2u32 Size => sfImage_getSize(_handle);

		public void FlipHorizontally() => sfImage_flipHorizontally(_handle);
		public void FlipVertically() => sfImage_flipVertically(_handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern ImageHandle sfImage_createFromColor(uint32 width, uint32 height, Color color);

		[Import(CSFML_GRAPHICS), CLink]
		static extern ImageHandle sfImage_createFromPixels(uint32 width, uint32 height, uint8* pixels);

		[Import(CSFML_GRAPHICS), CLink]
		static extern ImageHandle sfImage_createFromFile(char8* filename);

		[Import(CSFML_GRAPHICS), CLink]
		static extern ImageHandle sfImage_createFromStream(void* stream);

		[Import(CSFML_GRAPHICS), CLink]
		static extern ImageHandle sfImage_createFromMemory(void* data, uint64 size);

		[Import(CSFML_GRAPHICS), CLink]
		static extern ImageHandle sfImage_copy(ImageHandle Image);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfImage_destroy(ImageHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfImage_saveToFile(ImageHandle handle, char8* filename);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfImage_createMaskFromColor(ImageHandle handle, Color color, uint8 alpha);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfImage_copyImage(ImageHandle handle, ImageHandle source, uint32 destinationX, uint32 destinationY, IntRect sourceRect, bool applyAlpha);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfImage_setPixel(ImageHandle handle, uint32 x, uint32 y, Color color);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Color sfImage_getPixel(ImageHandle handle, uint32 x, uint32 y);

		[Import(CSFML_GRAPHICS), CLink]
		static extern ImageHandle sfImage_getPixelsPtr(ImageHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Vector2u32 sfImage_getSize(ImageHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfImage_flipHorizontally(ImageHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfImage_flipVertically(ImageHandle handle);
	}
}
