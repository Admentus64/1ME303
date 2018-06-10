/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package manager {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	import se.lnu.stickossdk.media.SoundObject;
	
	// Flash Imports
	import flash.utils.getQualifiedClassName;
	import flash.display.Sprite;
	
	// Project Imports
	import state.GameState;
	import object.Entity;
	
	
	
	public class EntityManager extends DisplayStateLayerSprite implements EntityManagerInterface {   // Start Class: EntityManager
		
		// Getters
		public function get list():Vector.<*>						{ return _objects; }				// Get: list
		public function get length():int							{ return _objects.length; }			// Get: length
		public function get sound():Boolean							{ return _state.sound; }			// Get: sound
		public function get layer():Sprite							{ return _state.layerList[1]; }		// Get: layer
		public function get seconds():uint							{ return _state.counter.seconds; }	// Get: seconds
		
		
		
		// Protected Variables
		protected const self = this;
		protected var _objects = null;
		protected var _state:GameState = null;
		
		
		
		public function EntityManager(state:GameState) {   // Start Constructor: EntityManager
			_state = state;
			_state.primaryLayer.addChild(this);
		} // End Constructor: EntityManager
		
		
		
		// Override Public Methods
		override public function dispose():void	{   // Start Method: dispose
			trace("DISPOSE: " +  getQualifiedClassName(this).slice(getQualifiedClassName(this).lastIndexOf("::") + 2));	
			
			_state.primaryLayer.removeChild(this);
			
			for (var i=0; i<_objects.length; i++)
				remove(_objects[i]);
			
			_objects = null;
			_state = null;
		} // End Method: dispose
		
		
		
		// Public Methods
		public function indexOf(entity:Entity):uint					{ return _objects.indexOf(entity, 0); }   // Method: indexOf
		
		public function remove(index:uint):void {   // Start Method: remove
			// Can't remove an entity which is outside the vector
			if (index < 0 || index > _objects.length)
				return;
			
			// Dispose and remove the entity from the vector
			_objects[index].dispose();
			_objects.splice(indexOf(_objects[index]), 1);
		} // End Method: remove
		
		
		
		// Protected Methods
		protected function setRandomTimerDuration(minTime:uint, randomTime:uint, func:Function) {   // Start Method: setRandomTimerDuration
			// For setting a random timer duration, with a minimum duration. First check if the random and minimum durations are above or equal to 0
			if (minTime <= 0)
				minTime = 1;
			if (randomTime < 0)
				randomTime = 0;
			
			// Get a random value rounded to the nearest whole number, then create a timer with it
			var rand = Math.round(Math.random() * randomTime + minTime);
			Session.timer.create(rand, func);
		} // End Method: setRandomTimerDuration
		
		protected function playSound(soundObject:SoundObject, volume:Number) {   // Start Method: playSound
			// Play a sound effect if sound is enabled
			if (sound) {
				soundObject.play();
				soundObject.volume = volume;
			}
		} // End Method: playSound
		
		protected function push(entity:Entity):* {   // Start Method: push
			// Add an entity to the vector
			entity.list.push(entity);
			return entity;
		} // End Method: push
		
	} // End Class: EntityManager
	
} // End Package