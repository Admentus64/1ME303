/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.media.SoundObject;
	
	// Flash Imports
	import flash.utils.getQualifiedClassName;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	// Project Imports
	import util.MovieClipController;
	import manager.EntityManager;
	
	
	
	public class Entity extends DisplayStateLayerSprite implements EntityInterface {   // Start Class: Entity
		
		// Getters
		public function get energy():Number						{ return _energy; }			// Get: energy
		public function get hasEnergy():Boolean					{ return _energy > 0; }		// Get: hasEnergy
		public function get sound():Boolean						{ return _manager.sound; }	// Get: sound
		public function get manager():EntityManager				{ return _manager; }		// Get: manager
		public function get list():Vector.<*>					{ return _manager.list; }	// Get: list
		
		public function get layer():Sprite						{ return _manager.layer; }	// Get: layer
		public function get speed():Number						{ return _speed; }			// Get: speed
		protected function get scale():Number					{ return 1; }				// Get: scale
		
		
		
		// Protected Variables
		protected const self = this;
		protected const _maxEnergy:Number = 100;
		protected var _energy:Number = _maxEnergy;
		protected var _hasMeter:Boolean = false;
		protected var _pushBack:Number = 0;
		protected var _yPush:Boolean = true;
		protected var _manager:* = null;
		protected var _speed:Number = 2;
		protected var _movieClip:MovieClip = null;
		protected var _controller:MovieClipController = null;
		
		
		
		public function Entity(manager:EntityManager, movieClip:MovieClip, movieScale:Number, movieSpeed:Number) {   // Start Constructor: Entity
			_manager = manager;
			setMovieClip(movieClip, movieScale, movieSpeed, true);
			layer.addChild(self);
		} // End Constructor: Entity
		
		
		
		// Override Public Methods
		override public function update():void {   // Start Method: update
			super.update();
			
			// Every entity should be checked if it should be pushed back, that it sh
			checkToPushBack();
			remainWithinScreenHeight();
			checkOutOfScreen();
		} // End Method: update
		
		override public function dispose():void	{   // Start Method: dispose
			trace("DISPOSE: " +  getQualifiedClassName(self).slice(getQualifiedClassName(self).lastIndexOf("::") + 2));
			layer.removeChild(self);
			removeChild(_movieClip);
		} // End Method: dispose
		
		
		
		// Public Methods
		public function pushBack(pushBack:Number, yPush:Boolean=true):void {   // Start Method: pushBack
			// Allow the entity to be pushed back if it is not being pushed already. The x-position should always be pushed, but the y-position is not required
			if (_pushBack == 0) {
				_pushBack = pushBack;
				_yPush = yPush;
			}
		} // End Method: pushBack
		
		public function setEnergy(value:int, relative:Boolean):void {   // Start Method: setEnergy
			// Set the energy of an entity to a specific value (absolute) or add a specific value to the energy (relative)
			if (relative)
				_energy += value;
			else _energy = value
			
			// Energy should not be higher than 100 for every entity, set it to 100 if so. Similarly, energy should not be lower than 0 for every entity, set it to 0 is so.
			if (_energy > _maxEnergy)
				_energy = _maxEnergy;
			else if (_energy < 0)
				_energy = 0;
			
			// If the entity has an energy meter, update that as well
			if (_hasMeter)
				updateEnergyMeter();
		} // End Method: setEnergy
		
		public function collide(entity:Entity):Boolean {   // Start Method: collide
			// Simplify the position variables of the entity to be checked against
			var eX1 = entity.x - entity.width/2;
			var eX2 = entity.x + entity.width/2;
			var eY1 = entity.y - entity.height/2;
			var eY2 = entity.y + entity.height/2;
			
			// Simplify the position variables of the entity itself
			var x1 = x - width/2;
			var x2 = x + width/2;
			var y1 = y - height/2;
			var y2 = y + height/2;
			
			// Check if the entity itself collides into the position of the entity it is being check against
			if (eX1 <= x2 && eX2 >= x1 && eY1 <= y2 && eY2 >= y1)
				return true;
			return false;
		} // End Method: collide
		
		
		
		// Protected Methods
		protected function moveToLeft():void				{ x -= _speed; }   // Method: moveToLeft
		
		protected function checkOutOfScreen():void {   // Start Method: checkOutOfScreen
			// If the entity is outside the screen then remove it. Allows objects entering or exiting on the left or right side of the screen to exist a little further
			if (y < -width || y > Session.application.size.y + height + 10 || x < -width - 100 || x > Session.application.size.x + width + 100)
				_manager.remove(_manager.indexOf(self));
		} // End Method: checkOutOfScreen
		
		protected function remainWithinScreenHeight():void {   // Start Method: remainWithinScreenHeight
			// Limit the height an entity can remain on. Set a maximum on the height it can achieve. Only allow an entity to exit the screen on the bottom if it has no energy left anymore
			if (y <= height + 80)
				y = height + 80;
			else if (y > Session.application.size.y - height/3 && hasEnergy)
				y = Session.application.size.y - height/3
		} // End Method: remainWithinScreenHeight
		
		protected function replaceMovieClip(movieClip:MovieClip, movieScale:Number, movieSpeed:Number, movieLoop:Boolean):void {   // Start Method: replaceMovieClip
			// Replacing a MovieClip for an entity to display, only allow to replace it if it is a different MovieClip or if the same MovieClip that stopped playing
			if (movieClip.toString() == _movieClip.toString() && (_controller.isPlaying))
				return;
			// Remove the current MovieClip and add another MovieClip in it's place
			removeChild(_movieClip);
			setMovieClip(movieClip, movieScale, movieSpeed, movieLoop);
		} // End Method: replaceMovieClip
		
		protected function setToOffScreen():void {   // Start Method: setToOffScreen
			// Spawns an entity just outside the screen on the right and assign it a random height within the available screen space
			x = stage.stageWidth + width;
			y = Math.random() * (stage.stageHeight - width * 3 - 80) + width + 80;
		} // End Method: setToOffScreen
		
		protected function playSound(soundObject:SoundObject, volume:Number) {   // Start Method: playSound
			// Play a sound effect if sound is enabled
			if (sound) {
				soundObject.play();
				soundObject.volume = volume;
			}
		} // End Method: playSound
		
		protected function updateEnergyMeter():void {   // Start Method: updateEnergy
			// Draw the energy meter using graphics call, but first start by clearing the drawed graphics
			graphics.clear();
			
			// Only draw a graphics when the entity still has energy
			if (!hasEnergy)
				return;
			
			// Use the width and height of the MovieClip rather than the entity itself to determine the size and position of the energy meter
			var width = _movieClip.width;
			var height = _movieClip.height;
			
			// Draw the border of the energy meter
			graphics.beginFill(0x808080);
			graphics.drawRect(-(width/2)-4, -(height)-4, width+8, 15+8);
			graphics.endFill();
			
			// Draw the black void of the energy meter, representing the lost energy
			graphics.beginFill(0x000000);
			graphics.drawRect(-(width/2), -(height), width, 15);
			graphics.endFill();
			
			// Set a color for representing the health that is left, starting by using a maximum green color value and gradually lower the green value and increase the red value to the maximum value
			var color:Array = new Array(0, 0, 0, 0);
			color[0] = 255 - Math.ceil(255*_energy/_maxEnergy);
			color[1] = 0 + Math.ceil(255*_energy/_maxEnergy);
			color[2] = 0;
			color[3] = 256*256*color[0] + 256*color[1] + color[2];
			
			// Draw the energy that is left using the color determined above
			if (_energy > 0) {
				graphics.beginFill(color[3]);
				graphics.drawRect(-(width/2), -(height), _energy/_maxEnergy*width, 15);
				graphics.endFill();
			}
			
			// Cache the energy meter as a bitmap
			cacheAsBitmap = true;
		} // End Method: updateEnergy
		
		
		
		// Private Methods
		private function setMovieClip(movieClip:MovieClip, movieScale:Number, movieSpeed:Number, movieLoop:Boolean):void {   // Start Method: setMovieClip
			// Adding the MovieClip to the entity
			_movieClip = movieClip;
			addChild(_movieClip);											// Add it
			_movieClip.scaleX = _movieClip.scaleY = movieScale;				// Set the scale
			_controller = new MovieClipController(_movieClip, movieLoop);	// Link it to a MovieClipController in order to set the animation speed and if it should loop
			_controller.play(movieSpeed);									// Set the animation speed
		} // End Method: setMovieClip
		
		private function checkToPushBack():void {   // Start Method: checkToPushBack
			// Pushing back the entity gradually if it should be pushed back
			if (_pushBack > 0) {									// Pushing forward
				_pushBack--;
				x++;
				if (_yPush)											// If the height should also be pushed
					y++;
				if (_pushBack < 0)
					_pushBack = 0;
			}
			else if (_pushBack < 0) {								// Pushing backward
				_pushBack++;
				x--;
				if (_yPush)											// If the height should also be pushed
					y--;
				if (_pushBack > 0)
					_pushBack = 0;
			}
		} // End Method: checkToPushBack
		
	} // End Class: Entity
	
} // End Package