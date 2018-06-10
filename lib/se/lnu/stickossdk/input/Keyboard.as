package se.lnu.stickossdk.input
{
	//-----------------------------------------------------------
	// Import
	//-----------------------------------------------------------
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	//-----------------------------------------------------------
	// Public class
	//-----------------------------------------------------------
	
	/**
	 *	Keyboard är en klass för att hantera 
	 *	tangentbordsinmatningar. Klassen har möjlighet att 
	 *	registrera upp till sex simultana inmatningar. Samtliga 
	 *	tangentbordstangenter finns representerade i klassen.
	 *
	 *	@version	1.0
	 *	@copyright	Copyright (c) 2012-2014.
	 *	@license	Creative Commons (BY-NC-SA)
	 *	@since		2014-01-23
	 *	@author		Henrik Andersen <henrik.andersen@lnu.se>
	 */
	public class Keyboard extends InputBase
	{
		//-------------------------------------------------------
		// Public properties
		//-------------------------------------------------------
		
		/**
		 *	Register över tillgängliga knappar. 
		 */
		public var ESCAPE:Boolean;
		public var F1:Boolean;
		public var F2:Boolean;
		public var F3:Boolean;
		public var F4:Boolean;
		public var F5:Boolean;
		public var F6:Boolean;
		public var F7:Boolean;
		public var F8:Boolean;
		public var F9:Boolean;
		public var F10:Boolean;
		public var F11:Boolean;
		public var F12:Boolean;
		public var ONE:Boolean;
		public var TWO:Boolean;
		public var THREE:Boolean;
		public var FOUR:Boolean;
		public var FIVE:Boolean;
		public var SIX:Boolean;
		public var SEVEN:Boolean;
		public var EIGHT:Boolean;
		public var NINE:Boolean;
		public var ZERO:Boolean;
		public var NUMPADONE:Boolean;
		public var NUMPADTWO:Boolean;
		public var NUMPADTHREE:Boolean;
		public var NUMPADFOUR:Boolean;
		public var NUMPADFIVE:Boolean;
		public var NUMPADSIX:Boolean;
		public var NUMPADSEVEN:Boolean;
		public var NUMPADEIGHT:Boolean;
		public var NUMPADNINE:Boolean;
		public var NUMPADZERO:Boolean;
		public var PAGEUP:Boolean;
		public var PAGEDOWN:Boolean;
		public var HOME:Boolean;
		public var END:Boolean;
		public var INSERT:Boolean;
		public var MINUS:Boolean;
		public var NUMPADMINUS:Boolean;
		public var PLUS:Boolean;
		public var NUMPADPLUS:Boolean;
		public var DELETE:Boolean;
		public var BACKSPACE:Boolean;
		public var TAB:Boolean;
		public var Q:Boolean;
		public var W:Boolean;
		public var E:Boolean;
		public var R:Boolean;
		public var T:Boolean;
		public var Y:Boolean;
		public var U:Boolean;
		public var I:Boolean;
		public var O:Boolean;
		public var P:Boolean;
		public var LBRACKET:Boolean;
		public var RBRACKET:Boolean;
		public var BACKSLASH:Boolean;
		public var CAPSLOCK:Boolean;
		public var A:Boolean;
		public var S:Boolean;
		public var D:Boolean;
		public var F:Boolean;
		public var G:Boolean;
		public var H:Boolean;
		public var J:Boolean;
		public var K:Boolean;
		public var L:Boolean;
		public var SEMICOLON:Boolean;
		public var QUOTE:Boolean;
		public var ENTER:Boolean;
		public var SHIFT:Boolean;
		public var Z:Boolean;
		public var X:Boolean;
		public var C:Boolean;
		public var V:Boolean;
		public var B:Boolean;
		public var N:Boolean;
		public var M:Boolean;
		public var COMMA:Boolean;
		public var PERIOD:Boolean;
		public var NUMPADPERIOD:Boolean;
		public var SLASH:Boolean;
		public var NUMPADSLASH:Boolean;
		public var CONTROL:Boolean;
		public var ALT:Boolean;
		public var SPACE:Boolean;
		public var UP:Boolean;
		public var DOWN:Boolean;
		public var LEFT:Boolean;
		public var RIGHT:Boolean;
		
		//-------------------------------------------------------
		// Private static constants
		//-------------------------------------------------------
		
		/**
		 *	Antalet tangenter som klassen hanterar.
		 * 
		 *	@default 256
		 */
		private const TOTAL_NUMBER_OF_KEYBOARD_KEYS:uint = 256;
		
		//-------------------------------------------------------
		// Constructor method
		//-------------------------------------------------------
		
		/**
		 *	The class constructor.
		 */
		public function Keyboard() {
			numButtons = TOTAL_NUMBER_OF_KEYBOARD_KEYS;
		}
		
		//-------------------------------------------------------
		// Override public final method
		//-------------------------------------------------------
		
		/**
		 *	Metoden aktiveras när systemet registrerar att en 
		 *	tangent trycks ner.
		 *
		 *	@param	event 	Händelsen som aktiverade metoden.
		 * 
		 *	@return void
		 */
		override public final function handleButtonDown(event:Event):void	{
			currentKey = map[(event as KeyboardEvent).keyCode];
			setButtonState(true);
		}
		
		/**
		 *	Metoden aktiveras när systemet registrerar att en 
		 *	tangent släpps.
		 *
		 *	@param	event 	Händelsen som aktiverade metoden.
		 * 
		 *	@return void
		 */
		override public final function handleButtonUp(event:Event):void {
			currentKey = map[(event as KeyboardEvent).keyCode];
			setButtonState(false);
		}
		
		//-------------------------------------------------------
		// Override protected methods
		//-------------------------------------------------------
		
		/**
		 *	Initierar tangentbordets tangenter. Metoden är inte 
		 *	vacker men den är effektiv.
		 * 
		 *	@return void
		 */
		override protected function initKeys():void {
			var i:uint;
			map = new Vector.<InputKey>(TOTAL_NUMBER_OF_KEYBOARD_KEYS);
			i	= 65;
			
			while (i <= 90) {
				addKey(String.fromCharCode(i), i++);
			}
			
			i = 48;
			addKey("ZERO",i++);
			addKey("ONE",i++);
			addKey("TWO",i++);
			addKey("THREE",i++);
			addKey("FOUR",i++);
			addKey("FIVE",i++);
			addKey("SIX",i++);
			addKey("SEVEN",i++);
			addKey("EIGHT",i++);
			addKey("NINE",i++);
			
			i = 96;
			addKey("NUMPADZERO",i++);
			addKey("NUMPADONE",i++);
			addKey("NUMPADTWO",i++);
			addKey("NUMPADTHREE",i++);
			addKey("NUMPADFOUR",i++);
			addKey("NUMPADFIVE",i++);
			addKey("NUMPADSIX",i++);
			addKey("NUMPADSEVEN",i++);
			addKey("NUMPADEIGHT",i++);
			addKey("NUMPADNINE",i++);
			
			i = 1;
			while (i <= 12) {
				addKey("F" + i, 111 + (i++));
			}
			
			addKey("PAGEUP", 33);
			addKey("PAGEDOWN", 34);
			addKey("HOME", 36);
			addKey("END", 35);
			addKey("INSERT", 45);
			addKey("ESCAPE",27);
			addKey("MINUS",189);
			addKey("NUMPADMINUS",109);
			addKey("PLUS",187);
			addKey("NUMPADPLUS",107);
			addKey("DELETE",46);
			addKey("BACKSPACE",8);
			addKey("LBRACKET",219);
			addKey("RBRACKET",221);
			addKey("BACKSLASH",220);
			addKey("CAPSLOCK",20);
			addKey("SEMICOLON",186);
			addKey("QUOTE",222);
			addKey("ENTER",13);
			addKey("SHIFT",16);
			addKey("COMMA",188);
			addKey("PERIOD",190);
			addKey("NUMPADPERIOD",110);
			addKey("SLASH",191);
			addKey("NUMPADSLASH",191);
			addKey("CONTROL",17);
			addKey("ALT",18);
			addKey("SPACE",32);
			addKey("UP",38);
			addKey("DOWN",40);
			addKey("LEFT",37);
			addKey("RIGHT",39);
			addKey("TAB",9);
		}
	}
}