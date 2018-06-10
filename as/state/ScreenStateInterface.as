/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package state {   // Start Package
	
	// Flash Imports
	import flash.display.Sprite;
	
	
	
	public interface ScreenStateInterface {   // Start Interface: ScreenStateInterface
		
		// Getters
		function get sound():Boolean;								// Get: sound
		function get music():Boolean;								// Get: music
		function get primaryLayer():Sprite;							// Get: primaryLayer
		function get layerList():Vector.<Sprite>;					// Get: layerList
		
		// Required Methods
		function init():void;										// Method: init
		function update():void;										// Method: update
		function dispose():void;									// Method: dispose
		
	} // End Interface: ScreenStateInterface
	
} // End Package