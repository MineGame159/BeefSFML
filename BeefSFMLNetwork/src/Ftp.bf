using System;
using SFML.System;

namespace SFML.Network
{
	public enum FtpTransferMode
	{
		Binary, ///< Binary mode (file is transfered as a sequence of bytes)
		Ascii,  ///< Text mode using ASCII encoding
		Ebcdic  ///< Text mode using EBCDIC encoding
	}

	public enum FtpStatus
	{
		// 1xx: the requested action is being initiated,
		// expect another reply before proceeding with a new command
		RestartMarkerReply          = 110, ///< Restart marker reply
		ServiceReadySoon            = 120, ///< Service ready in N minutes
		DataConnectionAlreadyOpened = 125, ///< Data connection already opened, transfer starting
		OpeningDataConnection       = 150, ///< File status ok, about to open data connection

		// 2xx: the requested action has been successfully completed
		Ok                    = 200, ///< Command ok
		PointlessCommand      = 202, ///< Command not implemented
		SystemStatus          = 211, ///< System status, or system help reply
		DirectoryStatus       = 212, ///< Directory status
		FileStatus            = 213, ///< File status
		HelpMessage           = 214, ///< Help message
		SystemType            = 215, ///< NAME system type, where NAME is an official system name from the list in the Assigned Numbers document
		ServiceReady          = 220, ///< Service ready for new user
		ClosingConnection     = 221, ///< Service closing control connection
		DataConnectionOpened  = 225, ///< Data connection open, no transfer in progress
		ClosingDataConnection = 226, ///< Closing data connection, requested file action successful
		EnteringPassiveMode   = 227, ///< Entering passive mode
		LoggedIn              = 230, ///< User logged in, proceed. Logged out if appropriate
		FileActionOk          = 250, ///< Requested file action ok
		DirectoryOk           = 257, ///< PATHNAME created

		// 3xx: the command has been accepted, but the requested action
		// is dormant, pending receipt of further information
		NeedPassword       = 331, ///< User name ok, need password
		NeedAccountToLogIn = 332, ///< Need account for login
		NeedInformation    = 350, ///< Requested file action pending further information

		// 4xx: the command was not accepted and the requested action did not take place,
		// but the error condition is temporary and the action may be requested again
		ServiceUnavailable        = 421, ///< Service not available, closing control connection
		DataConnectionUnavailable = 425, ///< Can't open data connection
		TransferAborted           = 426, ///< Connection closed, transfer aborted
		FileActionAborted         = 450, ///< Requested file action not taken
		LocalError                = 451, ///< Requested action aborted, local error in processing
		InsufficientStorageSpace  = 452, ///< Requested action not taken; insufficient storage space in system, file unavailable

		// 5xx: the command was not accepted and
		// the requested action did not take place
		CommandUnknown          = 500, ///< Syntax error, command unrecognized
		ParametersUnknown       = 501, ///< Syntax error in parameters or arguments
		CommandNotImplemented   = 502, ///< Command not implemented
		BadCommandSequence      = 503, ///< Bad sequence of commands
		ParameterNotImplemented = 504, ///< Command not implemented for that parameter
		NotLoggedIn             = 530, ///< Not logged in
		NeedAccountToStore      = 532, ///< Need account for storing files
		FileUnavailable         = 550, ///< Requested action not taken, file unavailable
		PageTypeUnknown         = 551, ///< Requested action aborted, page type unknown
		NotEnoughMemory         = 552, ///< Requested file action aborted, exceeded storage allocation
		FilenameNotAllowed      = 553, ///< Requested action not taken, file name not allowed

		// 10xx: SFML custom codes
		InvalidResponse  = 1000, ///< Response is not a valid FTP one
		ConnectionFailed = 1001, ///< Connection with server failed
		ConnectionClosed = 1002, ///< Connection with server closed
		InvalidFile      = 1003  ///< Invalid file to upload / download
	}

	public class Ftp : SFHandle<FtpHandle>
	{
		public this() : base(sfFtp_create()) {}
		public ~this() { sfFtp_destroy(_handle); }

		public FtpResponse Connect(IpAddress server, uint16 port, Time timeout) => new FtpResponse(sfFtp_connect(_handle, server, port, timeout));

