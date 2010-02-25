package com.andymcintosh.controls
{
	import flash.events.FocusEvent;
	
	import spark.components.TextInput;

	public class AdvancedTextInput extends TextInput
	{
		//----------------------------------------------------------------------
		//
		//	Constructor
		//
		//----------------------------------------------------------------------
		
		public function AdvancedTextInput()
		{
			super();
		}
		
		//----------------------------------------------------------------------
		//
		//	States
		//
		//----------------------------------------------------------------------
		
		[SkinState("focused")];
				
		//----------------------------------------------------------------------
		//
		//	Properties
		//
		//----------------------------------------------------------------------
		
		private var _promptText:String
		
		[Bindable()]
		
		public function get promptText():String
		{
			return _promptText;
		}

		public function set promptText(v:String):void
		{
			_promptText = v;
		}
		
		//----------------------------------------------------------------------
		//
		//	Variables
		//
		//----------------------------------------------------------------------
		
		protected var focused:Boolean;
		
		//----------------------------------------------------------------------
		//
		//	Overridden Methods
		//
		//----------------------------------------------------------------------
		
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if (instance == this.textDisplay)
			{
				this.textDisplay.addEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
				this.textDisplay.addEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);
			}
		}
		
		override protected function partRemoved(partName:String, instance:Object):void
		{
			super.partRemoved(partName, instance);
			
			if (instance == this.textDisplay)
			{
				this.textDisplay.removeEventListener(FocusEvent.FOCUS_IN, onFocusInHandler);
				this.textDisplay.removeEventListener(FocusEvent.FOCUS_OUT, onFocusOutHandler);
			}
		}
		
		override protected function getCurrentSkinState():String
		{
			if (focused)
			{
				return "focused";
			}
			else
			{
				return super.getCurrentSkinState();
			}
		}
		
		//----------------------------------------------------------------------
		//
		//	Event Handlers
		//
		//----------------------------------------------------------------------
		
		private function onFocusInHandler(event:FocusEvent):void
		{
			focused = true;
			invalidateSkinState();
		}
		
		private function onFocusOutHandler(event:FocusEvent):void
		{
			focused = false;
			invalidateSkinState();
		}
		
	}
}
