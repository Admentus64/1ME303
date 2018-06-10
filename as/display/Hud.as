/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package display {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.display.DisplayStateLayerSprite;
	
	// Flash Imports
	import flash.display.MovieClip;
	
	// Project Imports
	import asset.powerup.DoubleDamageClip;
	import asset.powerup.DoubleScoreClip;
	import asset.hud.ClockClip;
	import asset.hud.ScoreClip;
	import asset.hud.HudBorderClip;
	import state.GameState;
	import display.GameText;
	import util.MovieClipController;
	
	
	
	public class Hud extends DisplayStateLayerSprite {   // Start Class: Hud
		
		// Private Constant Variables (HUD size)
		private const X1:Number = 0;
		private const Y1:Number = 0;
		private const X2:Number = Session.application.size.x;
		private const Y2:Number = 75;
		private const PADDING:Number = 5;
		private const TIMERLENGTH:Number = 100;
		
		// Private Variables
		private var _state:GameState;
		private var _doubleDamageClip:DoubleDamageClip;
		private var _doubleScoreClip:DoubleScoreClip;
		private var _clockClip:ClockClip;
		private var _scoreClip:ScoreClip;
		private var _timeCounter:GameText;
		private var _scoreCounter:GameText;
		private var _hudBorderClip:HudBorderClip = new HudBorderClip();
		
		
		
		public function Hud(state:GameState) {   // Start Constructor: Hud
			_state = state;
			_state.primaryLayer.addChild(_hudBorderClip);
			_state.primaryLayer.addChild(this);
		} // End Constructor: Hud
		
		
		
		// Override Public Functions
		override public function init():void {   // Start Method: init
			super.init();
			
			// The icon for the double damage powerup meter
			_doubleDamageClip = new DoubleDamageClip;
			_doubleDamageClip.width = _doubleDamageClip.height = 32;
			_doubleDamageClip.x = X2 - 375;
			_doubleDamageClip.y = Y2/2;
			
			// The icon for the double score powerup meter
			_doubleScoreClip = new DoubleScoreClip;
			_doubleScoreClip.width = _doubleScoreClip.height = 32;
			_doubleScoreClip.x = X2 - 200;
			_doubleScoreClip.y = Y2/2;
			
			// The icon to represent the playing time
			_clockClip = new ClockClip;
			_clockClip.width = _clockClip.height = 32;
			_clockClip.x = X1 + _clockClip.width + 25;
			_clockClip.y = Y2/2;
			
			// The icon to represent the current score
			_scoreClip = new ScoreClip;
			_scoreClip.width = _scoreClip.height = 32;
			_scoreClip.x = X1 + 250;
			_scoreClip.y = Y2/2;
			
			// Add each icon
			addChild(_doubleDamageClip);
			addChild(_doubleScoreClip);
			addChild(_clockClip);
			addChild(_scoreClip);
			
			// The clock animates too fast, slow it down
			var controller:MovieClipController = new MovieClipController(_clockClip, true);
			controller.play(0.2);
			
			// Initialize the counters for the time and score
			_timeCounter = initCounter(_clockClip.x + 30, 20, _state.counter.time);
			_scoreCounter = initCounter(_scoreClip.x + 30, 20, _state.counter.score.toString());
		} // End Method: init
		
		override public function update():void {   // Start Method: update
			super.update();
			refreshDrawGraphics();
			refreshCounters();
		} // End Method: update
		
		override public function dispose():void	{   // Start Method: dipose
			trace("DISPOSE: Hud");
			_state.primaryLayer.removeChild(_hudBorderClip);
			_state.primaryLayer.removeChild(this);
			removeChild(_timeCounter);
			removeChild(_scoreCounter);
		} // End Method: dispose
		
		
		
		// Private Methods
		private function refreshDrawGraphics():void {   // Start Method: refreshDrawGraphics
			graphics.clear();
			
			// Redraw the powerup meters
			if (_state.powerups != null) {
				drawPowerupTimer(_doubleDamageClip, _state.powerups.doubleDamageDuration, _state.powerups.doubleDamageMaxDuration);
				drawPowerupTimer(_doubleScoreClip, _state.powerups.doubleScoreDuration, _state.powerups.doubleScoreMaxDuration);
			}
			cacheAsBitmap = true;
		} // End Method: refreshDrawGraphics
		
		private function drawGraphics(x1:Number, y1:Number, x2:Number, y2:Number, color:uint):void {   // Start Method: drawGraphics
			graphics.beginFill(color);
			graphics.drawRect(x1, y1, x2, y2);
			graphics.endFill();
		} // End Method: drawGraphics
		
		private function drawPowerupTimer(movieClip:MovieClip, start:uint, total:uint) {   // Start Method: drawPowerupTimer
			drawGraphics(movieClip.x+30-PADDING, movieClip.y-5-PADDING, TIMERLENGTH+PADDING*2, 10+PADDING*2, 0x00FFFF);		// Draw the border of the powerup meter
			drawGraphics(movieClip.x+30, movieClip.y-5, TIMERLENGTH, 10, 0x000000);											// Draw the black inactive meter
			if (start > 0)																									// Draw the green active meter
				drawGraphics(movieClip.x+30, movieClip.y-5, (start/total)*TIMERLENGTH, 10, 0x00FF00);
		} // End Method: drawPowerupTimer
		
		private function initCounter(xPos:Number, yPos:Number, header:String):GameText {   // Start Method: initCounter
			// Set the text format for the counter
			var counter:GameText = new GameText();
			counter.x = xPos;
			counter.y = yPos;
			counter.align = "left";
			counter.text = header;
			counter.size = 30;
			counter.color = 0x000000;
			addChild(counter);
			return counter;
		} // End Method: initCounter
		
		private function refreshCounters():void	{   // Start Method: refreshCounters
			// Retrieve the game duration and score from the counter, only update it if it is changed
			if (_timeCounter.text != _state.counter.time)
				_timeCounter.text = _state.counter.time;
			if (_scoreCounter.text != _state.counter.score.toString())
				_scoreCounter.text = _state.counter.score.toString();
		} // End Method: refreshCounters
		
	} // End Class: Hud
	
} // End Package