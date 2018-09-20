package com.tools
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class DirectorySelecter extends File
	{
		public var path:String = "";
		private var _listener:Function;
		
		public function DirectorySelecter(){
			super(path);
			this.addEventListener(Event.SELECT , onSelected , false , 100);
		}
		
		public function select($f:Function=null):void{
			listener = $f;
			browseForDirectory("请选取文件夹");
		}
		
		private function onSelected($e:Event):void{
			path = nativePath;
		}
		
		public function get listener():Function
		{
			return _listener;
		}
		
		public function set listener($fun:Function):void{
			if(_listener==$fun){
				return
			}
			
			if(_listener!=null){
				this.removeEventListener(Event.SELECT , _listener);
			}
			_listener = $fun;
			if(_listener!=null){
				this.addEventListener(Event.SELECT , _listener);
			}
		}
	}
}