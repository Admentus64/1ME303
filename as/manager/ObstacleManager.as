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
	import object.obstacle.Obstacle;
	import object.obstacle.Mountain;
	import object.obstacle.RainCloud;
	import object.obstacle.Thunder;
	import object.obstacle.ThunderCloud;
	
	
	
	public class ObstacleManager extends EntityManager {   // Start Class: ObstacleManager
		
		// Getters
		override public function get layer():Sprite					{ return _state.layerList[1]; }   // Get: layer
		
		private function get randomAddValue():uint {   // Start Get: randomAddValue
			// Select a random value used to pick the type of obstacle based on the game duration
			if (seconds < 30)
				return Math.floor(Math.random()*10);
			else if (seconds < 60)
				return Math.floor(Math.random()*15);
			else if (seconds < 90)
				return Math.floor(Math.random()*20);
			else if (seconds < 120)
				return Math.floor(Math.random()*25);
			else if (seconds < 150)
				return Math.floor(Math.random()*30);
			else if (seconds < 180)
				return Math.floor(Math.random()*30);
			return Math.floor(Math.random()*30);
		} // End Get: randomAddValue
		
		
		
		public function ObstacleManager(state:GameState) {   // Start Constructor: ObstacleManager
			super(state);
			_objects = new Vector.<Obstacle>();
			Session.timer.create(1000, function():void { addCloud(); });
			Session.timer.create(1000, function():void { addMountain(); });
		} // End Constructor: ObstacleManager
		
		
		
		// Public Methods
		public function addCloud():void {   // Start Method: addCloud
			const rand:uint = randomAddValue;
			
			// Add a cloud obstacle to the game field based on the picked random value
			if (rand < 20)											// Between 0 and 19 -> Rain Cloud
				 push(new RainCloud(this));
			else addThunderCloud();									// 20 or higher -> Thunder CLoud
			
			setSecondsBasedRandomTimer(addCloud);
		} // End Method: addCloud
		
		public function addMountain():void {   // Start Method: addMountain
			const rand:uint = randomAddValue;
			
			// Add an mountain obstacle to the game field based on the picked random value
			if (rand < 15)											// Between 10 and 14 -> Small Mountain
				push(new Mountain(this, 1));
			else if (rand >= 15 && rand < 25)						// Between 15 and 24 -> Medium Mountain
				 push(new Mountain(this, 1.75));
			else push(new Mountain(this, 2.125));					// 25 or higher -> Large Mountain
			
			setSecondsBasedRandomTimer(addMountain);
		} // End Method: addMountain
		
		
		
		// Private Methods
		private function setSecondsBasedRandomTimer(func:Function):void {   // Start Method: setSecondsBasedRandomTimer
			// Set the next timer when a new obstacle should spawn. The first value is the time that is randomized, the second value is the minimum time. The time get reduced as the game duration goes on
			if (seconds < 15)
				setRandomTimerDuration(12000, 12000, function():void { func(); });
			else if (seconds < 30)
				setRandomTimerDuration(11000, 12000, function():void { func(); });
			else if (seconds < 60)
				setRandomTimerDuration(10000, 12000, function():void { func(); });
			else if (seconds < 90)
				setRandomTimerDuration(10000, 11000, function():void { func(); });
			else if (seconds < 120)
				setRandomTimerDuration(10000, 10500, function():void { func(); });
			else if (seconds < 150)
				setRandomTimerDuration(10000, 10250, function():void { func(); });
			else setRandomTimerDuration(10000, 10000, function():void { func(); });
		} // End Method: setSecondsBasedRandomTimer
		
		private function addThunderCloud():void {   // Start Method: addThunderCloud
			// Create a new Thunder Cloud entity and add a Thunder to it that is following the Thunder Cloud
			var entity:Obstacle = push(new ThunderCloud(this));
			push(new Thunder(this, entity));
		} // End Method: addThunderCloud
		
	} // End Class: ObstacleManager
	
} // End Package