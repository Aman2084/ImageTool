package tools
{
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class DirectorySelecter extends File
	{
		public var path:String = "F:\我的文档\播放器开发\001_myApp";
		
		
		public function DirectorySelecter(){
			super(path);
			this.addEventListener(Event.SELECT , onSelected);
		}
		
		private function onSelected($e:Event):void{
			path = nativePath;
		}
	}
}