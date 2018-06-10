/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.player {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.input.EvertronControls;
	import se.lnu.stickossdk.media.SoundObject;
	import se.lnu.stickossdk.fx.Flicker;
	
	// Flash Imports
	import flash.display.MovieClip;
	
	// Project Imports
	import asset.player.SuperCatIdleClip;
	import asset.player.SuperCatHitClip;
	import asset.player.SuperCatShootClip;
	import asset.player.SuperCatUpClip;
	import asset.player.SuperCatDownClip;
	import asset.player.SuperCatForwardClip;
	import asset.player.SuperCatBackwardClip;
	import asset.player.SuperCatFallingClip;
	import object.Entity;
	import manager.PlayerManager;
	
	
	
	public class Cat extends Entity implements CatInterface {   // Start Class: Cat
		
		// Public Getters
		public function get controls():EvertronControls 			{ return _controls; }										// Get: controls
		override public function get height():Number				{ return idleClip.height*scale; }							// Get: height
		override public function get width():Number					{ return idleClip.width*scale; }							// Get: width
		
		// Protected Getters
		override protected function get scale():Number				{ return 0.175; }											// Get: scale
		protected function get idleClip():MovieClip					{ return new SuperCatIdleClip; }							// Get: idleClip
		protected function get hitClip():MovieClip					{ return new SuperCatHitClip; }								// Get: hitClip
		protected function get shootClip():MovieClip				{ return new SuperCatShootClip; }							// Get: shootClip
		protected function get upClip():MovieClip					{ return new SuperCatUpClip; }								// Get: upClip
		protected function get downClip():MovieClip					{ return new SuperCatDownClip; }							// Get: downClip
		protected function get forwardClip():MovieClip				{ return new SuperCatForwardClip; }							// Get: forwardClip
		protected function get backwardClip():MovieClip				{ return new SuperCatBackwardClip; }						// Get: backwardClip
		protected function get fallingClip():MovieClip				{ return new SuperCatFallingClip; }							// Get: fallingClip
		protected function get isHitClip():Boolean					{ return _movieClip is SuperCatHitClip; }					// Get: isHitClip
		protected function get isShootClip():Boolean				{ return _movieClip is SuperCatShootClip; }					// Get: isShootClip
		protected function get getHitSoundVolume():Number			{ return 1; }												// Get: getHitSoundVolume
		protected function get deadSoundVolume():Number				{ return 1; }												// Get: deadSoundVolume
		protected function get getHitSound():SoundObject			{ return Session.sound.soundChannel.get("Cat Get Hit"); }	// Get: getHitSound
		protected function get deadSound():SoundObject				{ return Session.sound.soundChannel.get("Cat Dead"); }		// Get: deadSound
		
		
		
		// Private Variables
		private var _jumpValue:Number = 0;
		private var _descentValue:Number = 0;
		private var _trackX:Number = 0;
		private var _moveForwards:Boolean = true;
		private var _arrowCooldown:Boolean = false;
		private var _immune:uint = 0;
		private var _dead:Boolean = false;
		private var _controls:EvertronControls = null;
		private var _activeAnimation:String = "Idle";
		private var _forward:Boolean = false;
		private var _backward:Boolean = false;
		
		// Private Static Constant Variables
		private static const _sndShoot:SoundObject = Session.sound.soundChannel.get("Player Shoot Arrow");
		private static const _sndJump:SoundObject = Session.sound.soundChannel.get("Player Jump");
		private static const _sndRestore:SoundObject = Session.sound.soundChannel.get("Player Restore");
		
		// Protected Constant Variables
		protected const _sndGetHit:SoundObject = getHitSound;
		protected const _sndDead:SoundObject = deadSound;
		
		
		
		public function Cat(manager:PlayerManager, controls:EvertronControls) {   // Start Constructor: Cat
			super(manager, idleClip, scale, 1);
			_controls = controls;
			_hasMeter = true;
		} // End Constructor: Cat
		
		
		
		// Override Public Methods
		override public function init():void {   // Start Method: init
			super.init();
			updateEnergyMeter();
		} // End Method: init
		
		override public function update():void {   // Start Method: update
			super.update();
			updateFall();
			
			// As long as a player has energy, allow the controls and allow to update the X- and Y-coordinates
			if (hasEnergy) {
				updateControls();
				updateX();
				updateY();
			}
			
			// If the player has immunity on, decrease it. Should be decreased with 1 each method call, which should result in 60 with each second
			if (_immune > 0)
				_immune--;
		} // End Method: update
		
		
		
		// Public Methods
		public function getHit(value:uint):void {   // Start Method: getHit
			// When the player gets hit by an enemy or obstacle
			if (value > 0 && _immune == 0) {						// If the hit value is positive and the player has no immunity
				setEnergy(-value, true);							// Subtract the energy and update the energy bar
				_immune = 120;										// Set the immune value to 120, which result result in 2 seconds of immunity (1 subtracted each frame, 120 - (1 * 60 * 2) = 0) 
				if (hasEnergy) {									// If the player has still energy left, play a sound and set an animation
					playSound(_sndGetHit, getHitSoundVolume);
					_activeAnimation = "Hit";
					replaceMovieClip(hitClip, scale, 1, false);
				}
				// Add a flicker effect to the movieclip used by the class, so that the life bar is not affected, use the immunity value for the duration (round it whole to avoid crashes)
				Session.effects.add(new Flicker(_movieClip, Math.ceil(_immune * (100/6)), 30, true));
			}
		} // End Method: getHit
		
		public function restore(value:uint):void {   // Start Method: restore
			if (value > 0) {
				setEnergy(value, true);
				playSound(_sndRestore, 1);
			}
		} // End Method: restore
		
		
		
		// Protected Methods
		override protected function remainWithinScreenHeight():void {   // Start Method: remainWithinScreenHeight
			if (y <= height + 80)
				y = height + 80;
			else if (y > Session.application.size.y - height/2 && hasEnergy) {
				_descentValue = 0;
				jump();
			}
		} // End Method: remainWithinScreenHeight
		
		
		
		// Private Methods
		private function shoot():void {   // Start Method: shoot
			// Check the amount of arrows on screen per player before shooting an arrow
			var limit = 0;
			for (var i=0; i<_manager.arrows.length; i++)
				if (_manager.arrows.list[i].player == _controls.player)
					limit++;
			
			// Only allow a total of 10 arrows per player at once
			if (limit == 10)
				return;
			
			// If the cooldown is finished, set the animation, play a sound, add an arrow and set a short cooldown on when being able to shoot again
			if (!_arrowCooldown) {
				_activeAnimation = "Shoot";
				playSound(_sndShoot, 1);
				_arrowCooldown = true;
				_manager.arrows.add(self);
				Session.timer.create(100, function():void {_arrowCooldown = false; } );
			}
		} // End Method: shoot
		
		private function updateFall():void {   // Start Method: updateFall
			// As long the player has energy left, slowly fall down. If the player is dead, fall down much faster
			if (hasEnergy)
				y += 0.35;
			else y += 4;
			
			// If the player has no energy and should be dead, replace the animation and play a sound
			if (!hasEnergy && !_dead) {
				_dead = true;
				playSound(_sndDead, deadSoundVolume);
				replaceMovieClip(fallingClip, scale, 1, true);
			}
		} // End Method: updateFall
		
		private function updateX():void {   // Start Method: updateX
			// Updating the X position of the player
			var nextXSpeed:Number = Math.random() / 5;				// Determine the next speed the player will automatically move with, althrough slightly
			if (_moveForwards) {									// When the player should automatically move forward
				x += nextXSpeed;
				_trackX += nextXSpeed;
				if (_trackX > 20)									// The player moved forward automatically enough, time to go backward again
					_moveForwards = false;
			}
			else {
				x -= nextXSpeed;
				_trackX -= nextXSpeed;
				if (_trackX < 0)
					_moveForwards = true;						// The player moved backward automatically enough, time to go forward again
			}
			
			// The player should remain on-screen, so don't go back outside the screen. Neither should the player go further than 1/3 of the width of the screen and a bit extra
			if (x < width)
				x = width;
			else if (x > stage.stageWidth/3 + 60)
				x = stage.stageWidth/3 + 60;
		} // End Method: updateX
		
		private function updateY():void {   // Start Method: updateY
			// When jumping or descending, update the height
			if (_jumpValue > 0) {									// When jumping, go higher, gradually stop jumping
				y -= 4;
				_jumpValue--;
			}
			
			if (_descentValue < 0) {								// When descending, go lower, gradually stop descending
				y += 6;
				_descentValue++;
			}
		} // End Method: updateY
		
		private function updateControls():void {   // Start Method: updateControls
			// Control input for the player, start by simplying the keyboard controls
			const LEFT:Boolean = Input.keyboard.pressed(_controls.PLAYER_LEFT);
			const RIGHT:Boolean = Input.keyboard.pressed(_controls.PLAYER_RIGHT);
			const DOWN:Boolean = Input.keyboard.pressed(_controls.PLAYER_DOWN);
			const BUTTON_1:Boolean = Input.keyboard.justPressed(_controls.PLAYER_BUTTON_1);
			const BUTTON_2:Boolean = Input.keyboard.justPressed(_controls.PLAYER_BUTTON_2);
			
			// Checking if a specific animation should be used
			if (_descentValue == 0 && _jumpValue == 0 && !isShootClip && !isHitClip)
				_activeAnimation = "Idle";
			else if (!_controller.isPlaying)
				_activeAnimation = "Idle";
			else if (_forward)
				setAnimation("Forward");
			else if (_backward)
				setAnimation("Backward");
			
			// When pressing the button to shoot, shoot
			if (BUTTON_2)
				shoot();
			
			// When pressing the button to jump, jump
			if (BUTTON_1)
				jump();
			
			// When holding the joystick down, go down, but only if the player is not going down already and is not too low at the bottom of the screen
			if (y < Session.application.size.y - height/2 - 20 && DOWN && _descentValue == 0) {
				_descentValue -= 2;
				if (_activeAnimation != "Shoot" && _activeAnimation != "Hit" && _activeAnimation != "Up")
					_activeAnimation = "Down";
			}
			
			// When holding the joystick to the left, go left
			if (LEFT) {
				x -= 4;
				setAnimation("Backward");
				_backward = true;
			}
			else _backward = false;
			
			// When holding the joystick to the right, go right
			if (RIGHT) {
				x += 4;
				setAnimation("Forward");
				_forward = true;
			}
			else _forward = false;
			
			replaceAnimation(_activeAnimation);						// Call the method to replace the animation to be used
		} // End Method: updateControls
		
		private function jump():void {   // Start Method: jump
			// Only allow to jump if the playing is not jumping already
			if (_jumpValue > 0)
				return;
			
			// Jumping takes a bit energy, replaces the animation (if not shooting), plays a sound effect and will gradually allow the player to gain height
			setEnergy(-3, true);
			_jumpValue += 25;
			playSound(_sndJump, 0.65);
			if (_activeAnimation != "Shoot")
				_activeAnimation = "Up";
		} // End Method: jump
		
		private function replaceAnimation(animation:String):void {   // Start Method: replaceAnimation
			// Replace the animation
			if (animation == "Up")
				replaceMovieClip(upClip, scale, 1, true);
			else if (animation == "Down")
				replaceMovieClip(downClip, scale, 1, true);
			else if (animation == "Forward")
				replaceMovieClip(forwardClip, scale, 1, true);
			else if (animation == "Backward")
				replaceMovieClip(backwardClip, scale, 1, true);
			else if (animation == "Shoot")
				replaceMovieClip(shootClip, scale, 1, false);
			else if (animation == "Idle")
				replaceMovieClip(idleClip, scale, 1, true);
			
			// Re-apply the flicker effect again if the player is still immune during an animation change, since a new movieclip loses the flicker effect
			if (_immune > 0)
				Session.effects.add(new Flicker(_movieClip, Math.ceil(_immune * (100/6)), 30, true));
		} // End Method: replaceAnimation
		
		private function setAnimation(animation:String):void {   // Start Method: setAnimation
			if (_activeAnimation == "Idle")
				_activeAnimation = animation;
		} // End Method: setAnimation
		
	} // End Class: Cat
	
} // End Package