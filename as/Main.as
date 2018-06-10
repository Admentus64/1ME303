/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package  {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Engine;
	
	// Flash Imports
	import flash.geom.Point;
	
	// Project Imports
	import state.MainMenuState;
	
	// Internal SWF
	[SWF(width="800", height="600", frameRate="60", backgroundColor="#000000")]	
	
	
	
	public class Main extends Engine {   // Start Class: Main
		
		// Embeddings
		[Embed(source = "../asset/font/smileComixRegular.ttf", fontFamily = "regular", mimeType = "application/x-font", embedAsCFF="false")]		private static const TEXT_FONT_REGULAR:Class;
		[Embed(source = "../asset/font/londrinaSolidRegular.otf", fontFamily = "easyRead", mimeType = "application/x-font", embedAsCFF="false")]	private static const TEXT_FONT_EASYREAD:Class;
		
		
		
		public function Main()										{ }		// Constructor: Main
		
		
		
		// Override Public Methods
		override public function setup():void {   // Start Method: setup
			initId = 41;											// Our Game ID is 41! DO NOT CHANGE THIS! DO NOT TOUCH THIS! DO NOT LOOK AT THIS! PERIOD!
			initSize = new Point(800, 600);							// Evertron runs at 800x600
			initScale = new Point(1, 1);							// No need to rescale
			initDisplayState = MainMenuState;						// The first screen will be the main menu screen
			initBackgroundColor = 0x7EC0EE;							// Using a light blue sky color as the background on every screen
			initDebugger = false;									// Only to be used during development, set this to false when the beta starts
		} // End Method: setup
		
	} // End Class: Main
	
} // End Package