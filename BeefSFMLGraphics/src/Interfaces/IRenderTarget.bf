using SFML.System;
using System;

namespace SFML.Graphics
{
	public interface IRenderTarget
	{
		View DefaultView { get; }
		View CurrentView { get; set; };

		[Obsolete("DrawVertexBuffer() is deprecated, use overloaded IRenderTarget.Draw() instead", false)]
		public void DrawVertexBuffer(VertexBuffer buffer, RenderStates states);
		[Obsolete("DrawVertexArray() is deprecated, use overloaded IRenderTarget.Draw() instead", false)]
		public void DrawVertexArray(VertexArray array, RenderStates states);
		[Obsolete("DrawPrimitive() is deprecated, use overloaded IRenderTarget.Draw() instead", false)]
		public void DrawPrimitive(PrimitiveType type, Vertex[] vertices, RenderStates states);
		[Obsolete("DrawSprite() is deprecated, use overloaded IRenderTarget.Draw() instead", false)]
		public void DrawSprite(Sprite sprite, RenderStates states);
		[Obsolete("DrawShape() is deprecated, use overloaded IRenderTarget.Draw() instead", false)]
		public void DrawShape(Shape shape, RenderStates states);
		[Obsolete("DrawText() is deprecated, use overloaded IRenderTarget.Draw() instead", false)]
		public void DrawText(Text text, RenderStates states);

		public void Draw(VertexBuffer buffer, RenderStates states);
		public void Draw(VertexArray array, RenderStates states);
		public void Draw(PrimitiveType type, Vertex[] vertices, RenderStates states);
		public void Draw(Sprite sprite, RenderStates states);
		public void Draw(Shape shape, RenderStates states);
		public void Draw(Text text, RenderStates states);
		public void Draw(IDrawable drawable, RenderStates states);
		public void Draw(IDrawable drawable);

		bool RestoreGLStates();
		void ResetGLStates();
		void PushGLStates(); 
		void PopGLStates();

		public Vector2f MapPixelToCoords(Vector2i coords, View referenceView = null);
		public Vector2i MapCoordsToPixel(Vector2f coords, View referenceView = null);

		void Clear(Color color);

		IntRect CurrentViewport { get; } 
	}
}
