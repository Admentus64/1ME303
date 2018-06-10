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
	import se.lnu.stickossdk.util.URLUtils;
	
	// Project Imports
	import asset.screen.MainMenuBackgroundClip;
	import asset.screen.HighscoreBorderClip;
	import asset.screen.MainMenuCatClip;
	import asset.screen.MainMenuDogClip;
	import asset.bird.BirdAngryIdleClip;
	import asset.bird.BirdAirplaneIdleClip;
	import asset.bird.BirdRainCloudIdleClip;
	import asset.bird.BirdThunderCloudIdleClip;
	import asset.obstacle.MountainClip;
	import display.GameText;
	import display.GameTextList;
	import util.MovieClipController;
	
	
		public class MainMenuState extends ScreenState {   // Start Class: MainMenuState
		
		// Private Variables
		private var _scoreTableText:GameText = null;
		private var _scoreList:GameTextList = new GameTextList();
		private var _scoreListBorderClip:HighscoreBorderClip = new HighscoreBorderClip();
		private var _menuCat:MovieClipController = null;
		private var _menuDog:MovieClipController = null;
		
		// Embeddings
		[Embed(source = "../../asset/music/musicMenu.mp3")]			private static const MUSIC:Class;
		
		
				public function MainMenuState(sound:Boolean=true, music:Boolean=true)	{ super(sound, music); }   // Constructor: MainMenuState		
		
		
		// Override Public Methods		override public function init():void {   // Start Method: init
			super.init();
			
			primaryLayer.addChild(new MainMenuBackgroundClip);
			initMusic("Menu", MUSIC);
			enableGameTextOptionList();
			
			// Add player characters to represent the chosen game mode
			_menuCat = addMovieClipController(new MainMenuCatClip, 110, 150, 0.5, false);
			_menuDog = addMovieClipController(new MainMenuDogClip, 210, 200, 0.5, false);
			_menuCat.play(0.5);
			_menuDog.visible = false;
			
			addBackgroundObjects();			
			
			// The cloud-based graphic border for the score list
			primaryLayer.addChild(_scoreListBorderClip);
			_scoreListBorderClip.x = 400;
			_scoreListBorderClip.y = 480;
			_scoreListBorderClip.scaleX = 1.45;
			
			// The score list and entries to list
			primaryLayer.addChild(_scoreList);
			_scoreList.columns = 4;
			_scoreList.columnWidth = 200;
			_scoreList.rowHeight = 28;
			_scoreList.x = 70;
			_scoreList.y = 400;
			
			// The type of score (solo or coop)
			_scoreTableText = addGameText("Solo\nScore", _scoreList.x - 50, _scoreList.y - 110, 0xFFFFFF, 30, false, "left");
			
			// Add option choices
			_optionList.addTitle("One Player");
			_optionList.addTitle("Two Players");
			_optionList.addTitle("Credits");
			if (sound)
				_optionList.addTitle("Disable Sound");
			else _optionList.addTitle("Enable Sound");
			if (music)
				_optionList.addTitle("Disable Music");
			else _optionList.addTitle("Enable Music");
			_optionList.x = 400;
			_optionList.y = 110;
			_optionList.select = 0;
			
			Session.highscore.receive(1, 10, function(data:XML):void {getHighscoreData(data) } );		} // End Method: init
				override public function update():void {   // Start Method: update
			super.update();
			loopMusic(0.6);
			updateControls();
			updateUniversalControls();		} // End Method: update				override public function dispose():void {   // Start Method: dispose
			super.dispose();
			_scoreTableText = null;
			_scoreList = null;
			_scoreListBorderClip = null;
			_menuCat = null;
			_menuDog = null;
		} // End Method: dispose
		
		
		
		// Private Methods
		private function addBackgroundObjects():void {  // Start Method: addBackgroundObjects 
			// Adding animated background objects on the right side of the screen, just to make the menu sceen more alive
			addMovieClipController(new BirdAngryIdleClip, 580, 100, 0.3, false, 1);				// Angry Bird 4x
			addMovieClipController(new BirdAngryIdleClip, 700, 90, 0.3, false, 1);
			addMovieClipController(new BirdAngryIdleClip, 640, 75, 0.3, false, 1);
			addMovieClipController(new BirdAngryIdleClip, 680, 50, 0.3, false, 1);
			addMovieClipController (new BirdAirplaneIdleClip, 600, 200, 0.3, false, 1);			// Bird in Airplane
			addMovieClipController (new BirdRainCloudIdleClip, 670, 180, 0.4, false, 1);		// Bird on Rain Cloud
			addMovieClipController (new BirdThunderCloudIdleClip, 700, 220, 0.4, false, 1);		// Bird on Thunder Cloud
			addMovieClipController (new MountainClip, 650, 330, 2.0, false , 0);				// Mountain
		} // End Method: addBackgroundObjects
		
		private function getHighscoreData(data:XML):void {   // Start Method: getHighscoreData
			// Make sure the menu screen still exists before proceeding to avoid crashes
			if (_scoreList == null)
				return;
			
			// Don't continue either if either the One Player or Two Player options are not highlighted
			if (_optionList.choice != "One Player" && _optionList.choice != "Two Players")
				return;
			
			_scoreList.empty();													// Empty the highscore list before starting
			
			var i:uint, j:uint, name:String, score:String;
			for (i=0; i<2; i++) {												// Doing this process twice, once on the left column and once on the right column
				_scoreList.addDescription("NAME", "left", true, 0x000000);		// Adding the names
				for (j=0+i*5; j<5+i*5; j++) {									// Adding five names per column, going through each highscore entry eventually
					name = "None";												// A name is not set per default
					if (data.items != undefined)								// Check if the highscore list exists
						if (data.items.item[j] != undefined)					// Check if the current highscore entry exists
							name = URLUtils.decode(data.items.item[j].name);	// Retrieve the name from the current highscore entry
					// Add the name into the highscore list, which is per default set to "None". Also numerate each name
					if (j+1 == 10)
						_scoreList.addDescription((j+1) + " " + name, "left", false, 0x8B4513);
					else _scoreList.addDescription("0" + (j+1) + " " + name, "left", false, 0x8B4513);
				}
				_scoreList.addDescription("SCORE", "left", true, 0x000000);		// Adding the score
				for (j=0+i*5; j<5+i*5; j++) {									// Adding five scores per column, going through each highscore entry eventually
					score = "Not Set";											// A score is not set per default
					if (data.items != undefined)								// Check if the highscore list exists
						if (data.items.item[j] != undefined)					// Check if the current highscore entry exists
							score = data.items.item[j].score;					// Retrieve the score from the current highscore entry
					_scoreList.addDescription(score, "left", false, 0x8B4513);	// Add the score into the highscore list, which is per default set to "Not Set"
				}
			}
			
		} // End Method: getHighscoreData
		
		private function updateControls():void {   // Start Method: updateControls
			// Correct the display of the score table and the characters representing the game mode when pressing UP or DOWN for either player to go through the options to highlight
			if (Input.keyboard.justPressed(EvertronInput.PLAYER_1_UP) || Input.keyboard.justPressed(EvertronInput.PLAYER_1_DOWN) ||
				Input.keyboard.justPressed(EvertronInput.PLAYER_2_UP) || Input.keyboard.justPressed(EvertronInput.PLAYER_2_DOWN) ) {
				if (_optionList.choice == "One Player") {
					Session.highscore.receive(1, 10, function(data:XML):void {getHighscoreData(data) } );
					_scoreTableText.text = "Solo\nScore";
					_menuDog.gotoAndStop(0);
					_menuDog.visible = false;
				}
				else if (_optionList.choice == "Two Players") {
					Session.highscore.receive(2, 10, function(data:XML):void {getHighscoreData(data) } );
					_scoreTableText.text = "Coop\nScore";
					if (!_menuCat.isPlaying) {
						_menuCat.play(0.5);
						_menuCat.visible = true
					}
					_menuDog.play(0.5);
					_menuDog.visible = true;
				}
				else {												// Since no game mode is highlighted, don't display the score table and game characters at all
					if (_scoreList.length > 0)
						_scoreList.empty();
					if (_scoreTableText.text != "")
						_scoreTableText.text = "";
					if (_menuCat.isPlaying) {
						_menuCat.gotoAndStop(0);
						_menuCat.visible = false;
					}
					if (_menuDog.isPlaying) {
						_menuDog.gotoAndStop(0);
						_menuDog.visible = false;
					}
				}
			}
			
			// When pressing BUTTON 1 for either player to select an option which is highlighted
			if (Input.keyboard.justPressed(EvertronInput.PLAYER_1_BUTTON_1) || Input.keyboard.justPressed(EvertronInput.PLAYER_2_BUTTON_1)) {
				if (_optionList.choice == "One Player")
					gotoState(function():void { Session.application.displayState = new HowToPlayState(false, sound, music); });
				else if (_optionList.choice == "Two Players")
					gotoState(function():void { Session.application.displayState = new HowToPlayState(true, sound, music); });
				else if (_optionList.choice == "Credits")
					gotoState(function():void { Session.application.displayState = new CreditsState(sound, music); });
				if (_optionList.choice == "Disable Sound") {
					_optionList.text = "Enable Sound";
					_sound = false;
				}
				else if (_optionList.choice == "Enable Sound") {
					_optionList.text = "Disable Sound";
					_sound = true;
				}
				else if (_optionList.choice == "Disable Music") {
					_optionList.text = "Enable Music";
					_music = false;
				}
				else if (_optionList.choice == "Enable Music") {
					_optionList.text = "Disable Music";
					_music = true;
				}
				playSelectSound();
			}
		} // End Method: updateControls
		
		private function updateUniversalControls():void {   // Start Method: updateUniversalControls
			// Use the UNIVERSAL START buttons to start their respective game mode
			if (Input.keyboard.justPressed(EvertronInput.UNIVERSAL_START_1))
				Session.application.displayState = new HowToPlayState(false);
			else if (Input.keyboard.justPressed(EvertronInput.UNIVERSAL_START_2))
				Session.application.displayState = new HowToPlayState(true);
		} // End Method: updateUniversalControls
			} // End Class: MainMenuState
	} // End Package