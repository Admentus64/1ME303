/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package manager {   // Start Package
	
	// StickOS Imports
	import se.lnu.stickossdk.system.Session;
	import se.lnu.stickossdk.input.EvertronControls;
	
	// Flash Imports
	import flash.display.Sprite;
	
	// Project Imports
	import state.GameState;
	import manager.ArrowManager;
	import object.player.Cat;
	import object.player.Dog;
	
	
	
	public class PlayerManager extends EntityManager {   // Start Class: PlayerManager
		
		// Getters
		override public function get layer():Sprite					{ return _state.layerList[3]; }		// Get: layer
		public function get arrows():ArrowManager					{ return _arrows; }					// Get: arrows
		
		
		
		// Private Variables
		private var _arrows:ArrowManager;
		
		
		
		public function PlayerManager(state:GameState) {   // Start Constructor: PlayerManager
			super(state);
			_objects = new Vector.<Cat>();
			_arrows = new ArrowManager(state);
			
			if (_state.coop) {
				add(75, new EvertronControls(0));
				add(200, new EvertronControls(1));
			}
			else add(75, new EvertronControls(0));
		} // End Contructor: PlayerManager
		
		
		
		
		// Override Public Methods
		override public function dispose():void	{   // Start Method: dispose
			_arrows.dispose();
			super.dispose();
		} // End Method: dispose
		
		
		
		// Public Methods
		public function restore(player:uint) {   // Start Method: restore
			// Restore the player that has died, giving the proper controls back
			if (player == 0)
				add(75, new EvertronControls(0));
			else if (player == 1)
				add(200, new EvertronControls(1));
		} // End Method: restore
		
		public function add(xPos:int, controls:EvertronControls):void {   // Start Method: add
			// Add a new player with a control set and place it on the screen
			var player:Cat;
			if (controls.player == 0)
				player = push(new Cat(this, controls));
			else player = push(new Dog(this, controls));
			player.x = xPos;
			player.y = (Session.application.size.y >> 1) - (player.height >> 1);	// Should be around halfway
		} // End Method: add
		
	} // End Class: PlayerManager
	
} // End Package