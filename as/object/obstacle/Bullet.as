/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.obstacle {   // Start Package
	
	// Flash Imports
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	// Project Imports
	import object.bird.Bird;
	import manager.ObstacleManager;
	
	
	
	public class Bullet extends Obstacle {   // Start Class: Bullet
		
		// Getters
		override public function get layer():Sprite					{ return _layer; }   // Get: layer
		
		
		
		// Private Variables
		private var _layer:Sprite = null;
		
		
		
		public function Bullet(manager:ObstacleManager, bird:Bird) {   // Start Constructor: Bullet
			_layer = bird.manager.layer;
			
			super(manager, bird.bulletClip, bird.bulletClipScale, 0.5);
			
			_speed = bird.speed * 1.5;
			if (_speed < 4)
				_speed = 4;
			
			_damage = bird.damage;
			_layer = bird.layer;
			
			x = bird.x - bird.width/2 + 10 + bird.bulletOffsetX;
			y = bird.y + bird.bulletOffsetY;
		} // End Constructor: Bullet
		
	} // End Class: Bullet
	
} // End Package