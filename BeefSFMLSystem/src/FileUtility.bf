using System;
using System.IO;

namespace SFML.System
{
	public static class FileUtility
	{
		public static void ToRelativePath(String filename)
		{
			let exePath = scope String();
			let	dirPath = scope String();

			Environment.GetExecutableFilePath(exePath);
			Path.GetDirectoryPath(exePath, dirPath);

			#if BF_PLATFORM_WINDOWS
				filename.Insert(0, "\\");
			#else
				filename.Insert(0, "/");
			#endif

			filename.Insert(0, dirPath);
		}
	}
}
