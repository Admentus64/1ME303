/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package util {   // Start Package
	
	// Flash Imports
	import flash.display.MovieClip;
	import flash.events.Event;
	
	
	
	public class MovieClipController {   // Start Class: MovieClipController
		
		// Getters
		public function get speed():Number							{ return _speed; }				// Get: speed
		public function get isPlaying():Boolean						{ return _playing; }			// Get: isPlaying
		public function get visible():Boolean						{ return _movieClip.visible; }	// Get: visible
		public function get alpha():Number							{ return _movieClip.alpha; }	// Get: alpha
		public function get movieClip():MovieClip					{ return _movieClip; }			// Get: movieClip
		
		// Setters
		public function set visible(visible:Boolean):void			{ _movieClip.visible = visible; } // Set: visible
		
		public function set alpha(alpha:Number):void {   // Set Set: alpha
			if (alpha < 0 || alpha > 1)
				return
			_movieClip.alpha = alpha;
		} // End Set: alpha
		
		
		
		// Private Variables
		private var _movieClip:MovieClip;
		private var _playing:Boolean;
		private var _speed:Number;
		private var _currentFrame:Number;
		private var _loop:Boolean
		
		
		
		public function MovieClipController(movieClip:MovieClip, loop:Boolean=true) {   // Start Constructor: MovieClipController
			_movieClip = movieClip;
			_loop = loop;
			_movieClip.stop();
			_currentFrame = _movieClip.currentFrame;
		} // End Constructor: MovieClipController
		
		
		
		// Public Methods
		public function play(speed:Number=1):void {   // Start Method: play
			// Start playing the movieclip on the chosen speed
			if (!_playing)
				_movieClip.addEventListener(Event.ENTER_FRAME, handleEnterFrame);
			_playing = true;
			_speed = speed;
		} // End Method: play
		
		public function stop():void {   // Start Method: stop
			// Stop playing the movieclip
			if (_playing)
				_movieClip.removeEventListener(Event.ENTER_FRAME, handleEnterFrame);
			_playing = false;
			_movieClip.stop();
        } // End Method: stop
		
		public function gotoAndStop(frame:uint):void {   // Start Method: gotoAndStop
			// Stop the movieclip and stop it at a specific frame
			stop();
			_movieClip.gotoAndStop(frame);
			_currentFrame = frame;
		} // End Method: gotoAndStop
		
		
		
		// Private Methods
		private function handleEnterFrame(e:Event):void {   // Start Method: handleEnterFrame
			// Select the next frame based on how fast it should animate
			if (_playing) {
				_currentFrame += _speed;
				_movieClip.gotoAndStop(Math.round(_currentFrame % _movieClip.totalFrames));
				// Stop the animation if a loop has ended and when only one loop should run
				if (!_loop && _currentFrame == _movieClip.totalFrames)
					stop();
			}
		} // End Method: handleEnterFrame
		
	} // End Class: MovieClipController
	
} // End Package