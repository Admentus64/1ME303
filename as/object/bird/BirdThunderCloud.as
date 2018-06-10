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
	import asset.bird.BirdThunderCloudIdleClip;
	import asset.bird.BirdThunderCloudHitClip;
	import asset.bird.BirdThunderCloudShootClip;
	import asset.bird.BirdThunderCloudFallingClip;
	import asset.bird.BirdThunderCloudBulletClip;
	import manager.BirdManager;
	
	
	
	public class BirdThunderCloud extends Bird {   // Start Class: BirdThunderCloud
		
		// Override Public Getters
		override public function get bulletClip():MovieClip			{ return new BirdThunderCloudBulletClip; }							// Get: bulletClip
		override public function get bulletClipScale():Number		{ return 2; }														// Get: bulletClipScale
		override public function get bulletOffsetX():Number			{ return 0; }														// Get: bulletOffsetX
		override public function get bulletOffsetY():Number			{ return -40; }														// Get: bulletOffsetY
		
		// Override Protected Getters
		override protected function get scale():Number				{ return 0.65; }													// Get: scale
		override protected function get idleClip():MovieClip		{ return new BirdThunderCloudIdleClip; }							// Get: idleClip
		override protected function get hitClip():MovieClip			{ return new BirdThunderCloudHitClip; }								// Get: hitClip
		override protected function get shootClip():MovieClip		{ return new BirdThunderCloudShootClip; }							// Get: shootClip
		override protected function get fallingClip():MovieClip		{ return new BirdThunderCloudFallingClip; }							// Get: fallingClip
		override protected function get shootSound():SoundObject	{ return Session.sound.soundChannel.get("Bird Cloud Shoot"); }		// Get: shootSound
		
		
		
		public function BirdThunderCloud(manager:BirdManager)		{ super(manager, "Bird Thunder Cloud Dead", 0.5, 1); }				// Constructor: BirdThunderCloud
		
		
		
		// Override Public Methods
		override public function init():void {   // Start Method: init
			super.init();
			_hitValue = 20;
			_damage = 30;
			_score = 15;
			_bulletDelay = 900;
			setShootTimer();
		} // End Method: init
		
		
		
		// Override Protected Methods
		override protected function setShootTimer() {   // Start Method: setShootTimer
			var rand = Math.round(Math.random() * 1000 + 2000);
			_timer = Session.timer.create(rand, shoot);
		} // End Method: setShootTimer111
		
	} // End Class: BirdThunderCloud
	
} // End Package