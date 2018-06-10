/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.powerup {   // Start Package
	
	public interface PowerupInterface {   // Start Interface: PowerupInterface
		
		// Required Methods
		function init():void;										// Method: init
		function update():void;										// Method: update
		function dispose():void;									// Method: dispose
		
		// Methods
		function activate():void;									// Method: activate
		
	} // End Interface: PowerupInterface
	
} // End Package