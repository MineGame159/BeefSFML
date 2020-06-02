using System;
using SFML.System;

namespace SFML.Graphics
{
	public class Font : SFHandle<FontHandle>
	{
		public this(StringView filename) : base(0)
		{
			let copy = scope String(filename);
			FileUtility.ToRelativePath(copy);
			_handle = sfFont_createFromFile(copy);
		}

		public this(Font copyFrom) : base(sfFont_copy(copyFrom._handle)) {}
		public ~this() { sfFont_destroy(_handle); }

		public float GetLineSpacing(uint32 characterSize) => sfFont_getLineSpacing(_handle, characterSize);
		public float GetUnderlinePosition(uint32 characterSize) => sfFont_getUnderlinePosition(_handle, characterSize);
		public float GetUnderlineThickness(uint32 characterSize) => sfFont_getUnderlineThickness(_handle, characterSize);
		public Texture GetTexture(uint32 characterSize) => new [Friend]Texture(sfFont_getTexture(_handle, characterSize));
		public void GetInfo(String info) { info.Append(sfFont_getInfo(_handle)); }


		[Import(CSFML_GRAPHICS), CLink]
		static extern FontHandle sfFont_createFromFile(char8* filename);

		[Import(CSFML_GRAPHICS), CLink]
		static extern FontHandle sfFont_createFromStream(void* stream);

		[Import(CSFML_GRAPHICS), CLink]
		static extern FontHandle sfFont_createFromMemory(void* data, uint64 size);

		[Import(CSFML_GRAPHICS), CLink]
		static extern FontHandle sfFont_copy(FontHandle font);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfFont_destroy(FontHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Glyph sfFont_getGlyph(FontHandle handle, uint32 codePoint, uint32 characterSize, bool bold, float outlineThickness);

		[Import(CSFML_GRAPHICS), CLink]
		static extern float sfFont_getKerning(FontHandle handle, uint32 first, uint32 second, uint32 characterSize);

		[Import(CSFML_GRAPHICS), CLink]
		static extern float sfFont_getLineSpacing(FontHandle handle, uint characterSize);

		[Import(CSFML_GRAPHICS), CLink]
		static extern float sfFont_getUnderlinePosition(FontHandle handle, uint32 characterSize);

		[Import(CSFML_GRAPHICS), CLink]
		static extern float sfFont_getUnderlineThickness(FontHandle handle, uint32 characterSize);

		[Import(CSFML_GRAPHICS), CLink]
		static extern TextureHandle sfFont_getTexture(FontHandle handle, uint32 characterSize);

		[Import(CSFML_GRAPHICS), CLink]
		static extern char8* sfFont_getInfo(FontHandle handle);
	}
}
