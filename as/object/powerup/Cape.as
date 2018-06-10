/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.powerup {   // Start Package
	
	// Project Imports
	import asset.powerup.CapeClip;
	import manager.PowerupManager;
	
	
	
	public class Cape extends Powerup {   // Start Class: Cape
		
		// Getters
		override protected function get scale():Number				{ return 0.8; }   // Get: scale
		
		
		
		public function Cape(manager:PowerupManager)				{ super(manager, new CapeClip, scale, 0.5); }   // Constructor: Cape
		
	} // End Class: Cape
	
} // End Package