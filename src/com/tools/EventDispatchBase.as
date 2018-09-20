///////////////////////////////////////////////////////////
//  EventDispatchBase.as
//  Macromedia ActionScript Implementation of the Class EventDispatchBase
//  Created on:      2018-9-20 下午5:31:34
//  Original author: Aman
///////////////////////////////////////////////////////////

package com.tools
{
	import flash.events.EventDispatcher;
	
	
	/**
	 * 事件侦听基础类
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-9-20 下午5:31:34
	 */
	public class EventDispatchBase extends EventDispatcher
	{
		private var _listener:Function;

		public function EventDispatchBase(){
			super();
		}
		
		protected function myEventTypes():Array{
			return [];
		}
		
		public function get listener():Function
		{
			return _listener;
		}

		public function set listener($fun:Function):void{
			if(_listener==$fun){
				return
			}
			var a:Array = myEventTypes();
			
			if(_listener!=null){
				for (var i:int = 0; i < a.length; i++){
					this.removeEventListener(a[i] , _listener);
				}
			}
			_listener = $fun;
			if(_listener!=null){
				for (i = 0; i < a.length; i++){
					this.addEventListener(a[i] , _listener);
				}
			}
		}
	}
}