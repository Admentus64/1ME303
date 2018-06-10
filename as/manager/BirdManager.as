/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package manager {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	
	// Flash Imports
	import flash.display.Sprite;
	
	// Project Imports
	import state.GameState;
	import object.Entity;
	import object.player.Cat;
	import object.bird.Bird;
	import object.bird.BirdAngry;
	import object.bird.BirdAirplane;
	import object.bird.BirdRainCloud;
	import object.bird.BirdThunderCloud;
	import object.obstacle.Bullet;
	import object.obstacle.Thunder;
	
	
	
	public class BirdManager extends EntityManager {   // Start Class: BirdManager
		
		// Getters
		override public function get layer():Sprite					{ return _state.layerList[2]; }				// Get: layer
		
		public function get doubleDamage():Boolean	{ // Start Get: doubleDamage
			if (_state.powerups == null)
				return false;
			return _state.powerups.doubleDamage;
		} // End Get: doubleDamage
		
		private function get randomAddValue():uint {   // Start Get: randomAddValue
			// Select a random value used to pick the type of enemy based on the game duration
			if (seconds < 15)
				return Math.floor(Math.random()*15);
			else if (seconds < 35)
				return Math.floor(Math.random()*13 + 2);
			else if (seconds < 55)
				return Math.floor(Math.random()*17 + 3);
			else if (seconds < 70)
				return Math.floor(Math.random()*21 + 4);
			else if (seconds < 85)
				return Math.floor(Math.random()*25 + 5);
			else if (seconds < 100)
				return Math.floor(Math.random()*30 + 5);
			else if (seconds < 120)
				return Math.floor(Math.random()*35 + 5);
			return Math.floor(Math.random()*35);
		} // End Get: randomAddValue
		
		
		
		public function BirdManager(state:GameState) {   // Start Constructor: BirdManager
			super(state);
			_objects = new Vector.<Bird>();
			Session.timer.create(1000, function():void { add(); });
		} // End Constructor: BirdManager
		
		
		
		// Public Methods
		public function shoot(bird:Bird) { push(new Bullet(_state.obstacles, bird)); }   // Method: shoot
		
		public function add():void {   // Start Method: add
			const rand:uint = randomAddValue;
			
			// Add an enemy type to the game field based on the picked random value
			if (rand < 15)											// Between 0 and 14 -> Angry Bird
				push(new BirdAngry(this, getTarget()));
			else if (rand >= 15 && rand < 20)						// Between 15 and 19 -> Bird in Airplane
				push(new BirdAirplane(this));
			else if (rand >= 20 && rand < 25)						// Between 20 and 24 -> Bird on Rain Cloud
				push(new BirdRainCloud(this));
			else if (rand >= 25 && rand < 30)						// Between 25 and 29 -> Bird on Thunder Cloud
				addBirdThunderCloud();
			else addVFormGroup();									// 30 or higher -> Group of Angry Birds
			
			setSecondsBasedRandomTimer();
		} // End Method: add
		
		public function addScore(bird:Bird):void {   // Start Method: addScore
			// Add the score from the defeated enemy to the score counter
			if (_state.powerups.doubleScore)
				_state.addScore(bird.score * 2);
			else _state.addScore(bird.score);
		} // End Method: addScore
		
		
		
		// Private Methods
		private function setSecondsBasedRandomTimer():void {   // Start Method: setSecondsBasedRandomTimer
			// In coop mode a different timer set should be used, one that is faster that results into more enemies
			if (_state.coop)
				setSecondsBasedRandomTimerCoop();
			else setSecondsBasedRandomTimerSolo();
		} // End Method: setSecondsBasedRandomTimer
		
		private function setSecondsBasedRandomTimerSolo():void {   // Start Method: setSecondsBasedRandomTimerSolo
			// Set the next timer when a new enemy should spawn. The first value is the time that is randomized, the second value is the minimum time. The time get reduced as the game duration goes on
			if (seconds < 10)
				setRandomTimerDuration(4000, 5500, function():void { add(); });
			else if (seconds < 20)
				setRandomTimerDuration(3750, 5500, function():void { add(); });
			else if (seconds < 30)
				setRandomTimerDuration(3500, 5500, function():void { add(); });
			else if (seconds < 40)
				setRandomTimerDuration(3000, 5500, function():void { add(); });
			else if (seconds < 50)
				setRandomTimerDuration(2500, 5500, function():void { add(); });
			else if (seconds < 60)
				setRandomTimerDuration(2000, 5000, function():void { add(); });
			else if (seconds < 70)
				setRandomTimerDuration(1500, 4500, function():void { add(); });
			else if (seconds < 80)
				setRandomTimerDuration(1500, 3500, function():void { add(); });
			else if (seconds < 90)
				setRandomTimerDuration(1500, 2500, function():void { add(); });
			else setRandomTimerDuration(1000, 1500, function():void { add(); });
		} // End Method: setSecondsBasedRandomTimerSolo
		
		private function setSecondsBasedRandomTimerCoop():void {   // Start Method: setSecondsBasedRandomTimerCoop
			// Set the next timer when a new enemy should spawn. The first value is the time that is randomized, the second value is the minimum time. The time get reduced as the game duration goes on
			if (seconds < 10)
				setRandomTimerDuration(4000, 4000, function():void { add(); });
			else if (seconds < 20)
				setRandomTimerDuration(3750, 4000, function():void { add(); });
			else if (seconds < 30)
				setRandomTimerDuration(3500, 3500, function():void { add(); });
			else if (seconds < 40)
				setRandomTimerDuration(3000, 3500, function():void { add(); });
			else if (seconds < 50)
				setRandomTimerDuration(2500, 3000, function():void { add(); });
			else if (seconds < 60)
				setRandomTimerDuration(2000, 3000, function():void { add(); });
			else if (seconds < 70)
				setRandomTimerDuration(1500, 3000, function():void { add(); });
			else if (seconds < 80)
				setRandomTimerDuration(1500, 2500, function():void { add(); });
			else if (seconds < 90)
				setRandomTimerDuration(1500, 2000, function():void { add(); });
			else setRandomTimerDuration(1000, 1500, function():void { add(); });
		} // End Method: setSecondsBasedRandomTimerCoop
			
		private function addBirdThunderCloud() {   // Start Method: addBirdThunderCloud
			var entity:Bird = push(new BirdThunderCloud(this));
			push(new Thunder(_state.obstacles, entity));
		} // End Method: addBirdThunderCloud
		
		private function addVFormGroup() {   // Start Method: addVFormGroup
			// Get a target, assign it to a new angry bird that is appointed as the group's leader and add two followers to it (one on the top and one on the bottom)
			var target:Cat = getTarget();
			var entity:Bird = push(new BirdAngry(this, target));
			push(new BirdAngry(this, target, entity, true));
			push(new BirdAngry(this, target, entity, false));
		} // End Method: addVFormGroup
		
		private function getTarget():Cat {   // Start Method: getTarget
			// Get a target to go after. In solo mode just pick the only player, in coop mode randomly pick a player (if both are alive, otherwise pick the player that is left alive)
			if (_state.players.length == 2)
				return _state.players.list[Math.round(Math.random())];
			else if (_state.players.length == 1)
				return _state.players.list[0];
			return null;
		} // End Method: getTarget
		
	} // End Class: BirdManager
	
} // End Package