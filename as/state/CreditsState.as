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
	import display.GameTextList;
	
	
		public class CreditsState extends ScreenState {   // Start Class: CreditsState
				public function CreditsState(sound:Boolean=true, music:Boolean=true)	{ super(sound, music); }   // Constructor: CreditsState		
		
		
		// Override Public Methods		override public function init():void {   // Start Method: init
			super.init();
			
			primaryLayer.addChild(new GameBackgroundClip);
			enableGameTextOptionList();
			
			// Add the credit lists
			addSoundList();
			addMusicList();
			addMiscList();
			addFontList();
			
			// Add the option button used to return to the main menu
			_optionList.addTitle("Return", "center", false, 0x8B4513);
			_optionList.y = 500;
			_optionList.select = 0;
			_optionList.drawBorder(20, 1, 1);		} // End Method: init
				override public function update():void {   // Start Method: update
			super.update();
			updateControls();
			updateUniversalControls();		} // End Method: update
		
		
		
		// Private Methods
		private function addSoundList() {   // Start Method: addSoundList
			var textList:GameTextList = new GameTextList();
			primaryLayer.addChild(textList);
			
			// Credit the sound effects
			textList.addDescription("Shoot Arrow by Hanbaal", "left", true);
			textList.addDescription("Jumping by Lefty_Studios", "left", true);
			textList.addDescription("Cat Get Hit by InspectorJ", "left", true);
			textList.addDescription("Cat Dead by tuberatanka", "left", true);
			textList.addDescription("Dog Get Hit by kwahmah_02", "left", true);
			textList.addDescription("Dog Dead by AustinXYZ", "left", true);
			textList.addDescription("Restore Energy by Robinhood76", "left", true);
			textList.addDescription("Angry Bird by markb258", "left", true);
			textList.addDescription("Airplane Bird by adcbicycle", "left", true);
			textList.addDescription("Raincloud Bird by Bird_Man", "left", true);
			textList.addDescription("Thundercloud Bird by TheStarKing", "left", true);
			textList.addDescription("Powerups by RandomationPictures", "left", true);
			textList.addDescription("Menu Select by plasterbrain", "left", true);
			textList.addDescription("New Life Cape by ZapSplat", "left", true);
			textList.addDescription("Airplane Shooting by Xenonn", "left", true);
			textList.addDescription("Cloud Shooting by plasterbrain", "left", true);
			
			// Text list makeup
			textList.columns = 3;
			textList.columnWidth = 260;
			textList.rowHeight = 30;
			textList.fontSize = 18;
			textList.x = 20;
			textList.y = 60;
			
			// Add the title for the sound effects separately to avoid breaking the columns
			addGameText("Sound Effects", textList.x, textList.y - 40, 0xFFFFFF, 24, true, "left");
			
		} // End Method: addSoundList
		
		private function addMusicList() {   // Start Method: addMusicList
			var textList:GameTextList = new GameTextList();
			primaryLayer.addChild(textList);
			
			// Credit the used music
			textList.addTitle("Music", "left", true);
			textList.addDescription("Main Menu by TRG Banks (Night Sun)", "left", true);
			textList.addDescription("Game by Ask Again (Don't Feel So Low)", "left", true);
			textList.addDescription("Game Over by Ask Again (Howling Down)", "left", true);
			
			// Text list makeup
			textList.rowHeight = 30;
			textList.replaceFontSize(13, 18);
			textList.x = 20;
			textList.y = 285;
			
			textList.get(0).y -= 10;
		} // End Method: addMusicList
		
		private function addFontList() {   // Start Method: addFontList
			var textList:GameTextList = new GameTextList();
			primaryLayer.addChild(textList);
			
			// Credit the used fonts
			textList.addTitle("Fonts", "left", true);
			textList.addDescription("Smile Comix font by\nJethro Martino Paras", "left", true);
			textList.addDescription("Londrina font by\nMarcelo Magalhães Pereira", "left", true);
			
			// Text list makeup
			textList.rowHeight = 40;
			textList.replaceFontSize(13, 18);
			textList.x = 600;
			textList.y = 275;
			
			textList.get(2).y += 20;
		} // End Method: addFontList
		
		private function addMiscList() {   // Start Method: addMiscList
			var textList:GameTextList = new GameTextList();
			primaryLayer.addChild(textList);
			
			// Credit ourselves
			textList.addTitle("Code / Design", "left", true);
			textList.addDescription("Robert Hallink", "left", true);
			textList.addTitle("Graphics", "left", true);
			textList.addDescription("Sara Alkell", "left", true);
			
			// Text list makeup
			textList.columns = 1;
			textList.rowHeight = 50;
			textList.replaceFontSize(13, 32);
			textList.replaceFontSize(24, 46);
			textList.x = 330;
			textList.y = 250;
		} // End Method: addMiscList
		
		private function updateControls():void {   // Start Method: updateControls
			// When pressing BUTTON 1 for either player to select an option which is highlighted
			if (Input.keyboard.justPressed(EvertronInput.PLAYER_1_BUTTON_1) || Input.keyboard.justPressed(EvertronInput.PLAYER_2_BUTTON_1)) {
				if (_optionList.choice == "Return")
					gotoState(function():void { Session.application.displayState = new MainMenuState(sound, music); });
				playSelectSound();
			}
		} // End Method: updateControls
		
		private function updateUniversalControls():void {   // Start Method: updateUniversalControls
			// Use the UNIVERSAL START buttons to return to the main menu
			if (Input.keyboard.justPressed(EvertronInput.UNIVERSAL_START_1) || Input.keyboard.justPressed(EvertronInput.UNIVERSAL_START_2) ||
				Input.keyboard.justPressed(EvertronInput.PLAYER_1_BUTTON_2) || Input.keyboard.justPressed(EvertronInput.PLAYER_2_BUTTON_2) )
				Session.application.displayState = new MainMenuState(sound, music);
		} // End Method: updateUniversalControls
			} // End Class: CreditsState
	} // End Package