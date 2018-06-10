/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package display {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.timer.Timer;
	
	// Flash Imports
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	
	// Project Imports
	import asset.screen.TextBorderClip;
	
	
	
	public class GameText extends Sprite {   // Start Class: GameText
		
		// Getters
		public function get text():String							{ return _textField.text; }			// Get: text
		public function get easyRead():Boolean						{ return _easyRead; }				// Get: easyRead
		public function get color():uint							{ return _color; }					// Get: color
		public function get size():uint								{ return _size; }					// Get: size
		public function get align():String							{ return _align.toUpperCase(); }	// Get: align
		
		// Setters
		public function set text(text:String):void {   // Start Set: text
			_textField.text = text;
			_textField.setTextFormat(getTextFormat()); }
		// End Set: text
		
		public function set easyRead(easyRead:Boolean):void {   // Start Set: easyRead
			_easyRead = easyRead
			_textField.setTextFormat(getTextFormat());
		} // End Set: easyRead
		
		public function set color(color:uint):void {   // Start Set: color
			_color = color;
			_lastColor = _color;
			_textField.setTextFormat(getTextFormat());
		} // End Set: color
		
		public function set size(size:uint):void {   // Start Set: size
			if (size < 1)
				return;
			_size = size;
			_textField.setTextFormat(getTextFormat());
		} // End Set: size
		
		public function set highlight(highlight:Boolean):void {   // Start Set: highlight
			if (highlight) {
				_lastColor = _color;
				_color = 0x000000;
				startAnimate(24, 34);
			}
			else {
				_color = _lastColor;
				stopAnimate();
			}
			_textField.setTextFormat(getTextFormat());
		} // End Set: highlight
		
		public function set align(align:String):void {   // Start Set: align
			if (align != "center" && align != "left" && align != "right" && align != "justify" && align != "start" && align != "end")
				return;
			
			_align = align;
			_textField.setTextFormat(getTextFormat());
			
			if (_align == "center")
				_textField.autoSize	= TextFieldAutoSize.CENTER;
			else if (_align == "left")
				_textField.autoSize	= TextFieldAutoSize.LEFT;
			else if (_align == "right")
				_textField.autoSize	= TextFieldAutoSize.RIGHT;
			else _textField.autoSize = TextFieldAutoSize.NONE;
		} // End Set: align
		
		
		
		// Private Constant Variables
		private static const TEXT_FONT_REGULAR:String = "regular";
		private static const TEXT_FONT_EASYREAD:String = "easyRead";
		private static const TEXT_LEADING:uint = 8;
		
		// Private Variables
		private var _textField:TextField = null;
		private var _textBorderClip:TextBorderClip = null;
		private var _size:uint = 24;
		private var _lastSize:uint = 24;
		private var _minSize:uint = 24;
		private var _maxSize:uint = 34;
		private var _easyRead:Boolean = false;
		private var _color:uint = 0xFFFFFF;
		private var _lastColor:uint = 0xFFFFFF;
		private var _align:String = "center";
		private var _makeBigger:Boolean = false;
		private var _timer:Timer = null;
		
		
		
		public function GameText() {   // Start Constructor: GameText
			initTextField();
			cacheAsBitmap = true;
		} // End Constructor GameText
		
		
		
		// Public Methods
		public function drawBorder(xScale:Number, yScale:Number):void {   // Start Method: drawBorder
			// Draw a cloud-based graphics border around the gametext. Remove and clear it before drawing a new one
			clearBorder();
			_textBorderClip = new TextBorderClip();
			addChild(_textBorderClip);
			setChildIndex(_textBorderClip, 0);
			_textBorderClip.x = 0;
			_textBorderClip.y = (_textField.height/2) - 10;
			_textBorderClip.scaleX = xScale;
			_textBorderClip.scaleY = yScale;
		} // End Method: drawBorder
		
		public function clearBorder():void {   // Start Method: clearBorde
			// Remove the cloud-based graphics border around the gametext if it exists
			if (_textBorderClip == null)
				return;
			
			removeChild(_textBorderClip);
			_textBorderClip = null;
		} // End Method: clearBorder
		
		public function startAnimate(minSize:Number, maxSize:Number, interval:uint=50):void {   // Start Method: startAnimate
			// Animation effect to make the text bigger and then smaller, and to do the cycle over. It needs a maximum and minimum size to resize between
			stopAnimate();
			_lastSize = _size;
			_minSize = minSize;
			_maxSize = maxSize;
			size = _maxSize;
			_timer = Session.timer.create(interval, runAnimation);
		} // End Method: startAnimate
		
		public function stopAnimate():void {   // Start Method: stopAnimate
			// Stop the resizing animation effect and get the last text size
			if (_timer == null)
				return;
			
			size = _lastSize;
			_timer.stop();
			_timer = null;
		} // End Method: stopAnimate
		
		
		
		// Private Methods
		private function runAnimation():void {   // Start Method: runAnimation
			// Used in the startAnimate method and takes care of the actual resizing. Each method call resizes with one pixel
			if (_makeBigger && size < _maxSize)
				size = _size + 1;
			if (!_makeBigger && size > _minSize)
				size = _size - 1;
			
			if (size == _maxSize)
				_makeBigger = false;
			else if (size == _minSize)
				_makeBigger = true;
			
			_timer.restart();
		} // End Method: runAnimation
		
		private function initTextField():void {   // Start Method: initTextField
			// Called when creating a new instance, get the default values right
			_textField = new TextField();
			_textField.defaultTextFormat	= getTextFormat();
			_textField.embedFonts			= true;
			_textField.selectable			= false;
			_textField.autoSize				= TextFieldAutoSize.CENTER;
			_textField.x = _textField.y		= 0;
			addChild(_textField);
		} // End Method: initTextField
		
		private function getTextFormat():TextFormat {   // Start Method: getTextFormat
			// Called each time when the text format changes
			var textFormat:TextFormat = new TextFormat();
			textFormat.align		= _align;
			if (_easyRead)
				textFormat.font   	= TEXT_FONT_EASYREAD;
			else textFormat.font   	= TEXT_FONT_REGULAR;
			textFormat.leading 		= TEXT_LEADING;
			textFormat.size    		= _size;
			textFormat.color		= _color;
			return textFormat;
		} // End Method: getTextFormat
		
	} // End Class: GameText
	
} // End Package