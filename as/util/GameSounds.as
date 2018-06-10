/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package util {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	
	
	
	public class GameSounds {   // Start Class: GameSounds
		
		// Private Variables
		private var _coop:Boolean = false;
		
		// Embeddings
		[Embed(source = "../../asset/sound/soundShootArrow.mp3")]				private static const SOUND_SHOOT:Class;
		[Embed(source = "../../asset/sound/soundJump.mp3")]						private static const SOUND_JUMP:Class;
		[Embed(source = "../../asset/sound/soundRestore.mp3")]					private static const SOUND_RESTORE:Class;
		[Embed(source = "../../asset/sound/soundCatGetHit.mp3")]				private static const SOUND_CAT_GET_HIT:Class;
		[Embed(source = "../../asset/sound/soundDogGetHit.mp3")]				private static const SOUND_DOG_GET_HIT:Class;
		[Embed(source = "../../asset/sound/soundCatDead.mp3")]					private static const SOUND_CAT_DEAD:Class;
		[Embed(source = "../../asset/sound/soundDogDead.mp3")]					private static const SOUND_DOG_DEAD:Class;
		[Embed(source = "../../asset/sound/soundHitBird.mp3")]					private static const SOUND_BIRD_GET_HIT:Class;
		[Embed(source = "../../asset/sound/soundBirdAngryDead.mp3")]			private static const SOUND_BIRD_ANGRY_DEAD:Class;
		[Embed(source = "../../asset/sound/soundBirdAirplaneDead.mp3")]			private static const SOUND_BIRD_AIRPLANE_DEAD:Class;
		[Embed(source = "../../asset/sound/soundBirdRainCloudDead.mp3")]		private static const SOUND_BIRD_RAIN_CLOUD_DEAD:Class;
		[Embed(source = "../../asset/sound/soundBirdThunderCloudDead.mp3")]		private static const SOUND_BIRD_THUNDER_CLOUD_DEAD:Class;
		[Embed(source = "../../asset/sound/soundBirdAirplaneShoot.mp3")]		private static const SOUND_BIRD_AIRPLANE_SHOOT:Class;
		[Embed(source = "../../asset/sound/soundBirdCloudShoot.mp3")]			private static const SOUND_BIRD_CLOUD_SHOOT:Class;
		[Embed(source = "../../asset/sound/soundPowerup.mp3")]					private static const SOUND_POWERUP:Class;
		[Embed(source = "../../asset/sound/soundBackToLife.mp3")]				private static const SOUND_BACKTOLIFE:Class;
		
		
		
		public function GameSounds(coop) {   // Start Constructor: GameSounds
			_coop = coop;
			
			// Player character sounds
			Session.sound.soundChannel.sources.add("Player Shoot Arrow", SOUND_SHOOT);
			Session.sound.soundChannel.sources.add("Player Jump", SOUND_JUMP);
			Session.sound.soundChannel.sources.add("Player Restore", SOUND_RESTORE);
			Session.sound.soundChannel.sources.add("Cat Dead", SOUND_CAT_DEAD);
			Session.sound.soundChannel.sources.add("Cat Get Hit", SOUND_CAT_GET_HIT);
			
			// Sounds for the dog character
			if (_coop) {
				Session.sound.soundChannel.sources.add("Dog Dead", SOUND_DOG_DEAD);
				Session.sound.soundChannel.sources.add("Dog Get Hit", SOUND_DOG_GET_HIT);
			}
			
			// Enemy sounds
			Session.sound.soundChannel.sources.add("Bird Get Hit", SOUND_BIRD_GET_HIT);
			Session.sound.soundChannel.sources.add("Bird Angry Dead", SOUND_BIRD_ANGRY_DEAD);
			Session.sound.soundChannel.sources.add("Bird Airplane Dead", SOUND_BIRD_AIRPLANE_DEAD);
			Session.sound.soundChannel.sources.add("Bird Rain Cloud Dead", SOUND_BIRD_RAIN_CLOUD_DEAD);
			Session.sound.soundChannel.sources.add("Bird Thunder Cloud Dead", SOUND_BIRD_THUNDER_CLOUD_DEAD);
			Session.sound.soundChannel.sources.add("Bird Airplane Shoot", SOUND_BIRD_AIRPLANE_SHOOT);
			Session.sound.soundChannel.sources.add("Bird Cloud Shoot", SOUND_BIRD_CLOUD_SHOOT);
			
			// Powerup sounds
			Session.sound.soundChannel.sources.add("Powerup Activate", SOUND_POWERUP);
			Session.sound.soundChannel.sources.add("Back To Life", SOUND_BACKTOLIFE);
		} // End Constructor: GameSounds
		
		
		
		// Public Methods
		public function clear() {   // Start Method: clear
			// Player character sounds
			Session.sound.soundChannel.sources.remove("Player Shoot Arrow");
			Session.sound.soundChannel.sources.remove("Player Jump");
			Session.sound.soundChannel.sources.remove("Player Restore");
			Session.sound.soundChannel.sources.remove("Cat Dead");
			Session.sound.soundChannel.sources.remove("Cat Get Hit");
			
			// Sounds for the dog character
			if (_coop) {
				Session.sound.soundChannel.sources.remove("Dog Dead");
				Session.sound.soundChannel.sources.remove("Dog Get Hit");
			}
			
			// Enemy sounds
			Session.sound.soundChannel.sources.remove("Bird Get Hit");
			Session.sound.soundChannel.sources.remove("Bird Angry Dead");
			Session.sound.soundChannel.sources.remove("Bird Airplane Dead");
			Session.sound.soundChannel.sources.remove("Bird Rain Cloud Dead");
			Session.sound.soundChannel.sources.remove("Bird Thunder Cloud Dead");
			Session.sound.soundChannel.sources.remove("Bird Airplane Shoot");
			Session.sound.soundChannel.sources.remove("Bird Cloud Shoot");
			
			// Powerup sounds
			Session.sound.soundChannel.sources.remove("Powerup Activate");
			Session.sound.soundChannel.sources.remove("Back To Life");
		} // End Method: clear
		
	} // End Class: GameSounds
	
} // End Package