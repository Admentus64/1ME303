/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.bird {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.media.SoundObject;
	
	// Flash Imports
	import flash.display.MovieClip;
	
	// Project Imports
	import asset.bird.BirdAirplaneIdleClip;
	import asset.bird.BirdAirplaneHitClip;
	import asset.bird.BirdAirplaneShootClip;
	import asset.bird.BirdAirplaneFallingClip;
	import asset.bird.BirdAirplaneBulletClip;
	import manager.BirdManager;
	
	
	
	public class BirdAirplane extends Bird {   // Start Class: BirdAirplane
		
		// Override Public Getters
		override public function get bulletClip():MovieClip			{ return new BirdAirplaneBulletClip; }								// Get: bulletClip
		override public function get bulletClipScale():Number		{ return 0.2; }														// Get: bulletClipScale
		override public function get bulletOffsetX():Number			{ return -10; }														// Get: bulletOffsetX
		override public function get bulletOffsetY():Number			{ return 10; }														// Get: bulletOffsetY
		
		// Override Protected Getters
		override protected function get scale():Number				{ return 0.4; }														// Get: scale
		override protected function get idleClip():MovieClip		{ return new BirdAirplaneIdleClip; }								// Get: idleClip
		override protected function get hitClip():MovieClip			{ return new BirdAirplaneHitClip; }									// Get: hitClip
		override protected function get shootClip():MovieClip		{ return new BirdAirplaneShootClip; }								// Get: shootClip
		override protected function get fallingClip():MovieClip		{ return new BirdAirplaneFallingClip; }								// Get: fallingClip
		override protected function get shootSound():SoundObject	{ return Session.sound.soundChannel.get("Bird Airplane Shoot"); }	// Get: shootSound
		
		
			
		public function BirdAirplane(manager:BirdManager)			{ super(manager, "Bird Airplane Dead", 1, 1); }						// Constructor: BirdAirplane
		
		
		
		// Override Public Methods
		override public function init():void {   // Start Method: init
			super.init();
			_hitValue = _maxEnergy/3;
			_damage = 20;
			_score = 10;
			_bulletDelay = 0;
			setShootTimer();
		} // End Method: init
		
		
		
		// Override Protected Methods
		override protected function setShootTimer() {   // Start Method: setShootTimer
			var rand = Math.round(Math.random() * 1000 + 2000);
			_timer = Session.timer.create(rand, shoot);
		} // End Method: setShootTimer
		
	} // End Class: BirdAirplane
	
} // End Package