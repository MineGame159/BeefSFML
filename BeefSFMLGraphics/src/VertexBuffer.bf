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

	public class VertexBuffer : SFHandle<VertexBufferHandle>, IDisposable
	{
		public this(uint32 vertexCount, PrimitiveType primitiveType, BufferUsageType usageType) : base(sfVertexBuffer_create(vertexCount, primitiveType, usageType)) {}
		public this(VertexBuffer from) : base(sfVertexBuffer_copy(from.[Friend]_handle)) {}
		public ~this() { sfVertexBuffer_destroy(_handle); }

		public uint32 VertexCount => sfVertexBuffer_getVertexCount(_handle);

		public PrimitiveType PrimitiveType
		{
			get { return sfVertexBuffer_getPrimitiveType(_handle); }
			set { sfVertexBuffer_setPrimitiveType(_handle, value); }
		}

		public BufferUsageType Usage
		{
			get { return sfVertexBuffer_getUsage(_handle); }
			set { sfVertexBuffer_setUsage(_handle, value); }
		}

		public void Swap(VertexBuffer with) => sfVertexBuffer_swap(_handle, with.[Friend]_handle);
		public bool Update(Vertex[] vertices, uint32 offset) => sfVertexBuffer_update(_handle, vertices.CArray(), (uint32)vertices.Count, offset) == 1 ? true : false;
		public bool Update(VertexBuffer source) => sfVertexBuffer_updateFromVertexBuffer(_handle, source._handle) == 1 ? true : false;
		public uint32 GetNativeHandle() => sfVertexBuffer_getNativeHandle(_handle);
		public void Bind() => sfVertexBuffer_bind(_handle);

		public static bool IsAvailable() => sfVertexBuffer_isAvailable() == 1 ? true : false;

		[Import(CSFML_GRAPHICS), CLink]
		private static extern VertexBufferHandle sfVertexBuffer_create(uint32 vertexCount, PrimitiveType type, BufferUsageType usageType);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern VertexBufferHandle sfVertexBuffer_copy(VertexBufferHandle bufferToCopy);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfVertexBuffer_destroy(VertexBufferHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern uint32 sfVertexBuffer_getVertexCount(VertexBufferHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern int sfVertexBuffer_update(VertexBufferHandle handle, Vertex* vertices, uint32 vertexCount, uint32 offset);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern int sfVertexBuffer_updateFromVertexBuffer(VertexBufferHandle target, VertexBufferHandle source);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfVertexBuffer_swap(VertexBufferHandle target, VertexBufferHandle source);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern uint32 sfVertexBuffer_getNativeHandle(VertexBufferHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfVertexBuffer_setPrimitiveType(VertexBufferHandle handle, PrimitiveType primitiveType);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern PrimitiveType sfVertexBuffer_getPrimitiveType(VertexBufferHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfVertexBuffer_setUsage(VertexBufferHandle handle, BufferUsageType usageType);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern BufferUsageType sfVertexBuffer_getUsage(VertexBufferHandle handle);
		
		[Import(CSFML_GRAPHICS), CLink]
		private static extern void sfVertexBuffer_bind(VertexBufferHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		private static extern int sfVertexBuffer_isAvailable();
	}
}
