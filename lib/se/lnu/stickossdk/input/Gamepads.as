package se.lnu.stickossdk.input {
	
	//--------------------------------------------------------------------------
	// Imports
	//--------------------------------------------------------------------------
	
	import flash.events.GameInputEvent;
	import flash.ui.GameInput;
	import flash.utils.setTimeout;
	
	import se.lnu.stickossdk.system.Session;
	
	//--------------------------------------------------------------------------
	// Public class
	//--------------------------------------------------------------------------
	
	/**
	 *  Representerar anslutna och aktiva gamepads.
	 *
	 *  @version    1.0
	 *  @copyright  Copyright (c) 2009-2018.
	 *  @license    Creative Commons (BY-NC-SA)
	 *  @since      May 23, 2018
	 *  @author     Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Gamepads {
		
		//----------------------------------------------------------------------
		// Private properties
		//----------------------------------------------------------------------
		
		/**
		 *  Adobes API för spelkontroller. Skapar en instans för att kontrollera 
		 *	när kontroller kopplas till och från.
		 *
		 *  @type {GameInput}
		 */
		private var m_gameInput:GameInput = new GameInput();
		
		/**
		 *  Huruvida StickOS får skriva ut notifikationer när kontroller 
		 *	ansluts och kopplas från
		 *
		 *  @type {Boolean}
		 */
		private var m_notificationsEnabled:Boolean;
		
		/**
		 *  Lista innehållande anslutna kontroller. Kontroller representeras 
		 *	av Gamepad-objekt
		 *
		 *  @type {Vector}
		 */
		private var m_gamepads:Vector.<Gamepad> = new Vector.<Gamepad>();
		
		//----------------------------------------------------------------------
		// Private static cosntants
		//----------------------------------------------------------------------
		
		/**
		 *  Fördröjning innan StickOS får visa notifikationer
		 *
		 *  @type {int}
		 */
		private static const INIT_DELAY_TIME:int = 1000;
		
		//----------------------------------------------------------------------
		// Public getter and setter methods
		//----------------------------------------------------------------------
		
		/**
		 *  Referens till den första kontroll att anslutas
		 *
		 *  @type {Gamepad}
		 */
		public function get one():Gamepad {
			return (this.m_gamepads.length > 0) ? this.m_gamepads[0] : new Gamepad(null);
		}
		
		/**
		 *   Referens till den andra kontroll att anslutas
		 *
		 *  @type {Gamepad}
		 */
		public function get two():Gamepad {
			return (this.m_gamepads.length > 1) ? this.m_gamepads[1] : new Gamepad(null);
		}
		
		/**
		 *   Referens till den tredje kontroll att anslutas
		 *
		 *  @type {Gamepad}
		 */
		public function get three():Gamepad {
			return (this.m_gamepads.length > 2) ? this.m_gamepads[2] : new Gamepad(null);
		}
		
		/**
		 *   Referens till den fjärde kontroll att anslutas
		 *
		 *  @type {Gamepad}
		 */
		public function get four():Gamepad {
			return (this.m_gamepads.length > 3) ? this.m_gamepads[3] : new Gamepad(null);
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickLeftUp():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickLeftUp) return true;
			}
			
			return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickLeftJustUp():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickLeftJustUp) return true;
			}
			
			return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickLeftRight():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickLeftRight) return true;
			}
			
			return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickLeftJustRight():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickLeftJustRight) return true;
			}
			
			return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickLeftDown():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickLeftDown) return true;
			}
			
			return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickLeftJustDown():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickLeftJustDown) return true;
			}
			
			return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickLeftLeft():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickLeftLeft) return true;
			}
			
			return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickLeftJustLeft():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickLeftJustLeft) return true;
			}
			
			return false;
		}
			
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickRightUp():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickRightUp) return true;
			}
			
			return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickRightJustUp():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickRightJustUp) return true;
			}
			
			return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickRightRight():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickRightRight) return true;
			}
			
			return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickRightJustRight():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickRightJustRight) return true;
			}
			
			return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickRightDown():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickRightDown) return true;
			}
			
			return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickRightJustDown():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickRightJustDown) return true;
			}
			
			return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickRightLeft():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickRightLeft) return true;
			}
			
			return false;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Boolean}
		 */
		public function get stickRightJustLeft():Boolean {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (this.m_gamepads[i].stickRightJustLeft) return true;
			}
			
			return false;
		}
		
		//----------------------------------------------------------------------
		// Constructor method
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 */
		public function Gamepads() {
			this.m_initEvents();
			this.m_initDevices();
			this.m_initNotifications();
		}
		
		//----------------------------------------------------------------------
		// Public methods
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 * 
		 *	@param {uint} ButtonID ID för aktuell knapp
		 *
		 *  @return {Number}
		 */
		public function justPressed(buttonID:uint):Number {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				var gamepad:Gamepad = this.m_gamepads[i];
				var input:Number = gamepad.justPressed(buttonID);
				if (input > 0) return input;
			}
				
			return 0;
		}
		
		/**
		 *  ...
		 * 
		 *	@param {uint} ButtonID ID för aktuell knapp
		 *
		 *  @return {Number}
		 */
		public function justReleased(buttonID:uint):Number {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				var gamepad:Gamepad = this.m_gamepads[i];
				var input:Number = gamepad.justReleased(buttonID);
				if (input > 0) return input;
			}
			
			return 0;
		}
		
		/**
		 *  ...
		 * 
		 *	@param {uint} ButtonID ID för aktuell knapp
		 *
		 *  @return {Number}
		 */
		public function pressed(buttonID:uint):Number {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				var gamepad:Gamepad = this.m_gamepads[i];
				var input:Number = gamepad.pressed(buttonID);
				if (input > 0) return input;
			}
			
			return 0;
		}
		
		/**
		 *  Nollställer samtliga kontrollers input.
		 *
		 *  @return {void}
		 */
		public function reset():void {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				this.m_gamepads[i].reset();
			}
		}
		
		/**
		 *  ...
		 * 
		 *	@param {int} gamepadID ID till den kontroll som efterfrågas
		 *
		 *  @return {Gamepad}
		 */
		public function requestGamepad(gamepadID:int):Gamepad {
			gamepadID = Math.min(gamepadID, this.m_gamepads.length - 1);
			gamepadID = Math.max(gamepadID, 0);
			
			return this.m_gamepads[gamepadID];
		}
		
		//----------------------------------------------------------------------
		// Internal methods
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 *
		 *  @return {void}
		 */
		internal function update():void {
			this.m_updateDevices();
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		internal function dispose():void {
			this.m_disposeEvents();
		}
		
		//----------------------------------------------------------------------
		// Private methods
		//----------------------------------------------------------------------
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_initEvents():void {
			this.m_gameInput.addEventListener(GameInputEvent.DEVICE_ADDED, this.m_onGamepadConnected);
			this.m_gameInput.addEventListener(GameInputEvent.DEVICE_REMOVED, this.m_onGamepadDisconnected);
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_initDevices():void {
			for (var i:int = 0; i < GameInput.numDevices; i++) {
				this.m_gamepads.push(GameInput.getDeviceAt(i));
			}
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_initNotifications():void {
			setTimeout(this.m_enableNotifications, INIT_DELAY_TIME);
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_enableNotifications():void {
			this.m_notificationsEnabled = true;
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_updateDevices():void {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				this.m_gamepads[i].update();
			}
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_disposeEvents():void {
			this.m_gameInput.removeEventListener(GameInputEvent.DEVICE_ADDED, this.m_onGamepadConnected);
			this.m_gameInput.removeEventListener(GameInputEvent.DEVICE_REMOVED, this.m_onGamepadDisconnected);
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_onGamepadConnected(event:GameInputEvent):void {
			var gamepad:Gamepad = new Gamepad(event.device);
			if (this.m_isGamepadConnected(gamepad) === -1) {
				this.m_gamepads.push(gamepad);
				if (this.m_notificationsEnabled === true) {
					Session.application.notices.show("Gamepad Connected", event.device.name);
				}
			}
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_onGamepadDisconnected(event:GameInputEvent):void {
			var gamepad:Gamepad = new Gamepad(event.device);
			var i:int = this.m_isGamepadConnected(gamepad);
			if (i > -1) {
				if (this.m_notificationsEnabled === true) {
					Session.application.notices.show("Gamepad disconnected", this.m_gamepads[i].name);
				}
				
				this.m_gamepads.splice(i, 1);
			}
		}
		
		/**
		 *  ...
		 *
		 *  @type {Array}
		 */
		private function m_isGamepadConnected(gamepad:Gamepad):int {
			for (var i:int = 0; i < this.m_gamepads.length; i++) {
				if (gamepad.gameInputDevice.id === this.m_gamepads[i].gameInputDevice.id) {
					return i;
				}
			}
			
			return -1;
		}
	}
}