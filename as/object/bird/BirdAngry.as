/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.bird {   // Start Package
	
	// Flash Imports
	import flash.display.MovieClip;
	
	// Project Imports
	import asset.bird.BirdAngryIdleClip;
	import asset.bird.BirdAngryHitClip;
	import asset.bird.BirdAngryFallingClip;
	import manager.BirdManager;
	import object.Entity;
	
	
	public class BirdAngry extends Bird {   // Start Class: BirdAngry
		
		// Getters
		public function get follower():Boolean						{ return _leader != null; }				// Get: follower
		override protected function get scale():Number				{ return 0.3; }							// Get: scale
		override protected function get idleClip():MovieClip		{ return new BirdAngryIdleClip; }		// Get: idleClip
		override protected function get hitClip():MovieClip			{ return new BirdAngryHitClip; }		// Get: hitClip
		override protected function get fallingClip():MovieClip		{ return new BirdAngryFallingClip; }	// Get: fallingClip
		
		
		
		// Private Variables
		private var _target:Entity = null;
		private var _leader:Entity = null;
		private var _leaderWidth:Number = 0;
		private var _leaderHeight:Number = 0;
		private var _onTop:Boolean;
		private var _standStill:int = 0;
		private var _lastX:Number = 0;
		
		
		
		public function BirdAngry(manager:BirdManager, target:Entity, leader:Entity=null, onTop:Boolean=true) {   // Start Constructor: BirdAngry
			super(manager, "Bird Angry Dead", 0.75, 1);
			_target = target;
			_leader = leader;
			_onTop = onTop;
			
			// If the bird is assigned a leader, get the leader's initial width, height and speed
			if (_leader != null) {
				_leaderWidth = _leader.width;
				_leaderHeight = _leader.height;
				_speed = _leader.speed;
			}
		} // End Constructor: BirdAngry
		
		
		
		// Override Public Methods
		override public function init():void {   // Start Method: init
			super.init();
			_hitValue = 50;
			_damage = 20;
			_score = 5;
		 } // End Method: init
		
		override public function update():void {   // Start Method: update
			super.update();
			moveToTarget();
			followLeader();
		} // End Method: update
		
		
		
		// Private Methods
		private function moveToTarget():void {   // Start Method: moveToTarget
			// Only the leader follows a target (read: player), but only when it has energy. If a bird has no leader anymore it is free to follow their target
			if (_target == null || !hasEnergy || _leader != null)
				return;
			
			// Adjust the height position towards the target
			if (y < _target.y)
				y++;
			else y--;
		} // End Method: moveToTarget
		
		private function followLeader():void {   // Start Method: followLeader
			// If the leader is dead or the bird lacks energy itself, stop following the leader
			if (_leader == null || !hasEnergy)
				return;
			
			// Stay in a V-form formation when following the leader
			x = _leader.x + _leaderWidth;
			if (_onTop)
				y = _leader.y + _leaderHeight/1.5;
			else y = _leader.y - _leaderHeight/1.5;
			
			// Allow V-form to break free when the leader is dying or the bird itself is out of the screen to the left
			if (!_leader.hasEnergy || x < -width)
				_leader = null;
		} // End Method: followLeader
		
	} // End Class: BirdAngry
	
} // End Package