/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.bird {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	import se.lnu.stickossdk.media.SoundObject;
	
	// Flash Imports
	import flash.display.MovieClip;
	
	// Project Imports
	import object.Entity;
	import manager.BirdManager;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	
	
	
	public class Bird extends Entity implements BirdInterface {   // Start Class: Bird
		
		// Public Getters
		public function get damage():Number							{ return _damage; }				// Get: damage
		public function get score():uint							{ return _score; }				// Get: score
		public function get bulletClip():MovieClip					{ return null; }				// Get: bulletClip
		public function get bulletClipScale():Number				{ return 1; }					// Get: bulletClipScale
		public function get bulletOffsetX():Number					{ return 0; }					// Get: bulletOffsetX
		public function get bulletOffsetY():Number					{ return 0; }					// Get: bulletOffsetY
		
		// Protected Getters
		protected function get idleClip():MovieClip					{ return null; }				// Get: idleClip
		protected function get hitClip():MovieClip					{ return null; }				// Get: hitClip
		protected function get shootClip():MovieClip				{ return null; }				// Get: shootClip
		protected function get fallingClip():MovieClip				{ return null; }				// Get: fallingClip
		protected function get shootSound():SoundObject				{ return null }					// Get: shootSound
		
		// Private Getters
		private function get randomSpeed():Number {   // Start Get: randomSpeed
			if (_manager.seconds < 10)
				return 1.5;
			else if (_manager.seconds < 30)
				return Math.random() * 0.75 + 1.5;
			else if (_manager.seconds < 45)
				return Math.random() * 1 + 1.5;
			else if (_manager.seconds < 60)
				return Math.random() * 1.25 + 1.5;
			else if (_manager.seconds < 90)
				return Math.random() * 1.5 + 1.5;
			else if (_manager.seconds < 120)
				return Math.random() * 1.75 + 1.5;
			else if (_manager.seconds < 150)
				return Math.random() * 1.75 + 1.75;
			else if (_manager.seconds < 180)
				return Math.random() * 1.75 + 2;
			return Math.random() * 2 + 2;
		} // End Get: randomSpeed
		
		
		
		// Protected Variables
		protected var _hitValue:Number = 100;
		protected var _damage:Number = 0;
		protected var _score:uint = 0;
		protected var _timer:Timer = null;
		protected var _sndGetHit:SoundObject = null;
		protected var _sndDead:SoundObject = null;
		protected var _soundVolume:Number = 1;
		protected var _bulletDelay:uint = 0;
		
		
		
		public function Bird(manager:BirdManager, soundName:String, soundVolume:Number=1, movieSpeed:Number=1) {   // Start Constructor: Bird
			super(manager, idleClip, scale, movieSpeed);
			_soundVolume = soundVolume;
			initSound(soundName);
			_speed = randomSpeed;
		} // End Constructor: Bird
		
		
		
		// Override Public Methods
		override public function init():void {   // Start Method: init
			super.init();
			setToOffScreen();
		 } // End Method: init
		
		override public function update():void {   // Start Method: update
			super.update();
			
			// Play the default idle animation when no animation is currently playing
			if (!_controller.isPlaying)
				replaceMovieClip(idleClip, scale, 1, false);
			
			// As long it has energy, keep going to the left, otherwise it should prepare to die
			if (hasEnergy)
				moveToLeft();
			else fallingDead();
		} // End Method: update
		
		override public function dispose():void {   // Start Method: dispose
			super.dispose();
			
			if (_timer != null)
				_timer.stop();
		} // End Method: dispose
		
		
		
		// Public Methods
		public function getHit():void	{   // Start Method: getHit
			replaceMovieClip(hitClip, scale, 1, false);
			
			// Subtract the health from the bird with the value of the damage it takes by an arrow, double that damage if the double damage powerup is active
			if (_manager.doubleDamage)
				setEnergy(-(_hitValue*2), true);
			else setEnergy(-_hitValue, true);
			
			// If all energy is depleted by being hit, the bird is going down (read: dead)
			if (energy == 0) {
				_manager.addScore(self);
				if (_timer != null)
					_timer.stop();
				playSound(_sndDead, _soundVolume);
				replaceMovieClip(fallingClip, scale, 1, true);
			}
			else playSound(_sndGetHit, 0.5);
		} // End Method: getHit
		
		
		
		// Protected Methods
		protected function shoot()  {   // Start Method: shoot
			// Shoot a bullet, if there is a delay wait before shooting the bullet with the sound a while
			if (_bulletDelay > 0)
				Session.timer.create(_bulletDelay, function():void { _manager.shoot(self); playSound(shootSound, 0.3); } );
			else { 
				_manager.shoot(self);
				playSound(shootSound, 0.3);
			}
			
			// Switch to the shooting animation and set the next timer when to shoot
			replaceMovieClip(shootClip, scale, 1, false);
			setShootTimer();
		} // End Method: shoot
		
		protected function setShootTimer() {   // Start Method: setShootTimer
			var rand = Math.round(Math.random() * 3000 + 2000);
			_timer = Session.timer.create(rand, shoot);
		} // End Method: setShootTimer
		
		protected function fallingDead() {   // Start Method: fallingDead
			y += 5;
			x -= _speed*1.5;
		} // End Method: fallingDead
		
		protected function initSound(soundName:String):void {   // Start Method: initSound
			if (soundName == null)
				return;
			
			_sndDead = Session.sound.soundChannel.get(soundName);
			_sndGetHit = Session.sound.soundChannel.get("Bird Get Hit");
		} // End Method: initSound
		
	} // End Class: Bird
	
} // End Package