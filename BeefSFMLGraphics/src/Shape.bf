using System;
using SFML.System;
using System.Collections;
using System.Threading;

namespace SFML.Graphics
{
	function uint32 GetPointCountFunc(void* data);
	function Vector2f GetPointFunc(uint32 index, void* data);

	delegate uint32 GetPointCountCallback();
	delegate Vector2f GetPointCallback(uint32 index);

	public abstract class Shape : SFHandle<ShapeHandle>, IDisposable
	{
		private static GetPointCountCallback _getPointCountCallback;
		private static GetPointCallback _getPointCallback;

		//private static uint32 GetPointCountInternal(Shape data) => _getPointCountCallback();
		//private static Vector2f GetPointInternal(uint32 index, Shape data) => _getPointCallback(index);

		private static uint32 GetPointCountInternal(void* data) => ((Shape)Internal.UnsafeCastToObject(data)).GetPointCount(); //data.GetPointCount();
		private static Vector2f GetPointInternal(uint32 index, void* data) => ((Shape)Internal.UnsafeCastToObject(data)).GetPoint(index); //data.GetPoint(index);

		private GetPointCountCallback _getPointCountLocal;
		private GetPointCallback _getPointLocal;

		protected Transform2D _transform = new .() ~ delete _;
		protected Texture _texture;

		public this() : base(0)
		{
			_getPointCountLocal = new => GetPointCount;
			_getPointLocal 		= new => GetPoint;

			//UpdateCallbacks();
			_handle = sfShape_create(=> GetPointCountInternal, => GetPointInternal, Internal.UnsafeCastToPtr(this));
		}

		public this(Shape shape) : base(sfShape_copy(shape.[Friend]_handle)) {}
		public ~this()
		{
			sfShape_destroy(_handle);

			delete _getPointCountLocal;
			delete _getPointLocal;
		}

		public Texture Texture => _texture;
		public Transform2D Transform => _transform;

		protected void UpdateCallbacks()
		{
			_getPointCountCallback 	= _getPointCountLocal;
			_getPointCallback 		= _getPointLocal;
		}

		public IntRect TextureRect {
			get { return sfShape_getTextureRect(_handle); }
			set { sfShape_setTextureRect(_handle, value); }
		}

		public Color FillColor {
			get { return sfShape_getFillColor(_handle); }
			set { sfShape_setFillColor(_handle, value); }
		}

		public Color OutlineColor {
			get { return sfShape_getOutlineColor(_handle); }
			set { sfShape_setOutlineColor(_handle, value); }
		}

		public float OutlineThickness {
			get { return sfShape_getOutlineThickness(_handle); }
			set { sfShape_setOutlineThickness(_handle, value); }
		}

		public FloatRect LocalBounds => sfShape_getLocalBounds(_handle);

		protected abstract uint32 GetPointCount();
		protected abstract Vector2f GetPoint(uint32 index);

		protected void Update()
		{
			//UpdateCallbacks();
			sfShape_update(_handle);
		}

		[Import(CSFML_GRAPHICS), CLink]
		static extern ShapeHandle sfShape_create(GetPointCountFunc getPointCount, GetPointFunc getPoint, void* data);

		[Import(CSFML_GRAPHICS), CLink]
		static extern ShapeHandle sfShape_copy(ShapeHandle shape);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfShape_destroy(ShapeHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfShape_setTexture(ShapeHandle handle, TextureHandle texture, bool adjustToNewSize);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfShape_setTextureRect(ShapeHandle handle, IntRect rect);

		[Import(CSFML_GRAPHICS), CLink]
		static extern IntRect sfShape_getTextureRect(ShapeHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfShape_setFillColor(ShapeHandle handle, Color color);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Color sfShape_getFillColor(ShapeHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfShape_setOutlineColor(ShapeHandle handle, Color color);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Color sfShape_getOutlineColor(ShapeHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfShape_setOutlineThickness(ShapeHandle handle, float thickness);

		[Import(CSFML_GRAPHICS), CLink]
		static extern float sfShape_getOutlineThickness(ShapeHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern FloatRect sfShape_getLocalBounds(ShapeHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfShape_update(ShapeHandle handle);
	}
}
