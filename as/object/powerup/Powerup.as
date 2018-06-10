/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.powerup {   // Start Package
	
	// Flash Imports
	import flash.display.MovieClip;
	
	// Project Imports
	import object.Entity;
	import manager.PowerupManager;
	
	
	
	public class Powerup extends Entity implements PowerupInterface {   // Start Class: Powerup
		
		public function Powerup(manager:PowerupManager, movieClip:MovieClip, movieScale:Number, movieSpeed:Number) {   // Start Constructor: Powerup
			super(manager, movieClip, movieScale, movieSpeed);
			_speed = 2.5;
		} // End Constructor: Powerup
		
		
		
		// Override Public Methods
		override public function init():void {   // Start Method: init
			super.init();
			setToOffScreen();
		 } // End Method: init
		
		override public function update():void {   // Start Method: update
			super.update();
			moveToLeft();
		} // End Method: update
		
		
		
		// Public Methods
		public function activate():void								{ }   // Method: activate
		
	} // End Class: Powerup
	
} // End Package