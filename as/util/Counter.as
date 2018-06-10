/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package util {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	
	// Project Imports
	import state.GameState;
	
	
	
	public class Counter {   // Start Class: Counter
		
		// Getters
		public function get time():String							{ return _time; }						// Get: time
		public function get seconds():uint							{ return _seconds + _minutes * 60; }	// Get: seconds
		public function get score():uint							{ return _score; }						// Get: score
		
		// Setters
		public function set score(score:uint):void {   // Start Set: score
			if (score <= 0)
				return;
			_score = score;
		} // End Set: score
		
		
		
		// Private Variables
		private var _state:GameState;
		private var _seconds:uint = 0;
		private var _minutes:uint = 0;
		private var _time:String = "00:00";
		private var _score:uint = 0;
		private var _timer:Timer;
		
		
		
		public function Counter(state:GameState) {   // Start Constructor: Counter
			_state = state;
			_timer = Session.timer.create(1000, updateCounter);
		} // End Constructor: Counter
		
		
		
		// Private Methods
		private function updateCounter():void {   // Start Method: updateCounter
			updateScore();
			updateTime();
			_timer.restart();										// Restart
		} // End Method: updateCounter
		
		private function updateScore():void {   // Start Method: updateScore
			if (_state.powerups == null)
				return;
			
			// Score
			if (_state.powerups.doubleScore)
				_score += 2;
			else _score++;
		} // End Method: updateScore
		
		private function updateTime():void {   // Start Method: updateTime
			// Maximal duration is 99 minutes and 59 seconds. Stop there!
			if (_minutes == 99 && _seconds == 59)
				return;
			
			// Time
			_seconds++;
			if (_seconds == 60) {
				_seconds = 0;
				_minutes++;
			}
			
			// Time Text Format
			_time = "";
			if (_minutes < 10)
				_time += "0";
			_time += _minutes.toString() + ":";
			if (_seconds < 10)
				_time += "0";
			_time += _seconds.toString();
		} // End Method: updateTime
		
	} // End Class: Counter
	
} // End Package