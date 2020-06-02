using System;
using SFML.System;

namespace SFML.Graphics
{
	public enum TextStyle
	{

	}

	public class Text : SFHandle<TextHandle>, IDisposable
	{
		public Transform2D Transform = new .() ~ delete _;
		private String _text;

		public this() : base(sfText_create()) {}
		public this(Text text) : base(sfText_copy(text.[Friend]_handle)) {}
		public this(Font font) : base(sfText_create()) { SetFont(font); }
		public ~this()
		{
			sfText_destroy(_handle);
			delete _text;
		}

		public Color FillColor {
			get { return sfText_getFillColor(_handle); }
			set { sfText_setFillColor(_handle, value); }
		}

		public Color OutlineColor {
			get { return sfText_getOutlineColor(_handle); }
			set { sfText_setOutlineColor(_handle, value); }
		}

		public float OutlineThickness {
			get { return sfText_getOutlineThickness(_handle); }
			set { sfText_setOutlineThickness(_handle, value); }
		}

		public uint32 CharacterSize {
			get { return sfText_getCharacterSize(_handle); }
			set { sfText_setCharacterSize(_handle, value); }
		}

		public TextStyle TextStyle {
			get { return sfText_getStyle(_handle); }
			set { sfText_setStyle(_handle, value); }
		}

		public float LetterSpacing {
			get { return sfText_getLetterSpacing(_handle); }
			set { sfText_setLetterSpacing(_handle, value); }
		}

		public float LineSpacing {
			get { return sfText_getLineSpacing(_handle); }
			set { sfText_setLineSpacing(_handle, value); }
		}

		public FloatRect TextRect => sfText_getRect(_handle);
 		public FloatRect LocalBounds => sfText_getLocalBounds(_handle);

		public Vector2f FindCharacterPosition(uint32 index) => sfText_findCharacterPos(_handle, index);
		

		public void SetText(StringView text)
		{
			if (_text != null)
				delete _text;

			_text = new String(text);
			sfText_setString(_handle, _text);
		}

		public void SetFont(Font font) => sfText_setFont(_handle, font.[Friend]_handle);

		public void SetUnicode(uint32* utf32Str) { sfText_setUnicodeString(_handle, utf32Str); }


		[Import(CSFML_GRAPHICS), CLink]
		static extern TextHandle sfText_create();

		[Import(CSFML_GRAPHICS), CLink]
		static extern TextHandle sfText_copy(TextHandle eext);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfText_destroy(TextHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfText_setFillColor(TextHandle handle, Color Color);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfText_setOutlineColor(TextHandle handle, Color Color);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfText_setOutlineThickness(TextHandle handle, float thickness);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Color sfText_getFillColor(TextHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Color sfText_getOutlineColor(TextHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern float sfText_getOutlineThickness(TextHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern uint32* sfText_setUnicodeString(TextHandle handle, uint32* text);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfText_setFont(TextHandle handle, FontHandle font);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfText_setCharacterSize(TextHandle handle, uint32 size);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfText_setLineSpacing(TextHandle handle, float spacingFactor);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfText_setLetterSpacing(TextHandle handle, float spacingFactor);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfText_setStyle(TextHandle handle, TextStyle style);

		[Import(CSFML_GRAPHICS), CLink]
		static extern char8* sfText_getString(TextHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfText_setString(TextHandle handle, char8* text);

		[Import(CSFML_GRAPHICS), CLink]
		static extern char8* sfText_getUnicodeString(TextHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern uint32 sfText_getCharacterSize(TextHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern float sfText_getLetterSpacing(TextHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern float sfText_getLineSpacing(TextHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern TextStyle sfText_getStyle(TextHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern FloatRect sfText_getRect(TextHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Vector2f sfText_findCharacterPos(TextHandle handle, uint32 index);

		[Import(CSFML_GRAPHICS), CLink]
		static extern FloatRect sfText_getLocalBounds(TextHandle handle);
	}
}
