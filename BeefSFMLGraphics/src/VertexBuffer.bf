using System;
using SFML.System;

namespace SFML.Graphics
{

	public enum BufferUsageType
	{
		Stream,
		Dynamic,
		Static
	}

	public class VertexBuffer : NativeHandle
	{
		public this(uint32 vertexCount, PrimitiveType primitiveType, BufferUsageType usageType) : base(sfVertexBuffer_create(vertexCount, primitiveType, usageType)) {}
		public ~this() { sfVertexBuffer_destroy(_handle); }

		public void Swap(VertexBuffer with) => sfVertexBuffer_swap(_handle, with.[Friend]_handle);
		public bool Update(Vertex[] vertices, uint32 offset) => sfVertexBuffer_update(_handle, vertices.CArray(), (uint32)vertices.Count, offset);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void* sfVertexBuffer_create(uint32 vertexCount, PrimitiveType type, BufferUsageType usageType);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void* sfVertexBuffer_copy(void* bufferToCopy);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfVertexBuffer_destroy(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern uint sfVertexBuffer_getVertexCount(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfVertexBuffer_update(void* handle, Vertex* vertices, uint32 vertexCount, uint32 offset);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfVertexBuffer_updateFromVertexBuffer(void* target, void* source);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfVertexBuffer_swap(void* target, void* source);

		[Import(CSFML_GRAPHICS), CLink]
		static extern uint32 sfVertexBuffer_getNativeHandle(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfVertexBuffer_setPrimitiveType(void* handle, PrimitiveType primitiveType);

		[Import(CSFML_GRAPHICS), CLink]
		static extern PrimitiveType sfVertexBuffer_getPrimitiveType(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfVertexBuffer_setUsage(void* handle, BufferUsageType usageType);

		[Import(CSFML_GRAPHICS), CLink]
		static extern BufferUsageType sfVertexBuffer_getUsage(void* handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern bool sfVertexBuffer_isAvailable();

		/*Move to RenderTexture*/
		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfRenderTexture_drawVertexBuffer(void* handle, void* buffer, ref RenderStates states);
	}
}
