/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package state {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.display.DisplayState;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.input.EvertronInput;
	import se.lnu.stickossdk.media.SoundObject;
	
	// Flash Imports
	import flash.utils.getQualifiedClassName;
	import flash.display.Sprite;
	import flash.display.MovieClip;
	
	// Project Imports
	import display.GameText;
	import display.GameTextOptionList;
	import util.MovieClipController;
	
	
	
	public class ScreenState extends DisplayState implements ScreenStateInterface {   // Start Class: ScreenState
		
		// Getters
		public function get sound():Boolean							{ return _sound; }			// Get: sound
		public function get music():Boolean							{ return _music; }			// Get: music
		public function get primaryLayer():Sprite					{ return _gameLayers[0]; }	// Get: primaryLayer
		public function get layerList():Vector.<Sprite>				{ return _gameLayers; }		// Get: layerList
		
		
		
		// Protected Variables
		protected static const LAYER_OBJECTS:String = "objects";
		protected var _gameLayers:Vector.<Sprite> = null;
		protected var _musTrack:SoundObject = null;
		protected var _sound:Boolean = true;
		protected var _music:Boolean = true;
		protected var _optionList:GameTextOptionList = null;
		
		// Private Variables
		private var _sndSelect:SoundObject = null;
		private var _musicName:String = null;
		
		// Embeddings
		[Embed(source = "../../asset/sound/soundSelectOption.mp3")]			private static const SOUND_SELECT_OPTION:Class;
		
		
		
		public function ScreenState(sound:Boolean=true, music:Boolean=true) {   // Start Constructor: ScreenState
			_sound = sound;
			_music = music;
		}  // End Constructor: ScreenState
		
		
		
		// Override Public Methods
		override public function init():void {   // Start Method: init
			super.init();
			trace("INIT FROM: " +  getQualifiedClassName(this).slice(getQualifiedClassName(this).lastIndexOf("::") + 2));
			_gameLayers = new Vector.<Sprite>();
			_gameLayers.push(layers.add(LAYER_OBJECTS));
		} // End Method: init
		
		override public function dispose():void	{   // Start Method: dispose
			super.dispose();
			trace("DISPOSE: " +  getQualifiedClassName(this).slice(getQualifiedClassName(this).lastIndexOf("::") + 2));
			
			// Remove the click sound for selecting an option if present
			if (_sndSelect != null) {
				_sndSelect.stop();
				Session.sound.soundChannel.sources.remove("Select Option");
				_sndSelect = null;
			}
			
			// Remove the music track if present
			if (_musTrack != null) {
				_musTrack.stop();
				Session.sound.musicChannel.sources.remove(_musicName);
				_musTrack = null;
			}
			
			Session.sound.reset();
			
			// Remove the option list if present
			if (_optionList != null)
				_optionList = null;
			
			// Remove all layers and their contents
			for (var i=0; i<_gameLayers.length; i++)
				for (var j=0; j<_gameLayers[i].numChildren; j++)
					_gameLayers[i].removeChild(_gameLayers[i].getChildAt(j));
			while (layers.numLayers > 0)
				layers.remove(LAYER_OBJECTS);
			_gameLayers = null;
		} // End Method: dispose
		
		
		
		// Protected Methods
		protected function gotoState(func:Function)					{ Session.timer.create(300, func); }   // Method: gotoState
		
		protected function addGameText(header:String, xPos:Number, yPos:Number, color:uint=0xFFFFFF, size:uint=24, easyRead:Boolean=false, align:String="center"):GameText {   // Start Method: addGameText
			// Add a game text to the screen. The text content, position, text color and font size can be adjusted
			var gameText:GameText = new GameText();
			gameText.x = xPos;
			gameText.y = yPos;
			gameText.text = header
			gameText.color = color;
			gameText.size = size;
			gameText.easyRead = easyRead;
			gameText.align = align;
			primaryLayer.addChild(gameText);
			return gameText;
		} // End Method: addGameText
		
		protected function addMovieClipController(movieClip:MovieClip, xPos:Number, yPos:Number, scale:Number, mirror:Boolean, speed:Number=0):MovieClipController {   // Start Method: addMovieClipController
			// Add a MovieClip linked to a MovieClipController to the screen. The position, scale, mirroring and animation speed can be adjusted
			primaryLayer.addChild(movieClip);
			movieClip.gotoAndStop(0);
			movieClip.x = xPos;
			movieClip.y = yPos;
			if (mirror)
				movieClip.scaleX = -scale;
			else movieClip.scaleX = scale;
			movieClip.scaleY = scale;
			var controller:MovieClipController = new MovieClipController(movieClip, true);
			if (speed > 0)											// Play the animation if it is set to higher than 0
				controller.play(speed);
			else controller.stop();
			return controller;
		} // End Method: addMovieClipController
		
		protected function initMusic(musicName:String, MUSIC_SOURCE:Class):void {   // Start Method: initMusic
			// Make the music track for the screen available for use
			Session.sound.musicChannel.sources.add(musicName, MUSIC_SOURCE);
			_musTrack = Session.sound.musicChannel.get(musicName);
			_musicName = musicName;
		} // End Method: initMusic
		
		protected function loopMusic(volume:Number):void {   // Start Method: loopMusic
			// No need to start or loop music if there is not music present
			if (_musTrack == null)
				return;
			
			if (!_musTrack.isPlaying && music) {					// If music is enabled and the music is not playing, play it!
				_musTrack.play();
				_musTrack.volume = volume;
			}
			else if (_musTrack.isPlaying && !music)					// If music is disabled and the music is playing, stop it!
				_musTrack.stop();
		} // End Method: loopMusic
		
		protected function enableGameTextOptionList():void {   // Start Method: enableGameTextOptionList
			// Enable the option list for further use on the screen, including the used sound effect for it as well
			_optionList = new GameTextOptionList();
			primaryLayer.addChild(_optionList);
			Session.sound.soundChannel.sources.add("Select Option", SOUND_SELECT_OPTION);
			_sndSelect = Session.sound.soundChannel.get("Select Option");
		} // End method: enableGameTextOptionList
		
		protected function playSelectSound():void {   // Start Method: playSelectSound
			// Play the click sound when selecting an option, should sound be enabled
			if (sound) {
				_sndSelect.play();
				_sndSelect.volume = 1;
			}
		} // End Method: playSelectSound
		
	} // End Class: ScreenState
	
} // End Package