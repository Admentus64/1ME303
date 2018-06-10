/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package state {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.input.Input;
	
	// Project Imports
	import asset.screen.GameBackgroundClip;
	import object.Entity;
	import object.player.Cat;
	import object.player.Arrow;
	import object.powerup.Powerup;
	import object.powerup.Fish;
	import object.powerup.DoubleDamage;
	import object.powerup.DoubleScore;
	import object.powerup.Cape;
	import object.bird.Bird;
	import object.bird.BirdAngry;
	import object.obstacle.Obstacle;
	import object.obstacle.Mountain;
	import manager.EntityManager;
	import manager.PlayerManager;
	import manager.PowerupManager;
	import manager.BirdManager;
	import manager.ObstacleManager;
	import util.Counter;
	import util.GameSounds;
	import display.Hud;
	
	
	
	public class GameState extends ScreenState {   // Start Class: GameState
		
		// Getters
		public function get players():PlayerManager					{ return _players; }	// Get: players
		public function get powerups():PowerupManager				{ return _powerups; }	// Get: powerups
		public function get birds():BirdManager						{ return _birds; }		// Get: birds
		public function get obstacles():ObstacleManager				{ return _obstacles; }	// Get: obstacles
		public function get coop():Boolean							{ return _coop; }		// Get: coop
		public function get hud():Hud								{ return _hud; }		// Get: hud
		public function get counter():Counter						{ return _counter; }	// Get: counter
		
		
		
		// Private Variables
		private var _players:PlayerManager = null;
		private var _powerups:PowerupManager = null;
		private var _birds:BirdManager = null;
		private var _obstacles:ObstacleManager = null;
		private var _coop:Boolean = false;
		private var _gameOver = false;
		private var _counter:Counter = null;
		private var _hud:Hud = null;
		private var _gameSounds = null;
		
		// Embeddings
		[Embed(source = "../../asset/music/musicGame.mp3")]			private static const MUSIC:Class;
		
		
		
		public function GameState(coop:Boolean, sound:Boolean=true, music:Boolean=true) {   // Start Constructor: GameState
			super(sound, music);
			_coop = coop;
		} // End Constructor: GameState
		
		
		
		// Override Public Methods
		override public function init():void {   // Start Method: init
			super.init();
			
			primaryLayer.addChild(new GameBackgroundClip);
			
			// Add three more layers.
			for (var i=0; i<3; i++)
				_gameLayers.push(layers.add(LAYER_OBJECTS));
			
			// Adding the counter for the score and time and the hud
			_counter = new Counter(this);
			_hud = new Hud(this);
			
			// Adding all sound effects and add the music
			_gameSounds = new GameSounds(_coop);
			if (music)
				initMusic("Game", MUSIC);
			
			initObjectManagers();
		} // End Method: init
		
		override public function update():void {   // Start Method: update
			super.update();
			
			// DEBUG
			if (Input.keyboard.justPressed("SPACE"))
				gameOver();
			
			if (_gameOver)
				return;
			
			// As long the game is not over, keep looping the music, keep checking for occuring collisions and check if the game should end
			loopMusic(0.4);
			checkCollisions();
			checkGameOver();
		} // End Method: update
		
		override public function dispose():void {   // Start Method: dispose
			super.dispose();
			_gameSounds.clear();
			_gameSounds = null;
		} // End Method: dispose
		
		
		
		// Public Methods
		public function addScore(score:uint)						{ _counter.score += score; }   // Method: addScore
		
		
		
		// Private Methods
		private function goToGameOverState(score):void				{ Session.application.displayState = new GameOverState(_coop, score, sound, music); }   // Method: goToGameOverState
		
		private function removeObjectManagers():void {   // Start Method: removeObjectManagers
			// Dispose all managers and the hud
			_players.dispose();
			_powerups.dispose();
			_birds.dispose();
			_obstacles.dispose();
			_hud.dispose();
			
			// Deallocate all managers, the hud and the counter
			_players = null;
			_powerups = null;
			_birds = null;
			_obstacles = null;
			_hud = null;
			_counter = null;
		} // End Method: removeObjectManagers
		
		private function initObjectManagers():void {   // Start Method: initObjectManagers
			// Initializing all managers which take care of their respective entities (objects)
			_players = new PlayerManager(this);
			_birds = new BirdManager(this);
			_powerups = new PowerupManager(this);
			_obstacles = new ObstacleManager(this);
		} // End Method: initObjectManagers
		
		private function checkCollisions():void {   // Start Method: checkCollisions
			// Initialize used variables
			var i:uint, j:uint;
			
			// Copy every entity from every manager (if it exists) into a single vector
			var vector:Vector.<Entity> = new Vector.<Entity>();
			if (_players != null)
				for (i=0; i<_players.length; i++)
					vector.push(_players.list[i]);
			if (_players != null)
				for (i=0; i<_players.arrows.length; i++)
					vector.push(_players.arrows.list[i]);
			if (_birds != null)
				for (i=0; i<_birds.length; i++)
					vector.push(_birds.list[i]);
			if (_powerups != null)
				for (i=0; i<_powerups.length; i++)
					vector.push(_powerups.list[i]);
			if (_obstacles != null)
				for (i=0; i<_obstacles.length; i++)
					vector.push(_obstacles.list[i]);
			
			// There is no need to compare collision of less than two entities exists
			if (vector.length < 2)
				return;
			
			// Go through each entity in the merged vector and compare it with every other entity in the merged vector if a collision occurs, if so run the collision
			for (i=0; i<vector.length; i++)							// The entity that is currently being checked
				for (j=0; j<vector.length; j++)						// The entity that is being checked against the current entity
					if (i != j)										// Don't compare against itself
						if (vector[i].collide(vector[j]))			// Check if the checked entity collides with the entity it is checked against
							runCollision(vector[i], vector[j]);		// Run the collision
		} // End Method: checkCollisions
		
		private function pushBack(collision:Entity, compare:Entity):void {   // Start Method: pushBack
			// Don't apply a pushback for the followers of an angry bird V-form group (the leader still applies for pushback)
			if (collision is BirdAngry)
				if (BirdAngry(collision).follower)
					return;
			if (compare is BirdAngry)
				if (BirdAngry(compare).follower)
					return;
			
			if (collision is Cat && compare is Cat) {				// When two players collide, the pushback should goes less farther
				collision.pushBack(collision.width/3, false);
				compare.pushBack(-(compare.width/3), false);
			}
			
			// General usage for a pushback
			if (!(collision is Powerup) && !(collision is Obstacle) || collision is Fish)	// Pushback for the collided entity, as long it is not a powerup (but can be a fish) or obstacle
				collision.pushBack(collision.width/2);										// Pushback forward
			if (!(compare is Powerup) && !(compare is Obstacle) || compare is Fish)			// Pushback for the compared entity, as long it is not a powerup (but can be a fish) or obstacle
				compare.pushBack(-(compare.width/2));										// Pushback backward
		} // End Method: pushBack
		
		private function runCollision(collision:Entity, compare:Entity):void {   // Start Method: runCollision
			// A collision occurs, what should happen?
			if (!collision.hasEnergy || !compare.hasEnergy)					// A collision only occurs when both entities have energy left
				return;
			
			// Pushback collision
			if (collision is Fish && compare is Fish)						// Two fishes collide, push both of them back
				pushBack(collision, compare);
			if (collision is Mountain && compare is Fish)					// A mountain and a fish collide, push back the fish
				pushBack(collision, compare);
			else if (collision is Bird && compare is Bird)					// Two birds collide, push both of them back
				pushBack(collision, compare);
			else if (collision is Powerup && compare is Bird)				// A powerup and a bird collide, push back the bird and the powerup if it is a fish
				pushBack(collision, compare);
			else if (collision is Cat && compare is Cat)					// Two players collide, push both of them back in separate directions
				pushBack(collision, compare);
			
			// Collision with damage, but no object removal
			else if (collision is Obstacle && compare is Cat)				// A player collides with an obstacle, the player gets hurt
				Cat(compare).getHit(Obstacle(collision).damage);
			else if (collision is Bird && compare is Cat)					// A player collides with a bird, the player gets hurt
				Cat(compare).getHit(Bird(collision).damage);
			
			// Collisions with object removal
			else if (collision is Powerup && compare is Cat) {				// A player collides with a powerup
				if (collision is Fish)										// If it is a fish, both players receive energy
					for (var i=0; i<_players.length; i++)
						if (_players.list[i].hasEnergy)
							players.list[i].restore(collision.energy);
				if (collision is DoubleDamage || collision is DoubleScore)	// If it is a Double Damage or Double Score powerup, activate their bonus
					_powerups.activate(Powerup(collision));
				if (collision is Cape)										// If it is a cape, the player that dead is restored
					_powerups.restorePlayers();
				_powerups.remove(_powerups.indexOf(collision));				// The powerup is always removed
			}
			
			else if (collision is Arrow && compare is Bird) {				// An arrow and a bird collide, remove the arrow and the bird gets hurt
				_players.arrows.remove(_players.arrows.indexOf(collision));
				Bird(compare).getHit();
			}
		} // End Method: runCollision
		
		private function checkGameOver():void {   // Start Method: checkGameOver
			// The game is over when no player is left on the screen
			if (_players.length == 0 && !_gameOver)
				gameOver();
		} // End Method: checkGameOver
		
		private function gameOver():void {   // Start Method: gameOver
			// The player(s) lost, time to prepare to end the game by removing the timers, saving the score, removing the manager and to call the game over screen
			_gameOver = true;
			Session.timer.disposeTimers();
			var score = _counter.score;
			removeObjectManagers();
			goToGameOverState(score);
		} // End Method: gameOver
		
	} // End Class: GameState
	
} // End Package