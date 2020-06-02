using SFML.System;

namespace SFML.Graphics
{
	public interface IRenderTarget
	{
		View DefaultView { get; }
		View CurrentView { get; set; };

		void DrawVertexBuffer(VertexBuffer buffer, RenderStates states);
		void DrawVertexArray(VertexArray array, RenderStates states);
		void DrawPrimitive(PrimitiveType type, Vertex[] vertices, RenderStates states);
		void DrawSprite(Sprite sprite, RenderStates states);
		void DrawShape(Shape shape, RenderStates states);
		void DrawText(Text text, RenderStates states);

		bool RestoreGLStates();
		void ResetGLStates();
		void PushGLStates(); 
		void PopGLStates();

		void Clear(Color color);

		IntRect CurrentViewport { get; } 
	}
}
