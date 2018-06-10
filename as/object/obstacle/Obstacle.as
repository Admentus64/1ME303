/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.obstacle {   // Start Package
	
	// Flash Imports
	import flash.display.MovieClip;
	
	// Project Imports
	import object.Entity;
	import manager.ObstacleManager;
	
	
	
	public class Obstacle extends Entity implements ObstacleInterface {   // Start Class: Obstacle
		
		// Getters
		public function get damage():Number							{ return _damage; }   // Get: damage
		
		
		
		// Protected Variables
		protected var _damage:Number = 0;
		
		
		
		public function Obstacle(manager:ObstacleManager, movieClip:MovieClip, movieScale:Number, movieSpeed:Number) {   // Start Constructor: Obstacle
			super(manager, movieClip, movieScale, movieSpeed);
		} // End Constructor: Obstacle
		
		
		
		// Override Public Methods
		override public function update():void {   // Start Method: update
			super.update();
			moveToLeft();
		} // End Method: update
		
	} // End Class: Obstacle
	
} // End Package