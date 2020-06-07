using System;
using SFML.System;

namespace SFML.Network
{
	public enum HttpMethod
	{
		Get,   ///< Request in get mode, standard method to retrieve a page
		Post,  ///< Request in post mode, usually to send data to a page
		Head,  ///< Request a page's header only
		Put,   ///< Request in put mode, useful for a REST API
		Delete ///< Request in delete mode, useful for a REST API
	}

	public enum HttpStatus
	{
		// 2xx: success
		Ok             = 200, ///< Most common code returned when operation was successful
		Created        = 201, ///< The resource has successfully been created
		Accepted       = 202, ///< The request has been accepted, but will be processed later by the server
		NoContent      = 204, ///< Sent when the server didn't send any data in return
		ResetContent   = 205, ///< The server informs the client that it should clear the view (form) that caused the request to be sent
		PartialContent = 206, ///< The server has sent a part of the resource, as a response to a partial GET request

		// 3xx: redirection
		MultipleChoices  = 300, ///< The requested page can be accessed from several locations
		MovedPermanently = 301, ///< The requested page has permanently moved to a new location
		MovedTemporarily = 302, ///< The requested page has temporarily moved to a new location
		NotModified      = 304, ///< For conditional requests, means the requested page hasn't changed and doesn't need to be refreshed

		// 4xx: client error
		BadRequest          = 400, ///< The server couldn't understand the request (syntax error)
		Unauthorized        = 401, ///< The requested page needs an authentication to be accessed
		Forbidden           = 403, ///< The requested page cannot be accessed at all, even with authentication
		NotFound            = 404, ///< The requested page doesn't exist
		RangeNotSatisfiable = 407, ///< The server can't satisfy the partial GET request (with a "Range" header field)

		// 5xx: server error
		InternalServerError = 500, ///< The server encountered an unexpected error
		NotImplemented      = 501, ///< The server doesn't implement a requested feature
		BadGateway          = 502, ///< The gateway server has received an error from the source server
		ServiceNotAvailable = 503, ///< The server is temporarily unavailable (overloaded, in maintenance, ...)
		GatewayTimeout      = 504, ///< The gateway server couldn't receive a response from the source server
		VersionNotSupported = 505, ///< The server doesn't support the requested HTTP version

		// 10xx: SFML custom codes
		InvalidResponse  = 1000, ///< Response is not a valid HTTP one
		ConnectionFailed = 1001  ///< Connection with server failed
	}

	public class Http : SFHandle<HttpHandle>
	{
		public this() : base(sfHttp_create()) {}
		public ~this() { sfHttp_destroy(_handle); }

		public void SetHost(String host, uint16 port) => sfHttp_setHost(_handle, host.CStr(), port);
		public void SetHost(StringView host, uint16 port) => sfHttp_setHost(_handle, host.ToScopeCStr!(), port);

		public HttpResponse SendRequest(HttpRequest request, Time timeout) => new HttpResponse(sfHttp_sendRequest(_handle, request.[Friend]_handle, timeout));

		// Native functions
		
		[Import(CSFML_NETWORK), CLink]
		private static extern HttpHandle sfHttp_create();
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfHttp_destroy(HttpHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfHttp_setHost(HttpHandle handle, char8* host, uint16 port);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern HttpResponseHandle sfHttp_sendRequest(HttpHandle handle, HttpRequestHandle request, Time timeout);
	}

	public class HttpRequest : SFHandle<HttpRequestHandle>
	{
		public this() : base(sfHttpRequest_create()) {}
		public ~this() { sfHttpRequest_destroy(_handle); }

		public void SetField(String field, String value) => sfHttpRequest_setField(_handle, field.CStr(), value.CStr());
		public void SetField(StringView field, StringView value) => sfHttpRequest_setField(_handle, field.ToScopeCStr!(), value.ToScopeCStr!());

		public void SetMethod(HttpMethod method) => sfHttpRequest_setMethod(_handle, method);

		public void SetUri(String uri) => sfHttpRequest_setUri(_handle, uri.CStr());
		public void SetUri(StringView uri) => sfHttpRequest_setUri(_handle, uri.ToScopeCStr!());

		public void SetHttpVersion(uint major, uint minor) => sfHttpRequest_setHttpVersion(_handle, major, minor);

		public void SetBody(String body) => sfHttpRequest_setBody(_handle, body.CStr());
		public void SetBody(StringView body) => sfHttpRequest_setBody(_handle, body.ToScopeCStr!());

		// Native functions

		[Import(CSFML_NETWORK), CLink]
		private static extern HttpRequestHandle sfHttpRequest_create();
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfHttpRequest_destroy(HttpRequestHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfHttpRequest_setField(HttpRequestHandle handle, char8* field, char8* value);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfHttpRequest_setMethod(HttpRequestHandle handle, HttpMethod method);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfHttpRequest_setUri(HttpRequestHandle handle, char8* uri);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfHttpRequest_setHttpVersion(HttpRequestHandle handle, uint major, uint minor);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfHttpRequest_setBody(HttpRequestHandle handle, char8* body);
	}

	public class HttpResponse : SFHandle<HttpResponseHandle>
	{
		public this(HttpResponseHandle handle) : base(handle) {}
		public ~this() { sfHttpResponse_destroy(_handle); }

		public void GetField(String field, String buffer) => buffer.Append(sfHttpResponse_getField(_handle, field.CStr()));
		public void GetField(StringView field, String buffer) => buffer.Append(sfHttpResponse_getField(_handle, field.ToScopeCStr!()));

		public HttpStatus GetStatus() => sfHttpResponse_getStatus(_handle);

		public uint GetMajorVersion() => sfHttpResponse_getMajorVersion(_handle);
		public uint GetMinorVersion() => sfHttpResponse_getMinorVersion(_handle);

		public void GetBody(String buffer) => buffer.Append(sfHttpResponse_getBody(_handle));

		// Native functions
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfHttpResponse_destroy(HttpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern char8* sfHttpResponse_getField(HttpResponseHandle handle, char8* field);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern HttpStatus sfHttpResponse_getStatus(HttpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern uint sfHttpResponse_getMajorVersion(HttpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern uint sfHttpResponse_getMinorVersion(HttpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern char8* sfHttpResponse_getBody(HttpResponseHandle handle);
	}
}
