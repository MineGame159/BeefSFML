using System;
using SFML.System;
using SFML.Window;

namespace SFML.Graphics
{
	class RenderTexture	: SFHandle<RenderTextureHandle>, IRenderTarget 
	{
		private View _defaultView = null;
		private View _view = null;
		private Texture _backingTexture;

		public View DefaultView => _defaultView;
		public View CurrentView {
			get { return _view; }
			set {
				sfRenderTexture_setView(_handle, value.[Friend]_handle);
				_view = value;
			}
		}

		public this(uint32 width, uint32 height, ref ContextSettings settings) : base(sfRenderTexture_createWithSettings(width, height, ref settings)) { Init(); }
		public ~this()
		{
			delete _defaultView;
			delete _backingTexture;
			sfRenderTexture_destroy(_handle);
		}

		public bool RestoreGLStates() => sfRenderTexture_restoreGLStates(_handle);
		public void ResetGLStates() => sfRenderTexture_resetGLStates(_handle);
		public void PushGLStates() => sfRenderTexture_pushGLStates(_handle); 
		public void PopGLStates() => sfRenderTexture_popGLStates(_handle);

		[Obsolete("DrawVertexBuffer() is deprecated, use overloaded RenderTexture.Draw() instead", false)]
		public void DrawVertexBuffer(VertexBuffer buffer, RenderStates states) { sfRenderTexture_drawVertexBuffer(_handle, buffer.[Friend]_handle, states); }
		[Obsolete("DrawVertexArray() is deprecated, use overloaded RenderTexture.Draw() instead", false)]
		public void DrawVertexArray(VertexArray array, RenderStates states) { sfRenderTexture_drawVertexArray(_handle, array.[Friend]_handle, states); }
		[Obsolete("DrawPrimitive() is deprecated, use overloaded RenderTexture.Draw() instead", false)]
		public void DrawPrimitive(PrimitiveType type, Vertex[] vertices, RenderStates states) { sfRenderTexture_drawPrimitives(_handle, vertices.CArray(), (uint32)vertices.Count, type, states); }
		[Obsolete("DrawSprite() is deprecated, use overloaded RenderTexture.Draw() instead", false)]
		public void DrawSprite(Sprite sprite, RenderStates states) { sfRenderTexture_drawSprite(_handle, sprite.[Friend]_handle, states); }
		[Obsolete("DrawShape() is deprecated, use overloaded RenderTexture.Draw() instead", false)]
		public void DrawShape(Shape shape, RenderStates states) { sfRenderTexture_drawShape(_handle, shape.[Friend]_handle, states); }
		[Obsolete("DrawText() is deprecated, use overloaded RenderTexture.Draw() instead", false)]
		public void DrawText(Text text, RenderStates states) { sfRenderTexture_drawText(_handle, text.[Friend]_handle, states); }

		public void Draw(VertexBuffer buffer, RenderStates states) => sfRenderTexture_drawVertexBuffer(_handle, buffer.[Friend]_handle, states);
		public void Draw(VertexArray array, RenderStates states) => sfRenderTexture_drawVertexArray(_handle, array.[Friend]_handle, states);
		public void Draw(PrimitiveType type, Vertex[] vertices, RenderStates states) => sfRenderTexture_drawPrimitives(_handle, vertices.CArray(), (.)vertices.Count, type, states);
		public void Draw(Sprite sprite, RenderStates states) => sfRenderTexture_drawSprite(_handle, sprite.[Friend]_handle, states);
		public void Draw(Shape shape, RenderStates states) => sfRenderTexture_drawShape(_handle, shape.[Friend]_handle, states);
		public void Draw(Text text, RenderStates states) => sfRenderTexture_drawText(_handle, text.[Friend]_handle, states);
		public void Draw(IDrawable drawable, RenderStates states) => drawable.Draw(this, states);
		public void Draw(IDrawable drawable) => drawable.Draw(this, RenderStates(.Alpha, null, null, .Identity));

