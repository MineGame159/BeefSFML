using SFML.System;

namespace SFML.Graphics
{
	public interface IRenderTarget
	{
		Vector2u32 Size { get; }

		void SetView(View toView);

		IntRect GetViewport(View fromView);

		Vector2f FromScreenToWorld(Vector2i coords, View referenceView);
		Vector2i FromWorldToScreen(Vector2f coords, View referenceView);
	}
}
