using System;
using SFML.System;

namespace SFML.Graphics
{
	public class Sprite : SFHandle<SpriteHandle>
	{
		private Transform2D _transform = new .() ~ delete  _;
		private Texture _texture;

		public Transform2D Transform => _transform;

		public this() : base(sfSprite_create()) {}
		public this(Sprite copy) : base(sfSprite_copy(copy._handle)) {}
		public this(Texture texture) : this()
		{
			_texture = texture;
			sfSprite_setTexture(_handle, texture.[Friend]_handle, true);
		}
		public this(Texture texture, IntRect rect) : this(texture)
		{
			sfSprite_setTextureRect(_handle, rect);
		}

		public ~this() { sfSprite_destroy(_handle); }

		public Color Color
		{
			get { return sfSprite_getColor(_handle); }
			set { sfSprite_setColor(_handle, value); }
		}

		public void SetTexture(Texture texture, bool adjustToNewSize = false)
		{
			_texture = texture;
			sfSprite_setTexture(_handle, texture.[Friend]_handle, adjustToNewSize);
		}

		[Import(CSFML_GRAPHICS), CLink]
		static extern SpriteHandle sfSprite_create();

		[Import(CSFML_GRAPHICS), CLink]
		static extern SpriteHandle sfSprite_copy(SpriteHandle sprite);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfSprite_destroy(SpriteHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfSprite_setColor(SpriteHandle handle, Color color);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Color sfSprite_getColor(SpriteHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfSprite_setTexture(SpriteHandle handle, TextureHandle texture, bool adjustToNewSize);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfSprite_setTextureRect(SpriteHandle handle, IntRect rect);

		[Import(CSFML_GRAPHICS), CLink]
		static extern IntRect sfSprite_getTextureRect(SpriteHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern FloatRect sfSprite_getLocalBounds(SpriteHandle handle);
	}
}
