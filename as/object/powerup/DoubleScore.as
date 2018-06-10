/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.powerup {   // Start Package
	
	// Project Imports
	import asset.powerup.DoubleScoreClip;
	import manager.PowerupManager;
	
	
	
	public class DoubleScore extends Powerup {   // Start Class: DoubleScore
		
		// Getters
		public static function get duration():uint					{ return _duration; }									// Get: duration
		public static function get maxDuration():uint				{ return 20 * 60; }										// Get: maxDuration
		public static function get active():Boolean					{ return (_duration != 0); }							// Get: active
		override protected function get scale():Number				{ return 0.3; }											// Get: scale
		
		
		
		// Private Static Variables
		private static var _duration = 0;
		private static const MAX_DURATION = 20;
		
		
		
		public function DoubleScore(manager:PowerupManager)			{ super(manager, new DoubleScoreClip, scale, 1); }		// Constructor: DoubleScore
		
		
		
		// Public Methods
		override public function activate():void					{ _duration = MAX_DURATION * 60; }						// Method: activate
		
		public static function decrement():void {   // Start Method: decrement
			if (active)
				_duration--;
		} // End Method: decrement
		
	} // End Class: DoubleScore
	
} // End Package