/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object {   // Start Package
	
	// Flash Imports
	import flash.display.Sprite;
	
	// Project Imports
	import manager.EntityManager;
	
	
	
	public interface EntityInterface {   // Start Interface: EntityInterface
		
		// Getters
		function get energy():Number;									// Get: energy
		function get hasEnergy():Boolean;								// Get: hasEnergy
		function get sound():Boolean;									// Get: sound
		function get manager():EntityManager;							// Get: manager
		function get list():Vector.<*>;									// Get: list
		function get layer():Sprite;									// Get: layer
		function get speed():Number;									// Get: speed
		
		// Required Methods
		function init():void;											// Method: init
		function update():void;											// Method: update
		function dispose():void;										// Method: dispose
		
		// Methods
		function pushBack(pushBack:Number, yPush:Boolean=true):void;	// Method: pushBack
		function setEnergy(value:int, relative:Boolean):void;			// Method: setEnergy
		function collide(entity:Entity):Boolean;						// Method: collide
		
	} // End Interface: EntityInterface
	
} // End Package