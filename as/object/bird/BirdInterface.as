/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.bird {   // Start Package
	
	public interface BirdInterface {   // Start Interface: BirdInterface
		
		// Getters
		function get damage():Number;								// Get: damage
		function get score():uint;									// Get: score
		
		// Required Methods
		function init():void;										// Method: init
		function update():void;										// Method: update
		function dispose():void;									// Method: dispose
		
		// Methods
		function getHit():void;										// Method: getHit
		
	} // End Interface: BirdInterface
	
} // End Package