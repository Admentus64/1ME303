/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package manager {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.media.SoundObject;
	
	// Flash Imports
	import flash.display.Sprite;
	
	// Project Imports
	import state.GameState;
	import object.powerup.Powerup;
	import object.powerup.Fish;
	import object.powerup.DoubleDamage;
	import object.powerup.DoubleScore;
	import object.powerup.Cape;
	
	
	
	public class PowerupManager extends EntityManager {   // Start Class: PowerupManager
		
		// Getters
		override public function get layer():Sprite					{ return _state.layerList[2]; }			// Get: layer
		public function get doubleDamage():Boolean					{ return DoubleDamage.active; }			// Get: doubleDamage
		public function get doubleScore():Boolean					{ return DoubleScore.active; }			// Get: doubleScore
		public function get doubleDamageDuration():uint				{ return DoubleDamage.duration; }		// Get: doubleDamageDuration
		public function get doubleScoreDuration():uint				{ return DoubleScore.duration; }		// Get: doubleScoreDuration
		public function get doubleDamageMaxDuration():uint			{ return DoubleDamage.maxDuration; }	// Get: doubleDamageMaxDuration
		public function get doubleScoreMaxDuration():uint			{ return DoubleScore.maxDuration; }		// Get: doubleScoreMaxDuration
		
		private function get randomAddValue():uint {   // Start Get: randomAddValue
			// Select a random value used to pick the type of powerup based on the game duration
			if (seconds < 15)
				return Math.floor(Math.random()*15);
			else if (seconds < 45)
				return Math.floor(Math.random()*25);
			return Math.floor(Math.random()*20 + 5);
		} // End Get: randomAddValue
		
		
		
		// Private Constant Variables
		private const _sndPowerup:SoundObject = Session.sound.soundChannel.get("Powerup Activate");
		private const _sndBackToLife:SoundObject = Session.sound.soundChannel.get("Back To Life");
		
		
		
		public function PowerupManager(state:GameState) {   // Start Constructor: PowerupManager
			super(state);
			_objects = new Vector.<Powerup>();
			 Session.timer.create(1000, function():void { add(); });
			 
			 Session.timer.create(5000, function():void { push(new DoubleDamage(self)); });
			 Session.timer.create(10000, function():void { push(new DoubleScore(self)); });
		} // End Constructor: PowerupManager
		
		
		
		// Override Public Methods
		override public function update():void	{   // Start Method: update
			DoubleDamage.decrement();
			DoubleScore.decrement();
		} // End Method: update
		
		
		
		// Public Methods
		public function add():void {   // Start Method: add
			const rand:uint = randomAddValue;
			
			// Add an powerup type to the game field based on the picked random value
			if (rand < 15)																		// Between 0 and 14 -> Fish
				push(new Fish(this));
			else if (rand >= 15 && rand < 25 && _state.coop && _state.players.length == 1)		// Between 15 and 24 -> Cape (only when one player is alive in co-op mode, replaced other powerups)
				push(new Cape(this));
			else if (rand >= 15 && rand < 20 && doubleScore)									// Between 15 and 19 -> Fish (only if Double Score Powerup is active)
				push(new Fish(this));
			else if (rand >= 15 && rand < 20)													// Between 15 and 19 -> Double Score Powerup
				push(new DoubleScore(this));
			else if (doubleDamage)																// 20 or higher -> Fish (only if Double Damage Powerup is active)
				push(new Fish(this));
			else push(new DoubleDamage(this));													// 20 or higher -> Double Score Powerup
			
			setSecondsBasedRandomTimer();
		} // End Method: add
		
		public function activate(entity:Powerup):void {   // Start Method: activate
			entity.activate();
			playSound(_sndPowerup, 0.7);
		} // End Method: activate
		
		public function restorePlayers():void {   // Start Method: restorePlayers
			playSound(_sndBackToLife, 1);							// Play a Revive sound effect
			
			// Don't continue if both players are already alive, or if the co-op is disabled
			if (!_state.coop || _state.players.length == 2)
				return;
			
			// Check the control scheme of that player that is alive, give the player that is to be revived the control scheme of the other player
			if (_state.players.list[0].controls.player == 0)
				_state.players.restore(1);
			else _state.players.restore(0);
		} // End Method: restorePlayers
		
		
		
		// Private Methods
		private function setSecondsBasedRandomTimer():void {   // Start Method: setSecondsBasedRandomTimer
			// Set the next timer when a new powerup should spawn. The first value is the time that is randomized, the second value is the minimum time. The time get reduced as the game duration goes on
			if (seconds < 30)
				setRandomTimerDuration(4000, 11000, function():void { add(); });
			else if (seconds < 60)
				setRandomTimerDuration(5000, 10000, function():void { add(); });
			else if (seconds < 90)
				setRandomTimerDuration(6000, 9000, function():void { add(); });
			else if (seconds < 120)
				setRandomTimerDuration(7000, 8000, function():void { add(); });
			else if (seconds < 150)
				setRandomTimerDuration(8000, 7000, function():void { add(); });
			else if (seconds < 180)
				setRandomTimerDuration(9000, 6000, function():void { add(); });
			else setRandomTimerDuration(10000, 5000, function():void { add(); });
		} // End Method: setSecondsBasedRandomTimer
		
	} // End Class: PowerupManager
	
} // End Package