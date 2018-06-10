package se.lnu.stickossdk.input {
	
	//--------------------------------------------------------------------------
	// Imports
	//--------------------------------------------------------------------------
	
	import flash.events.Event;
	import flash.ui.GameInput;
	import flash.ui.GameInputControl;
	import flash.ui.GameInputDevice;
	
	//--------------------------------------------------------------------------
	// Public class
	//--------------------------------------------------------------------------
	
	/**
	 *  ...
	 *
	 *  @version    1.0
	 *  @copyright  Copyright (c) 2009-2018.
	 *  @license    Creative Commons (BY-NC-SA)
	 *  @since      May 03, 2018
	 *  @author     Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class GamepadButtonState {
		
		//----------------------------------------------------------------------
		// Private properties
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 *
		 *  @type {Number}
		 */
		private var m_current:Number = 0.0;
		
		/**
		 *  ...
		 *
		 *  @type {Number}
		 */
		private var m_previous:Number = 0.0;
		
		//----------------------------------------------------------------------
		// Public getter and setter methods
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 *
		 *  @type {GameInputDevice}
		 */
		public function get current():Number {
			return this.m_current;
		}
		
		/**
		 *  ...
		 *
		 *  @type {GameInputDevice}
		 */
		public function set current(value:Number):void {
			this.m_previous = this.m_current;
			this.m_current = value;
		}
		
		/**
		 *  ...
		 *
		 *  @type {GameInputDevice}
		 */
		public function get previous():Number {
			return this.m_previous;
		}
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		public function GamepadButtonState() {
			
		}
		
		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		public function dispose():void {
			this.m_current = 0;
			this.m_previous = 0;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		public function justPressed(buttonID:uint):Number {
			return (this.m_previous === 0 && this.m_current > 0) ? 1 : 0;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		public function justReleased(buttonID:uint):Number {
			return (this.m_previous >= 0 && this.m_current === 0) ? 1 : 0;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		public function pressed(buttonID:uint):Number {
			return this.m_current;
		}
	}
}