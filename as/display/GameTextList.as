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
	import flash.utils.getQualifiedClassName;
	
	// Project Imports
	import asset.screen.TextBorderClip;
	import display.GameText;
	
	
	
	public class GameTextList extends DisplayStateLayerSprite {   // Start Class: GameTextList
		
		// Getters
		public function get list():Vector.<GameText>				{ return _list; }			// Get: list
		public function get length():uint							{ return _list.length; }	// Get: length
		public function get columns():uint							{ return _columns; }		// Get: columns
		public function get columnWidth():Number					{ return _columnWidth; }	// Get: columnWidth
		public function get rowHeight():Number						{ return _rowHeight; }		// Get: rowHeight
		
		// Setters
		public function set columns(amount:uint):void {   // Start Set: columns
			if (amount < 1)
				return;
			_columns = amount;
			x = Session.application.size.x/2 - width/2 - _columnWidth/2;
			alignListContent();
		} // End Set: columns
		
		public function set columnWidth(size:Number):void {   // Start Set: columnWidth
			if (size < 1)
				return;
			_columnWidth = size;
			alignListContent();
		} // End Set: columnWidth
		
		public function set rowHeight(size:Number):void {   // Start Set: rowHeight
			if (size < 1)
				return;
			_rowHeight = size;
			alignListContent();
		} // End Set: rowHeight
		
		public function set fontSize(size:uint):void {   // Start Set: fontSize
			if (size < 1)
				return;
			for each (var gameText:GameText in _list) 
				gameText.size = size; 
		} // End Set: fontSize
		
		
		
		// Protected Variables
		protected var _list:Vector.<GameText> = new Vector.<GameText>();
		
		// Private Variables
		private var _columns:uint = 1;
		private var _columnWidth:Number = 220;
		private var _rowHeight:Number = 50;
		private var _textBorderClip:TextBorderClip = null;
		
		
		
		public function GameTextList()								{ x = Session.application.size.x/2 - width/2; }	// Constructor: TextList
		
		
		
		// Override Public Methods
		override public function dispose():void	{   // Start Method: dispose
			super.dispose();
			trace("DISPOSE: " +  getQualifiedClassName(this).slice(getQualifiedClassName(this).lastIndexOf("::") + 2));
			empty();
			_list = null;
		} // End Method: dispose
		
		
		
		// Public Methods
		public function get(index:uint):GameText {   // Start Method: get
			// Retrieve a GameText object from the GameTextList object
			if (index < 0 || index >= length)
				return null;
			return _list[index];
		} // End Method: get
		
		public function replaceFontSize(oldSize:uint, newSize):void {   // Start Method: replaceFontSize
			// Replace every GameText object with a specific font size to the new font size
			if (oldSize < 1 || newSize < 1)
				return;
			for each (var gameText:GameText in _list)
				if (gameText.size == oldSize)
					gameText.size = newSize;
		} // End Method: replaceFontSize
		
		public function addTitle(text:String, align:String="center", easyRead:Boolean=false, color:uint=0xFFFFFF):GameText {   // Start Method: addTitle
			// Add a new GameText to the GameTextList, using parameters suitable for a title
			var gameText:GameText = new GameText();
			gameText.text = text;
			gameText.easyRead = easyRead;
			gameText.align = align;
			gameText.color = color;
			_list.push(gameText);
			addChild(_list[length-1]);
			alignListContent();
			return gameText;
		} // End Method: addTitle
		
		public function addDescription(text:String, align:String="center", easyRead:Boolean=false, color:uint=0xFFFFFF):GameText {   // Start Method: addDescription
			// Add a new GameText to the GameTextList, using parameters suitable for a description
			var gameText:GameText = addTitle(text, align, easyRead, color);
			gameText.size = 13;
			return gameText;
		} // End Method: addDescription
		
		public function empty():void {   // Start Method: empty
			// Remove all GameText objects from the GameTextList
			if (length == 0)
				return;
			
			while (length > 0) {
				removeChild(_list[0]);
				_list.removeAt(0);
			}
			
			clearBorder();
		} // End Method: empty
		
		public function drawBorder(yPos:Number, xScale:Number, yScale:Number):void {   // Start Method: drawBorder
			// Draw a cloud-based graphics border around the GameTextList, but first clear it if it exists already
			clearBorder();
			_textBorderClip = new TextBorderClip();
			addChild(_textBorderClip);
			setChildIndex(_textBorderClip, 0);
			_textBorderClip.x = 0;
			_textBorderClip.y = yPos;
			_textBorderClip.scaleX = xScale;
			_textBorderClip.scaleY = yScale;
		} // End Method: drawBorder
		
		public function clearBorder():void {   // Start Method: clearBorder
			// Remove the cloud-based graphics border around the GameTextList if it exists
			if (_textBorderClip == null)
				return;
			
			removeChild(_textBorderClip);
			_textBorderClip = null;
		} // End Method: clearBorder
		
		
		
		// Private Methods
		private function alignListContent():void {   // Start Method: alignListContent
			// Align the position of each GameText object
			if (length == 0)
				return;
			
			// Checking where a new column should start
			var i:uint, j:uint;
			var arr:Array = new Array();
			for (i=0; i<_columns; i++)
				if (i < _list.length)
					arr.push(Math.ceil(_list.length/_columns*i));
			
			var currentColumn:uint = 0;
			
			// Go through each GameText object and place it below the previous GameText object
			for (i=0; i<_list.length; i++) {
				if (i > 0)
					_list[i].y = _list[i-1].y + _rowHeight;
				for (j=0; j<arr.length; j++)						// Go through each position a new column should start
					if (i == arr[j]) {								// Place the next GameText object on the top rather than below the previous GameText Object
						_list[i].y = 0;
						currentColumn++;
					}
				_list[i].x = (currentColumn-1) * _columnWidth;		// Place the next GameText object on the column it should belong to
			}
		} // End Method: alignListContent
		
	} // End Class: GameTextList
	
} // End Package