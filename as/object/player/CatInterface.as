/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.player {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.input.EvertronControls;
	
	
	
	public interface CatInterface {   // Start Interface: CatInterface
		
		// Getters
		function get controls():EvertronControls;					// Get: controls
		function get height():Number;								// Get: height
		function get width():Number;								// Get: width
		
		// Required Methods
		function init():void;										// Method: init
		function update():void;										// Method: update
		function dispose():void;									// Method: dispose
		
		// Method
		function getHit(value:uint):void;							// Method: getHit
		function restore(value:uint):void;							// Method: restore
		
	} // End Interface: CatInterface
	
} // End Package