		public FtpResponse LoginAnonymous() => new FtpResponse(sfFtp_loginAnonymous(_handle));

		public FtpResponse Login(String name, String password) => new FtpResponse(sfFtp_login(_handle, name.CStr(), password.CStr()));
		public FtpResponse Login(StringView name, StringView password) => new FtpResponse(sfFtp_login(_handle, name.ToScopeCStr!(), password.ToScopeCStr!()));

		public FtpResponse Disconnect() => new FtpResponse(sfFtp_disconnect(_handle));

		public FtpResponse KeepAlive() => new FtpResponse(sfFtp_keepAlive(_handle));

		public FtpDirectoryResponse GetWorkingDirectory() => new FtpDirectoryResponse(sfFtp_getWorkingDirectory(_handle));

		public FtpListingResponse GetDirectoryListing(String directory) => new FtpListingResponse(sfFtp_getDirectoryListing(_handle, directory.CStr()));
		public FtpListingResponse GetDirectoryListing(StringView directory) => new FtpListingResponse(sfFtp_getDirectoryListing(_handle, directory.ToScopeCStr!()));

		public FtpResponse ChangeDirectory(String directory) => new FtpResponse(sfFtp_changeDirectory(_handle, directory.CStr()));
		public FtpResponse ChangeDirectory(StringView directory) => new FtpResponse(sfFtp_changeDirectory(_handle, directory.ToScopeCStr!()));

		public FtpResponse ParentDirectory() => new FtpResponse(sfFtp_parentDirectory(_handle));

		public FtpResponse CreateDirectory(String name) => new FtpResponse(sfFtp_createDirectory(_handle, name.CStr()));
		public FtpResponse CreateDirectory(StringView name) => new FtpResponse(sfFtp_createDirectory(_handle, name.ToScopeCStr!()));

		public FtpResponse DeleteDirectory(String name) => new FtpResponse(sfFtp_deleteDirectory(_handle, name.CStr()));
		public FtpResponse DeleteDirectory(StringView name) => new FtpResponse(sfFtp_deleteDirectory(_handle, name.ToScopeCStr!()));

		public FtpResponse RenameFile(String file, String newName) => new FtpResponse(sfFtp_renameFile(_handle, file.CStr(), newName.CStr()));
		public FtpResponse RenameFile(StringView file, StringView newName) => new FtpResponse(sfFtp_renameFile(_handle, file.ToScopeCStr!(), newName.ToScopeCStr!()));

		public FtpResponse DeleteFile(String name) => new FtpResponse(sfFtp_deleteFile(_handle, name.CStr()));
		public FtpResponse DeleteFile(StringView name) => new FtpResponse(sfFtp_deleteFile(_handle, name.ToScopeCStr!()));

		public FtpResponse Download(String remoteFile, String localPath, FtpTransferMode mode) => new FtpResponse(sfFtp_download(_handle, remoteFile.CStr(), localPath.CStr(), mode));
		public FtpResponse Download(StringView remoteFile, StringView localPath, FtpTransferMode mode) => new FtpResponse(sfFtp_download(_handle, remoteFile.ToScopeCStr!(), localPath.ToScopeCStr!(), mode));

		public FtpResponse Upload(String localFile, String remotePath, FtpTransferMode mode, bool appendFile) => new FtpResponse(sfFtp_upload(_handle, localFile.CStr(), remotePath.CStr(), mode, appendFile == true ? 1 : 0));
		public FtpResponse Upload(StringView localFile, StringView remotePath, FtpTransferMode mode, bool appendFile) => new FtpResponse(sfFtp_upload(_handle, localFile.ToScopeCStr!(), remotePath.ToScopeCStr!(), mode, appendFile == true ? 1 : 0));

		public FtpResponse SendCommand(String command, String parameter) => new FtpResponse(sfFtp_sendCommand(_handle, command.CStr(), parameter?.CStr()));
		public FtpResponse SendCommand(StringView command, StringView parameter) => new FtpResponse(sfFtp_sendCommand(_handle, command.ToScopeCStr!(), parameter.IsNull ? null : parameter.ToScopeCStr!()));

