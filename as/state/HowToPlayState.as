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
	
	// Flash Imports
	import flash.display.MovieClip;
	
	// Project Imports
	import asset.screen.GameBackgroundClip;
	import asset.screen.BorderClip;
	import asset.screen.ControlsBorderClip;
	import asset.bird.BirdAngryIdleClip;
	import asset.bird.BirdAirplaneIdleClip;
	import asset.bird.BirdRainCloudIdleClip;
	import asset.bird.BirdThunderCloudIdleClip;
	import asset.powerup.FishSmallClip;
	import asset.powerup.FishMediumClip;
	import asset.powerup.FishLargeClip;
	import asset.powerup.CapeClip;
	import asset.powerup.DoubleDamageClip;
	import asset.powerup.DoubleScoreClip;
	import asset.hud.ClockClip;
	import asset.hud.ScoreClip;
	import asset.player.SuperCatUpClip;
	import asset.player.SuperDogUpClip;
	import display.GameTextList;
	import util.MovieClipController;
	
	
		public class HowToPlayState extends ScreenState {   // Start Class: HowToPlayState
		
		// Private Variables
		private var _coop:Boolean = false;
		
		
				public function HowToPlayState(coop:Boolean, sound:Boolean=true, music:Boolean=true) {   // Start Constructor: HowToPlayState
			super(sound, music);
			_coop = coop;		}   // End Constructor: HowToPlayState		
		
		
		// Override Public Methods		override public function init():void {   // Start Method: init
			super.init();
			
			primaryLayer.addChild(new GameBackgroundClip);
			enableGameTextOptionList();
			
			// Add both instruction boxes
			addBorder(new ControlsBorderClip, 230, 290, 1, 1, 0.75);
			addBorder(new BorderClip, 620, 290, 0.8, 1, 1);
			
			// Add titles for both instructions boxes
			addGameText("Instructions", 400, 10, 0xFFFFFF, 60);
			addGameText("Controls", 220, 110, 0x8B4513, 40);
			
			// Add the button to continue to the game
			_optionList.addTitle("Continue", "center", false, 0x8B4513);
			_optionList.y = 520;
			_optionList.select = 0;
			_optionList.drawBorder(20, 1, 1);
			
			// List text to explain the mechanics
			var guideList:GameTextList = new GameTextList();
			primaryLayer.addChild(guideList);
			guideList.addDescription("Avoid being hit by birds & obstacles", "right", false, 0x8B4513);
			guideList.addDescription("Collecting fish restores your energy", "right", false, 0x8B4513);
			if (_coop)
				guideList.addDescription("Capes revives your friend", "right", false, 0x8B4513);
			else guideList.addDescription("", "right", false, 0x8B4513);
			guideList.addDescription("Double your score & damage briefly", "right", false, 0x8B4513);
			guideList.addDescription("Stay alive to increase your score", "right", false, 0x8B4513);
			guideList.addDescription("Jumping uses energy, be conservative", "right", false, 0x8B4513);
			guideList.rowHeight = 60;
			guideList.x = 760;
			guideList.y = 100;
			
			placeInstructionMovieClips();		} // End Method: init
				override public function update():void {   // Start Method: update
			super.update();
			updateControls();
			updateUniversalControls();		} // End Method: update
		
		
		
		// Private Methods
		private function addBorder(movieClip:MovieClip, xPos:Number, yPos:Number, xScale:Number, yScale:Number, speed:Number):void {   // Start Method: addBorder
			// Method to place a movieclip as a boxed border, preferably a cloud-based graphics movieclip. The position, scale and animation speed can be adjusted
			var clip:MovieClip = movieClip;
			primaryLayer.addChild(clip);
			clip.x = xPos;
			clip.y = yPos;
			clip.scaleX = xScale;
			clip.scaleY = yScale;
			var controller:MovieClipController = new MovieClipController(clip);
			controller.play(speed);
		} // End Method: addBorder
		
		private function placeInstructionMovieClips():void {   // Start Method: placeInstructionMovieClips
			// Adding movieclips to the screen to act as graphical instruction material
			addMovieClipController(new BirdAngryIdleClip, 740, 137, 0.2, false, 1);
			addMovieClipController(new BirdAirplaneIdleClip, 677, 142, 0.2, false, 1);
			addMovieClipController(new BirdRainCloudIdleClip, 620, 145, 0.26, false, 1);
			addMovieClipController(new BirdThunderCloudIdleClip, 560, 145, 0.26, false, 0.5);
			addMovieClipController(new FishSmallClip, 740, 200, 0.125, false, 0.5);
			addMovieClipController(new FishMediumClip, 680, 200, 0.125, false, 0.5);
			addMovieClipController(new FishLargeClip, 620, 200, 0.125, false, 0.5);
			if (_coop)
				addMovieClipController(new CapeClip, 740, 260, 0.5, false, 1);
			addMovieClipController(new DoubleDamageClip, 740, 320, 0.5, false, 0);
			addMovieClipController(new DoubleScoreClip, 680, 320, 0.15, false, 0);
			addMovieClipController(new ClockClip, 740, 380, 0.15, false, 0.2);
			addMovieClipController(new ScoreClip, 680, 380, 0.15, false, 0);
			addMovieClipController(new SuperCatUpClip, 740, 445, 0.15, false, 0.8);
			addMovieClipController(new SuperDogUpClip, 680, 445, 0.15, false, 0.8);
		} // End Method: placeInstructionMovieClips
		
		private function updateControls():void {   // Start Method: updateControls
			// When pressing BUTTON 1 for either player to select an option which is highlighted
			if (Input.keyboard.justPressed(EvertronInput.PLAYER_1_BUTTON_1) || Input.keyboard.justPressed(EvertronInput.PLAYER_2_BUTTON_1)) {
				if (_optionList.choice == "Continue")
					gotoState(function():void { Session.application.displayState = new GameState(_coop, sound, music); });
				playSelectSound();
			}
		} // End Method: updateControls
		
		private function updateUniversalControls():void {   // Start Method: updateUniversalControls
			// Use the UNIVERSAL START buttons to continue to the game, or BUTTON 2 for either player to return to the main menu
			if (Input.keyboard.justPressed(EvertronInput.UNIVERSAL_START_1) || Input.keyboard.justPressed(EvertronInput.UNIVERSAL_START_2))
				Session.application.displayState = new GameState(_coop, sound, music);
			else if (Input.keyboard.justPressed(EvertronInput.PLAYER_1_BUTTON_2) || Input.keyboard.justPressed(EvertronInput.PLAYER_2_BUTTON_2))
				Session.application.displayState = new MainMenuState(sound, music);
		} // End Method: updateUniversalControls
			} // End Class: HowToPlayState
	} // End Package