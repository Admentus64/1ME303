/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package state {   // Start Package	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.input.EvertronInput;
	
	// Project Imports
	import asset.screen.GameBackgroundClip;
	import asset.screen.RetryControlsClip;
	import asset.screen.GameOverCatClip;
	import asset.screen.GameOverDogClip;
	import display.GameText;
	
	
		public class GameOverState extends ScreenState {   // Start Class: GameOverState		
		// Private Variables
		private var _score:uint = 0;
		private var _coop:Boolean = false;
		private var _setHighscore = false;
		
		// Embeddings
		[Embed(source = "../../asset/music/musicGameOver.mp3")]			private static const MUSIC:Class;
		
		
				public function GameOverState(coop:Boolean, score:uint, sound:Boolean, music:Boolean) {   // Start Constructor: GameOverState
			super(sound, music);
			_coop = coop;
			_score = score;		} // End Constructor: GameOverState		
		
		
		// Override Public Methods		override public function init():void {   // Start Method: init
			super.init();
			
			primaryLayer.addChild(new GameBackgroundClip);
			if (music)
				initMusic("Game Over", MUSIC);
			enableGameTextOptionList();
			
			var gameText:GameText = addGameText("Game Over", 400, 100);					// Add a Game Over text on the top of the screen and animate it (resizing animation)
			gameText.startAnimate(30, 45, 50);
			addGameText("Retry?", 400, 230, 0xFFFFFF, 30);								// Add a text asking if the player would like to retry the game, just a static text
			addGameText("Your Score: " + _score.toString(), 400, 450, 0xFFFFFF, 30);	// List the player's score on the bottom of the screen, using the player's score from the game screen
			
			// Adding two options to choose between, 
			_optionList.addTitle("YES", "center", false, 0x8B4513);	// Apply a brown color to the font, since a white font color does not work on a white background
			_optionList.addTitle("NO", "center", false, 0x8B4513);
			_optionList.y = 320;
			_optionList.columnWidth = 100;
			_optionList.drawBorder(35, 1, 1.6);
			
			// Add controller graphics for the white buttons to indicate those can be pressed to for starting a new game
			var adjustY:uint = 0;									// Move the controller graphics a bit lower in coop mode to make space for the dead dog graphic
			if (_coop)
				adjustY = 200;
			addMovieClipController(new RetryControlsClip, 600, 350 + adjustY, 1, false, 0.5);
			addGameText("Solo\nGame", 600, 250 + adjustY, 0xFFFFFF, 20);		// Responds to the left white button for a new solo game
			addGameText("Coop\nGame", 680, 250 + adjustY, 0xFFFFFF, 20);		// Responds to the right white button for a new coop game
			
			addMovieClipController(new GameOverCatClip, 150, 300, 1.5, false, 0);
			if (_coop)
				addMovieClipController(new GameOverDogClip, 650, 300, 1.5, true, 0);
			if (_coop)
				Session.highscore.smartSend(2, _score, 10, onSmartSendComplete);		// Set a highscore for the coop highscore list, if there is a highscore
			else Session.highscore.smartSend(1, _score, 10, onSmartSendComplete);		// Set a highscore for the solo highscore list, if there is a highscore
					} // End Method: init
				override public function update():void {   // Start Method: update
			super.update();
			loopMusic(0.6);
			if (_setHighscore) {									// Only allow the player to proceed using controls have the highscore has been set (or not if it was not high enough)				updateControls();
				updateUniversalControls();
			}
			
			// DEBUG
			if (Input.keyboard.justPressed("SPACE"))
				Session.application.displayState = new MainMenuState(sound, music);		} // End Method: update
		
		
		
		// Private Methods		
		private function onSmartSendComplete(highscore:XML):void {   // Start Method: onSmartSendComplete
			// Check if the Game Over menu still exists in order to avoid crashes
			if (_optionList == null)
				return;
			
			// A highscore has been set, the player can now continue selecting an option
			_setHighscore = true;
			_optionList.select = 0;
			
			if (_coop)
				Session.highscore.receive(2, 10, function(scores:XML):void { getHighscoreData(scores, highscore) } );	// Get the coop score list, pass the checked score and all current highscores
			else Session.highscore.receive(1, 10, function(scores:XML):void { getHighscoreData(scores, highscore) } );	// Get the solo score list, pass the checked score and all current highscores
		} // End Method: onSmartSendComplete
		
		private function getHighscoreData(scores:XML, highscore:XML):void {
			// Going through all the highscores in order to check if the obtained score is a highscore, but only proceed to do so as long the Game Over menu still exists
			if (_optionList == null)
				return;
			
			// Currently, there is no new rank, used ranks are between 1 and 10
			var rank:uint = 0;
			if (highscore.header.success == "true")												// First check if the score is a highscore that has been set
				for (var i:uint=0; i<10; i++)													// Go through 10 entries
					if (scores.items != undefined)												// Check if an entry exists
						if (scores.items.item[i] != undefined)									// Check if an entry that exists has a score
							if (highscore.items.item.name == scores.items.item[i].name)			// Check if the score and the current checked highscore have the same player name
								if (highscore.items.item.score == scores.items.item[i].score)	// Check if the score and the current checked highscore have the same score
									if (highscore.items.item.date == scores.items.item[i].date)	// Check if the score and the current checked highscore have the same date
										rank = i+1;												// If all the checks have been passed, the score must be the current checked highscore, continue onwards checking a higher highscore
			
			// Write down the player highscore rank, for FUN!
			if (rank != 0)
				addGameText("Your Rank: " + rank, 400, 500, 0x009600, 20);				// The player obtained a new highscore, so write down the rank and colorize it green				
			else addGameText("Your Rank:\nNo New Highscore", 400, 500, 0xFF0000, 20);	// The player did not obtain a new highscore, so mention that and colorize it red							
		}
		
		
		private function updateControls():void {   // Start Method: updateControls
			// When pressing BUTTON 1 for either player to select an option which is highlighted
			if (Input.keyboard.justPressed(EvertronInput.PLAYER_1_BUTTON_1) || Input.keyboard.justPressed(EvertronInput.PLAYER_2_BUTTON_1)) {
				if (_optionList.choice == "YES")
					gotoState(function():void { Session.application.displayState = new GameState(_coop, sound, music); });
				else if (_optionList.choice == "NO")
					gotoState(function():void { Session.application.displayState = new MainMenuState(sound, music); });
				playSelectSound();
			}
		} // End Method: updateControls
		
		private function updateUniversalControls():void {   // Start Method: updateUniversalControls
			// Use the UNIVERSAL START buttons to start a new game in their respect mode, or BUTTON 2 for either player to return to the main menu
			if (Input.keyboard.justPressed(EvertronInput.UNIVERSAL_START_1))
				Session.application.displayState = new GameState(false, sound, music);
			else if (Input.keyboard.justPressed(EvertronInput.UNIVERSAL_START_2))
				Session.application.displayState = new GameState(true, sound, music);
			else if (Input.keyboard.justPressed(EvertronInput.PLAYER_1_BUTTON_2) || Input.keyboard.justPressed(EvertronInput.PLAYER_2_BUTTON_2))
				Session.application.displayState = new MainMenuState(sound, music);
		} // End Method: updateUniversalControls
			} // End Class: GameOverState
	} // End Package