		// Native functions
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpHandle sfFtp_create();
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfFtp_destroy(FtpHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_connect(FtpHandle handle, IpAddress server, uint16 port, Time timeout);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_loginAnonymous(FtpHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_login(FtpHandle handle, char8* name, char8* password);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_disconnect(FtpHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_keepAlive(FtpHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_getWorkingDirectory(FtpHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_getDirectoryListing(FtpHandle handle, char8* directory);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_changeDirectory(FtpHandle handle, char8* directory);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_parentDirectory(FtpHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_createDirectory(FtpHandle handle, char8* name);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_deleteDirectory(FtpHandle handle, char8* name);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_renameFile(FtpHandle handle, char8* file, char8* newName);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_deleteFile(FtpHandle handle, char8* name);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_download(FtpHandle handle, char8* remoteFile, char8* localPath, FtpTransferMode mode);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_upload(FtpHandle handle, char8* localFile, char8* remotePath, FtpTransferMode mode, int appendFile);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpResponseHandle sfFtp_sendCommand(FtpHandle handle, char8* command, char8* parameter);
	}

	public class FtpResponse : SFHandle<FtpResponseHandle>
	{
		protected bool deleted;

		public this(FtpResponseHandle handle) : base(handle) {}
		public ~this() { if (!deleted) sfFtpResponse_destroy(_handle); }

		public virtual bool IsOk() => sfFtpResponse_isOk(_handle) == 1 ? true : false;
		public virtual FtpStatus GetStatus() => sfFtpResponse_getStatus(_handle);

		public virtual void GetMessage(String buffer) => buffer.Append(sfFtpResponse_getMessage(_handle));

		// Native functions
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfFtpResponse_destroy(FtpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int sfFtpResponse_isOk(FtpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpStatus sfFtpResponse_getStatus(FtpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern char8* sfFtpResponse_getMessage(FtpResponseHandle handle);
	}

	public class FtpListingResponse : FtpResponse
	{
		public this(FtpResponseHandle handle) : base(handle) {}
		public ~this() { sfFtpListingResponse_destroy(_handle); deleted = true; }

		public override bool IsOk() => sfFtpListingResponse_isOk(_handle) == 1 ? true : false;
		public override FtpStatus GetStatus() => sfFtpListingResponse_getStatus(_handle);

		public override void GetMessage(String buffer) => buffer.Append(sfFtpListingResponse_getMessage(_handle));
		public uint64 GetCount() => sfFtpListingResponse_getCount(_handle);
		public void GetName(uint64 index, String buffer) => buffer.Append(sfFtpListingResponse_getName(_handle, index));

		// Native functions

		[Import(CSFML_NETWORK), CLink]
		private static extern void sfFtpListingResponse_destroy(FtpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int sfFtpListingResponse_isOk(FtpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpStatus sfFtpListingResponse_getStatus(FtpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern char8* sfFtpListingResponse_getMessage(FtpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern uint64 sfFtpListingResponse_getCount(FtpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern char8* sfFtpListingResponse_getName(FtpResponseHandle handle, uint64 index);
	}

	public class FtpDirectoryResponse : FtpResponse
	{
		public this(FtpResponseHandle handle) : base(handle) {}
		public ~this() { sfFtpDirectoryResponse_destroy(_handle); deleted = true; }

		public override bool IsOk() => sfFtpDirectoryResponse_isOk(_handle) == 1 ? true : false;
		public override FtpStatus GetStatus() => sfFtpDirectoryResponse_getStatus(_handle);

		public override void GetMessage(String buffer) => buffer.Append(sfFtpDirectoryResponse_getMessage(_handle));
		public void GetDirectory(String buffer) => buffer.Append(sfFtpDirectoryResponse_getDirectory(_handle));

		// Native functions
		
		[Import(CSFML_NETWORK), CLink]
		private static extern void sfFtpDirectoryResponse_destroy(FtpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern int sfFtpDirectoryResponse_isOk(FtpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern FtpStatus sfFtpDirectoryResponse_getStatus(FtpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern char8* sfFtpDirectoryResponse_getMessage(FtpResponseHandle handle);
		
		[Import(CSFML_NETWORK), CLink]
		private static extern char8* sfFtpDirectoryResponse_getDirectory(FtpResponseHandle handle);
	}
}
