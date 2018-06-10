/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.obstacle {   // Start Package
	
	// Project Imports
	import asset.obstacle.ThunderClip;
	import object.Entity;
	import manager.ObstacleManager;
	
	
	
	public class Thunder extends Obstacle {   // Start Class: Thunder
		
		// Getters
		override protected function get scale():Number				{ return 1.5; }   // Get: scale
		
		
		
		// Private Variables
		private var _target:Entity;
		private var _targetHeight:Number;
		
		
		
		public function Thunder(manager:ObstacleManager, target:Entity) {   // Start Constructor: Thunder
			super(manager, new ThunderClip, scale, 0.5);
			_movieClip.rotation = 180;
			_target = target;
			_targetHeight = _target.height;
		} // End Constructor: Thunder
		
		
		
		// Override Public Methods
		override public function init():void {   // Start Method: init
			super.init();
			_damage = 25;
		 } // End Method: init
		
		override public function update():void {   // Start Method: update
			super.update();
			
			x = _target.x;
			y = _target.y + _targetHeight/2 + height/2;
			
			// Destroy the lightning when the bird is dead
			if (!_target.hasEnergy)
				_manager.remove(_manager.indexOf(self));
		} // End Method: update
		
	} // End Class: Thunder
	
} // End Package