/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package manager {   // Start Package
	
	// Flash Imports
	import flash.display.Sprite;
	
	// Project Imports
	import object.Entity;
	
	
	
	public interface EntityManagerInterface {   // Start Interface: EntityManagerInterface
		
		// Getters
		function get list():Vector.<*>;								// Get: list
		function get length():int;									// Get: length
		function get sound():Boolean;								// Get: sound
		function get layer():Sprite;								// Get: layer
		function get seconds():uint;								// Get: seconds
		
		// Required Methods
		function init():void;										// Method: init
		function update():void;										// Method: update
		function dispose():void;									// Method: dispose
		
		// Method
		function indexOf(entity:Entity):uint;						// Method: index
		function remove(index:uint):void;							// Method: remove
		
	} // End Interface: EntityManagerInterface
	
} // End Package