		public void Clear(Color color) => sfRenderTexture_clear(_handle, color);

		public bool GenerateMipap() => sfRenderTexture_generateMipmap(_handle);

		public static uint32 MaximumAntialiasingLevel => sfRenderTexture_getMaximumAntialiasingLevel();

		public Texture GetTexture() {
			if (_backingTexture == null)
				_backingTexture = new [Friend]Texture(sfRenderTexture_getTexture(_handle));

			return _backingTexture;
		}

		public Vector2f FromScreenToWorld(Vector2i coords, View referenceView = null)
		{
			let viewHandle = referenceView == null ? _view.[Friend]_handle : referenceView.[Friend]_handle;
			return sfRenderTexture_mapPixelToCoords(_handle, coords, viewHandle);
		} 
		public Vector2i FromWorldToScreen(Vector2f coords, View referenceView = null)
		{
			let viewHandle = referenceView == null ? _view.[Friend]_handle : referenceView.[Friend]_handle;
			return sfRenderTexture_mapCoordsToPixel(_handle, coords, viewHandle);
		}

		public IntRect CurrentViewport => sfRenderTexture_getViewport(_handle, _view == null ? _defaultView.[Friend]_handle : _view.[Friend]_handle);

		private void Init() {
			_defaultView = new [Friend].(sfRenderTexture_getDefaultView(_handle), true);
			_view = _defaultView;
		}

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderTexture_drawText(RenderTextureHandle handle, TextHandle text, RenderStates states);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderTexture_drawShape(RenderTextureHandle handle, ShapeHandle shape, RenderStates states);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderTexture_drawVertexArray(RenderTextureHandle handle, VertexArrayHandle vertices, RenderStates states);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderTexture_drawSprite(RenderTextureHandle handle, SpriteHandle sprite, RenderStates states);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfRenderTexture_drawVertexBuffer(RenderTextureHandle handle, VertexBufferHandle buffer, RenderStates states);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern RenderTextureHandle sfRenderTexture_createWithSettings(uint32 width, uint32 height, ref ContextSettings Settings);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderTexture_destroy(RenderTextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderTexture_clear(RenderTextureHandle handle, Color ClearColor);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Vector2u32 sfRenderTexture_getSize(RenderTextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfRenderTexture_setActive(RenderTextureHandle handle, bool Active);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfRenderTexture_saveGLStates(RenderTextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfRenderTexture_restoreGLStates(RenderTextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfRenderTexture_display(RenderTextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderTexture_setView(RenderTextureHandle handle, ViewHandle view);

		[Import(CSFML_GRAPHICS), CLink]
		static extern RenderTextureHandle sfRenderTexture_getView(RenderTextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern ViewHandle sfRenderTexture_getDefaultView(RenderTextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern IntRect sfRenderTexture_getViewport(RenderTextureHandle handle, ViewHandle targetView);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Vector2i sfRenderTexture_mapCoordsToPixel(RenderTextureHandle handle, Vector2f point, ViewHandle view);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Vector2f sfRenderTexture_mapPixelToCoords(RenderTextureHandle handle, Vector2i point, ViewHandle view);

		[Import(CSFML_GRAPHICS), CLink]
		static extern TextureHandle sfRenderTexture_getTexture(RenderTextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern uint32 sfRenderTexture_getMaximumAntialiasingLevel();

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderTexture_setSmooth(RenderTextureHandle handle, bool smooth);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfRenderTexture_isSmooth(RenderTextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderTexture_setRepeated(RenderTextureHandle handle, bool repeated);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfRenderTexture_isRepeated(RenderTextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfRenderTexture_generateMipmap(RenderTextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderTexture_drawPrimitives(RenderTextureHandle handle, Vertex* vertexPtr, uint vertexCount, PrimitiveType type, RenderStates states);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderTexture_pushGLStates(RenderTextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderTexture_popGLStates(RenderTextureHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderTexture_resetGLStates(RenderTextureHandle handle);
	}
}
