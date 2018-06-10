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
	import asset.bird.BirdRainCloudIdleClip;
	import asset.bird.BirdRainCloudHitClip;
	import asset.bird.BirdRainCloudShootClip;
	import asset.bird.BirdRainCloudFallingClip;
	import asset.bird.BirdRainCloudBulletClip;
	import manager.BirdManager;
	
	
	
	public class BirdRainCloud extends Bird {   // Start Class: BirdRainCloud
		
		// Override Public Getters
		override public function get bulletClip():MovieClip			{ return new BirdRainCloudBulletClip; }								// Get: bulletClip
		override public function get bulletClipScale():Number		{ return 1; }														// Get: bulletClipScale
		override public function get bulletOffsetX():Number			{ return 10; }														// Get: bulletOffsetX
		override public function get bulletOffsetY():Number			{ return -40; }														// Get: bulletOffsetY
		
		// Override Protected Getters
		override protected function get scale():Number				{ return 0.65; }													// Get: scale
		override protected function get idleClip():MovieClip		{ return new BirdRainCloudIdleClip; }								// Get: idleClip
		override protected function get hitClip():MovieClip			{ return new BirdRainCloudHitClip; }								// Get: hitClip
		override protected function get shootClip():MovieClip		{ return new BirdRainCloudShootClip; }								// Get: shootClip
		override protected function get fallingClip():MovieClip		{ return new BirdRainCloudFallingClip; }							// Get: fallingClip
		override protected function get shootSound():SoundObject	{ return Session.sound.soundChannel.get("Bird Cloud Shoot"); }		// Get: shootSound
		
		
		
		public function BirdRainCloud(manager:BirdManager)			{ super(manager, "Bird Rain Cloud Dead", 2, 1); }					// Constructor: BirdRainCloud
		
		
		
		// Override Public Methods
		override public function init():void {   // Start Method: init
			super.init();
			_hitValue = 20;
			_damage = 25;
			_score = 15;
			_bulletDelay = 900;
			setShootTimer();
		} // End Method: init
		
		
		
		// Override Protected Methods
		override protected function setShootTimer() {   // Start Method: setShootTimer
			var rand = Math.round(Math.random() * 1000 + 2000);
			_timer = Session.timer.create(rand, shoot);
		} // End Method: setShootTimer
		
	} // End Class: BirdRainCloud
	
} // End Package