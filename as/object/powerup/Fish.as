/*
 * File Type:	ActionScript Document
 * Author:		Robert Willem Hallink
 * Application:	Super Cat
 */

package object.powerup {   // Start Package
	
	// Project Imports
	import asset.powerup.FishSmallClip;
	import asset.powerup.FishMediumClip;
	import asset.powerup.FishLargeClip;
	import manager.PowerupManager;
	
	
	
	public class Fish extends Powerup {   // Start Class: Fish
		
		// Getters
		override protected function get scale():Number				{ return 0.25; }   // Get: scale
		
		
		
		public function Fish(manager:PowerupManager) {   // Start Constructor: Fish
			var size = Math.round(Math.random()*2+1);
			var movieClip;
			
			// Set movieclip
			if (size == 1)
				movieClip = new FishSmallClip;
			else if (size == 2)
				movieClip = new FishMediumClip;
			else movieClip = new FishLargeClip;
			
			super(manager, movieClip, scale, 0.5);
			
			// Set energy restoration
			if (size == 1)
				_energy = 25;
			else if (size == 2)
				_energy = 40;
			else _energy = 100;
		} // End Constructor: Fish
		
	} // End Class: Fish
	
} // End Package