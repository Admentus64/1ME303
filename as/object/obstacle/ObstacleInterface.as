/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.obstacle {   // Start Package
	
	public interface ObstacleInterface {   // Start Interface: ObstacleInterface
		
		// Getters
		function get damage():Number;								// Get: damage
		
		// Required Methods
		function init():void;										// Method: init
		function update():void;										// Method: update
		function dispose():void;									// Method: dispose
		
	} // End Interface: ObstacleInterface
	
} // End Package