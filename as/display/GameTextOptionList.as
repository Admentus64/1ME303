/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package display {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.input.Input;
	import se.lnu.stickossdk.input.EvertronInput;
	
	// Project Imports
	import display.GameText;
	
	
	
	public class GameTextOptionList extends GameTextList {   // Start Class: GameTextOptionList
		
		// Getters
		public function get active():uint							{ return _active; }				// Get: active
		public function get choice():String							{ return _list[_active].text; }	// Get: choice
		
		// Setters
		public function set select(select:uint):void {   // Start Set: select
			// Only allow to select an option if it exists in the list
			if (select < 0 || select >= length)
				return;
			
			for (var i=0; i<_list.length; i++)
				_list[i].highlight = false;
			
			_list[select].highlight = true;
			_active = select;
		} // End Set: select
		
		public function set text(text:String) {   // Start Set: text
			_list[_active].text = text;
			_list[_active].highlight = false;
			_list[_active].highlight = true;
		} // End Set: text
		
		
		
		// Private variables
		private var _active = -1;
		
		
		
		public function GameTextOptionList()						{ super(); }			// Constructor: GameTextOptionList
		
		
		
		// Override Public Functions
		override public function update():void {   // Start Method: update
			super.update();
			updateControls();
		} // End Method: update
		
		
		
		// Private Functions
		private function updateControls():void {   // Start Method: updateControls
			// The list is not active if the active value is below 0
			if (_active < 0)
				return;
			
			// Go to the next or previous option in the list when pressing an Up or Down button 
			if (Input.keyboard.justPressed(EvertronInput.PLAYER_1_UP) || Input.keyboard.justPressed(EvertronInput.PLAYER_2_UP))
					select = active-1;
			else if (Input.keyboard.justPressed(EvertronInput.PLAYER_1_DOWN) || Input.keyboard.justPressed(EvertronInput.PLAYER_2_DOWN))
				select = active+1;
		} // End Method: updateControls
		
	} // End Class: GameTextOptionList
	
} // End Package