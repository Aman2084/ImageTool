package tools
{
	import flash.display.BitmapData;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.graphics.codec.PNGEncoder;

	public class MySaver
	{
		
		private var _encoder:PNGEncoder = new PNGEncoder()
		private var _stream:FileStream = new FileStream();
		
		public function MySaver()
		{
		}
		
		public function save($b:BitmapData , $fileName:String , $dir:String):void{
			var f:File = new File($dir);
			f = f.resolvePath($fileName + ".png");
			
			if(f.exists){
				Alert.show("文件已存在！" );
				return
			}
			
			var b:ByteArray = _encoder.encode($b);
			_stream.open(f , FileMode.WRITE);
			_stream.writeBytes(b);
			_stream.close();
			b.clear();
		}
		
	}
}