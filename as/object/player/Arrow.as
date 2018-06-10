/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.player {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	
	// Project Imports
	import asset.player.ArrowClip;
	import object.Entity;
	import manager.ArrowManager;
	
	
	
	public class Arrow extends Entity {   // Start Class: Arrow
		
		// Getters
		public function get player():uint							{ return _controls; }	// Get: player
		override protected function get scale():Number				{ return 0.3; }			// Get: scale
		
		
		
		// Private Variables
		private var _controls:uint = 0;
		
		
		
		public function Arrow(manager:ArrowManager, player:Cat) {   // Start Constructor: Arrow
			super(manager, new ArrowClip, scale, 1);
			_controls = player.controls.player;
			x = player.x + player.width/2 - 5;
			y = player.y + height;
			_speed = 8;
		} // End Constructor: Arrow
		
		
		
		// Override Public Methods
		override public function update():void {   // Start Method: update
			super.update();
			moveForward();
		} // End Method: update
		
		
		
		// Private Methods
		private function moveForward():void							{ x += _speed; }		// Method: moveForward
		
	} // End Class: Arrow
	
} // End Package