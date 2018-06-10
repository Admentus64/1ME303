package se.lnu.stickossdk.input {
	
	//--------------------------------------------------------------------------
	// Imports
	//--------------------------------------------------------------------------
	
	import flash.geom.Point;
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
	public class Gamepad {
		
		//----------------------------------------------------------------------
		// Public properties
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		public var threshold:Number = 0.2;
		
		//----------------------------------------------------------------------
		// Private properties
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private var m_gameInputDevice:GameInputDevice = null;
		
		/**
		 *  ...
		 *
		 *  @type {String}
		 */
		private var m_name:String = "Unknown gamepad device";
		
		/**
		 *  ...
		 *
		 *  @type {String}
		 */
		private var m_id:String = "";
		
		/**
		 *  ...
		 *
		 *  @type {Vector}
		 */
		private var m_LUT:Vector.<GamepadButtonState> = new Vector.<GamepadButtonState>();
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private var m_stickLeft:Point = new Point();
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private var m_stickRight:Point = new Point();
		
		//----------------------------------------------------------------------
		// Public getter and setter methods
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 *
		 *  @type {GameInputDevice}
		 */
		public function get name():String {
			return this.m_name;
		}
		
		/**
		 *  ...
		 *
		 *  @type {GameInputDevice}
		 */
		public function get id():String {
			return this.m_id;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Point}
		 */
		public function get stickLeft():Point {
			var x:Number = this.m_round(this.m_LUT[0].current, 8);
			var y:Number = this.m_round(this.m_LUT[1].current, 8);
			
			this.m_stickLeft.x = (Math.abs(x) > this.threshold) ? x : 0;
			this.m_stickLeft.y = (Math.abs(y) > this.threshold) ? y : 0;
			
			return this.m_stickLeft;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Point}
		 */
		public function get stickRight():Point {
			var x:Number = this.m_round(this.m_LUT[3].current, 8);
			var y:Number = this.m_round(this.m_LUT[4].current, 8);
			
			this.m_stickRight.x = (Math.abs(x) > this.threshold) ? x : 0;
			this.m_stickRight.y = (Math.abs(y) > this.threshold) ? y : 0;
			
			return this.m_stickRight;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickLeftUp():Boolean {
			return (this.m_LUT[1].current < -this.threshold) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickLeftJustUp():Boolean {
			return ((this.m_LUT[1].current < -this.threshold) && (this.m_LUT[1].previous > -this.threshold)) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickLeftDown():Boolean {
			return (this.m_LUT[1].current > this.threshold) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickLeftJustDown():Boolean {
			return ((this.m_LUT[1].current > this.threshold) && (this.m_LUT[1].previous < this.threshold)) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickLeftRight():Boolean {
			return (this.m_LUT[0].current > this.threshold) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {GameInputDevice}
		 */
		public function get stickLeftJustRight():Boolean {
			return ((this.m_LUT[0].current > this.threshold) && (this.m_LUT[0].previous < this.threshold)) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickLeftLeft():Boolean {
			return (this.m_LUT[0].current < -this.threshold) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {GameInputDevice}
		 */
		public function get stickLeftJustLeft():Boolean {
			return ((this.m_LUT[0].current < -this.threshold) && (this.m_LUT[0].previous > -this.threshold)) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickRightUp():Boolean {
			return (this.m_LUT[4].current < -this.threshold) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {GameInputDevice}
		 */
		public function get stickRightJustUp():Boolean {
			return ((this.m_LUT[4].current < -this.threshold) && (this.m_LUT[3].previous > -this.threshold)) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {GameInputDevice}
		 */
		public function get stickRightDown():Boolean {
			return (this.m_LUT[4].current > this.threshold) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {GameInputDevice}
		 */
		public function get stickRightJustDown():Boolean {
			return ((this.m_LUT[4].current > this.threshold) && (this.m_LUT[4].previous < this.threshold)) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickRightLeft():Boolean {
			return (this.m_LUT[3].current < -this.threshold) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {GameInputDevice}
		 */
		public function get stickRightJustLeft():Boolean {
			return ((this.m_LUT[3].current < -this.threshold) && (this.m_LUT[3].previous > -this.threshold)) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickRightRight():Boolean {
			return (this.m_LUT[3].current > this.threshold) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {GameInputDevice}
		 */
		public function get stickRightJustRight():Boolean {
			return ((this.m_LUT[3].current > this.threshold) && (this.m_LUT[3].previous < this.threshold)) ? true : false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {GameInputDevice}
		 */
		public function get gameInputDevice():GameInputDevice {
			return this.m_gameInputDevice;
		}
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		public function Gamepad(gameInputDevice:GameInputDevice = null) {
			this.m_gameInputDevice = gameInputDevice;
			this.m_initInputs();
			this.m_initLUT();
		}
		
		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		public function justPressed(buttonID:int):Number {
			if (this.m_isValidLookUp(buttonID)) {
				return this.m_LUT[buttonID].justPressed(buttonID);
			}
			
			return 0;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		public function justReleased(buttonID):Number {
			if (this.m_isValidLookUp(buttonID)) {
				return this.m_LUT[buttonID].justReleased(buttonID);
			}
			
			return 0;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		public function pressed(buttonID:uint):Number {
			if (this.m_isValidLookUp(buttonID)) {
				return this.m_LUT[buttonID].pressed(buttonID);
			}
			
			return 0;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		public function reset():void {
			this.m_disposeLUT();
			this.m_initLUT();
		}
		
		//----------------------------------------------------------------------
		// Internal methods
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		internal function update():void {
			this.m_updateInputs();
			this.m_updateInfoCache();
		}
		
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_initInputs():void {
			if (this.m_gameInputDevice != null) {
				this.m_gameInputDevice.enabled = true;
			}
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_initLUT():void {
			if (this.m_gameInputDevice != null) {
				this.m_LUT = new Vector.<GamepadButtonState>(this.m_gameInputDevice.numControls, true);
				for (var i:int = 0; i < this.m_gameInputDevice.numControls; i++) {
					this.m_LUT[i] = new GamepadButtonState();
				}
			}
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_updateInputs():void {
			if (this.m_gameInputDevice != null) {
				for (var i:int = 0; i < this.m_gameInputDevice.numControls; i++) {
					this.m_LUT[i].current = this.m_gameInputDevice.getControlAt(i).value;
				}
			}
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_updateInfoCache():void {
			if (this.m_gameInputDevice != null) {
				this.m_id = this.m_gameInputDevice.id;
				this.m_name = this.m_gameInputDevice.name;
			}
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_disposeInputs():void {
			if (this.m_gameInputDevice != null) {
				this.m_gameInputDevice.enabled = false;
				this.m_gameInputDevice = null;
			}
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_disposeLUT():void {
			for (var i:int = 0; i < this.m_LUT.length; i++) {
				this.m_LUT[i].dispose();
				this.m_LUT[i] = null;
			}			
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_isValidLookUp(index):Boolean {
			if (this.m_LUT.length > index && this.m_LUT[index] != null) return true;
			else return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_round(num:Number, decimals:int):Number {
			var m:int = Math.pow(10, decimals);
			return Math.round(num * m) / m;
		}
	}
}

