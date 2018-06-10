/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.obstacle {   // Start Package
	
	// Project Imports
	import asset.obstacle.MountainClip;
	import manager.ObstacleManager;
	import object.Entity;
	
	
	
	public class Mountain extends Obstacle {   // Start Class: Mountain
		
		public function Mountain(manager:ObstacleManager, scale:Number) {   // Start Constructor: Mountain
			super(manager, new MountainClip, 1.5 * scale, 1);
		} // End Constructor: Mountain
		
		
		
		// Override Public Methods
		override public function init():void {   // Start Method: init
			super.init();
			setToOffScreen();
			y = stage.stageHeight - this.height/2 + 5;
			_damage = 25;
			_speed = 1;
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
			if (eX1 <= (x2 - width*0.2) && eX2 >= (x1 + width*0.3) && eY1 <= (y2 - height*0.3) && eY2 >= y1)
				return true;
			if (eX1 <= (x2 - width*0.1) && eX2 >= (x1 + width*0.2) && eY1 <= (y2 - height*0.3) && eY2 >= (y1 + height*0.3))
				return true;
			if (eX1 <= x2 && eX2 >= x1 && eY1 <= y2 && eY2 >= (y1 + height*0.8))
				return true;
			return false;
		} // End Method: collide
		
	} // End Class: Mountain
	
} // End Package