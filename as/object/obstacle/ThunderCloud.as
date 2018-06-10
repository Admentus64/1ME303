/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.obstacle {   // Start Package
	
	// Project Imports
	import asset.obstacle.ThunderCloudClip;
	import manager.ObstacleManager;
	import object.Entity;
	
	
	
	public class ThunderCloud extends Obstacle {   // Start Class: ThunderCloud
		
		// Getters
		override protected function get scale():Number				{ return 0.7; }										// Get: scale
		
		
		
		public function ThunderCloud(manager:ObstacleManager)		{ super(manager, new ThunderCloudClip, scale, 0.5); }   // Constructor: ThunderCloud
		
		
		
		// Override Public Methods
		override public function init():void {   // Start Method: init
			super.init();
			setToOffScreen();
			_damage = 15;
			_speed = 1.5;
		} // End Method: init
		 
		override public function collide(entity:Entity):Boolean {   // Start Method: collide
			// Simplify the position variables of the entity to be checked against
			var eX1 = entity.x - entity.width/2;
			var eX2 = entity.x + entity.width/2;
			var eY1 = entity.y - entity.height/2;
			var eY2 = entity.y + entity.height/2;
			
			// Simplify the position variables of the entity itself
			var x1 = x - width/2;
			var x2 = x + width/2;
			var y1 = y - height/2;
			var y2 = y + height/2;
			
			// Check if the entity itself collides into the position of the entity it is being check against (by using several position checks)
			if (eX1 <= (x2 - width*0.8) && eX2 >= (x1 + width*0.2) && eY1 <= (y2 - height*0.7) && eY2 >= (y1 + height*0.3))
				return true;
			if (eX1 <= (x2 - width*0.2) && eX2 >= (x1 + width*0.8) && eY1 <= (y2 - height*0.8) && eY2 >= (y1 + height*0.2))
				return true;
			if (eX1 <= x2 && eX2 >= x1 && eY1 <= y2 && eY2 >= (y1 + height*0.7))
				return true;
			return false;
		} // End Method: collide
		
	} // End Class: ThunderCloud
	
} // End Package