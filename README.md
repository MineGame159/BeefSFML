# BeefSFML
SFML wrapper for the Beef programming language https://www.beeflang.org created by Meatnose (EnokViking) and then finished by me.
This wrapper depends on the CSFML bindings which can be found here: https://www.sfml-dev.org/download/csfml.

This API is not documented but it is mostly similar to the SFML.NET binding which was used as a point of reference.

# Quick Start *(using Beef IDE)*
1. **Download** Copy this repository or download the ZIP-archive.
2. Either copy the submodule folders (BeefSFMLSystem, Graphics, Windows, Network & Audio) to the 'BeefLibs' folder in your beef installation directory -
   or just place them wherever you see fit.
3. If you placed them in the 'BeefLibs' folder, you can simply rightclick your workspace and click "Add from installed", else you have to click "Add existing project" -
   and manually navigate to each BeefProj.toml
4. **Mark** the modules **as a dependency** of your startup project by rightclick -> properties -> dependencies
5. Enjoy beautiful **SFML**.

```cs
using (let window = new RenderWindow(VideoMode(800, 600), "Game")) {

	window.ClosedEvent.Add(scope (window) => {
		window.Close();
	});

	while (window.IsOpen()) {
		window.DispatchEvents();
		window.Clear(Color.CornflowerBlue);
		window.Display();
	}
}
```
