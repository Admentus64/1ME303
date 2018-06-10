/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package manager {   // Start Package
	
	// Flash Imports
	import flash.display.Sprite;
	
	// Project Imports
	import state.GameState;
	import object.player.Cat;
	import object.player.Arrow;
	
	
	
	public class ArrowManager extends EntityManager {   // Start Class: ArrowManager
		
		// Getters
		override public function get layer():Sprite					{ return _state.layerList[3]; }		// Get: layer
		
		
		
		public function ArrowManager(state:GameState) {   // Start Constructor: ArrowManager
			super(state);
			_objects = new Vector.<Arrow>();
		} // End Constructor: ArrowManager
		
		
		
		// Public Methods
		public function add(player:Cat):void						{ push(new Arrow(this, player)); }	// Method: add
		
	} // End Class: ArrowManager
	
} // End Package