using System;
using SFML.System;

namespace SFML.Graphics
{
	public class VertexArray : SFHandle<VertexArrayHandle>, IDisposable
	{
		public this() : base(sfVertexArray_create()) {}
		public this(VertexArray fromArray) : base(sfVertexArray_copy(fromArray.[Friend]_handle)) {}
		public ~this() { sfVertexArray_destroy(_handle); }

		public void Resize(uint32 vertexCount) => sfVertexArray_resize(_handle, vertexCount);
		public void Clear() => sfVertexArray_clear(_handle);
		public void AppendVertex(Vertex vertex) => sfVertexArray_append(_handle, vertex);

		public Vertex* GetVertex(uint32 index) => sfVertexArray_getVertex(_handle, index);
		public uint32 VertexCount => sfVertexArray_getVertexCount(_handle);

		public FloatRect Bounds => sfVertexArray_getBounds(_handle);
		public PrimitiveType PrimitiveType
		{
			get { return sfVertexArray_getPrimitiveType(_handle); }
			set { sfVertexArray_setPrimitiveType(_handle, value); }
		}

		[Import(CSFML_GRAPHICS), CLink]
		static extern VertexArrayHandle sfVertexArray_create();

		[Import(CSFML_GRAPHICS), CLink]
		static extern VertexArrayHandle sfVertexArray_copy(VertexArrayHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfVertexArray_destroy(VertexArrayHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern uint32 sfVertexArray_getVertexCount(VertexArrayHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern Vertex* sfVertexArray_getVertex(VertexArrayHandle handle, uint32 index);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfVertexArray_clear(VertexArrayHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfVertexArray_resize(VertexArrayHandle handle, uint32 vertexCount);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfVertexArray_append(VertexArrayHandle handle, Vertex vertex);

		[Import(CSFML_GRAPHICS), CLink]
		static extern void sfVertexArray_setPrimitiveType(VertexArrayHandle handle, PrimitiveType type);

		[Import(CSFML_GRAPHICS), CLink]
		static extern PrimitiveType sfVertexArray_getPrimitiveType(VertexArrayHandle handle);

		[Import(CSFML_GRAPHICS), CLink]
		static extern FloatRect sfVertexArray_getBounds(VertexArrayHandle handle);
	}
}
