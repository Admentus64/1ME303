/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.player {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.media.SoundObject;
	
	// Flash Imports
	import flash.display.MovieClip;
	
	// Project Imports
	import asset.player.SuperDogIdleClip;
	import asset.player.SuperDogShootClip;
	import asset.player.SuperDogHitClip;
	import asset.player.SuperDogUpClip;
	import asset.player.SuperDogDownClip;
	import asset.player.SuperDogForwardClip;
	import asset.player.SuperDogBackwardClip;
	import asset.player.SuperDogFallingClip;
	import manager.PlayerManager;
	
	
	
	public class Dog extends Cat {   // Start Class: Dog
		
		// Getters
		override protected function get scale():Number				{ return 0.19; }											// Get: scale
		override protected function get idleClip():MovieClip		{ return new SuperDogIdleClip; }							// Get: idleClip
		override protected function get hitClip():MovieClip			{ return new SuperDogHitClip; }								// Get: hitClip
		override protected function get shootClip():MovieClip		{ return new SuperDogShootClip; }							// Get: shootClip
		override protected function get upClip():MovieClip			{ return new SuperDogUpClip; }								// Get: upClip
		override protected function get downClip():MovieClip		{ return new SuperDogDownClip; }							// Get: downClip
		override protected function get forwardClip():MovieClip		{ return new SuperDogForwardClip; }							// Get: forwardClip
		override protected function get backwardClip():MovieClip	{ return new SuperDogBackwardClip; }						// Get: backwardClip
		override protected function get fallingClip():MovieClip		{ return new SuperDogFallingClip; }							// Get: fallingClip
		override protected function get isHitClip():Boolean			{ return _movieClip is SuperDogHitClip; }					// Get: isHitClip
		override protected function get isShootClip():Boolean		{ return _movieClip is SuperDogShootClip; }					// Get: isShootClip
		override protected function get getHitSoundVolume():Number	{ return 0.8; }												// Get: getHitSoundVolume
		override protected function get deadSoundVolume():Number	{ return 1; }												// Get: deadSoundVolume
		override protected function get getHitSound():SoundObject	{ return Session.sound.soundChannel.get("Dog Get Hit"); }	// Get: getHitSound
		override protected function get deadSound():SoundObject		{ return Session.sound.soundChannel.get("Dog Dead"); }		// Get: deadSound
		
		
		
		public function Dog(manager:PlayerManager, controls:EvertronControls) {   // Start Constructor: Dog
			super(manager, controls);
		} // End Constructor: Dog
		
		
		
		// Override Protected Methods
		
		
	} // End Class: Dog
	
} // End Package