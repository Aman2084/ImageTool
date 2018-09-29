///////////////////////////////////////////////////////////
//  ImageSaver.as
//  Macromedia ActionScript Implementation of the Class ImageSaver
//  Created on:      2018-9-20 下午5:30:02
//  Original author: Aman
///////////////////////////////////////////////////////////

package com.tools
{
	import com.ToolsInstance;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	import mx.events.CloseEvent;
	import mx.graphics.codec.PNGEncoder;
	
	
	
	/**
	 * 
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-9-20 下午5:30:02
	 */
	public class ImageSaver extends EventDispatchBase{
		
		private var _name:String;
		private var _bmd:BitmapData;
		
		private var _encoder:PNGEncoder = new PNGEncoder()
		private var _stream:FileStream = new FileStream();
		
		public function ImageSaver(){
			super();
		}
		
		public function save($b:BitmapData , $fileName:String):void{
			_bmd = $b
			_name = $fileName
			
			if(ToolsInstance.directory.path){
				testName()
			}else{
				ToolsInstance.directory.select(testName);
			}
		}
		
		
		//Save
		private function testName($e:Event =null):void{
			var f:File = new File(ToolsInstance.directory.path);
			f = f.resolvePath(_name + ".png");
			
			if(!f.exists){
				saveFile(f);
				return
			}
			
			Alert.okLabel = "覆盖";
			Alert.yesLabel = "重命名"
			Alert.cancelLabel = "取消"
			Alert.show("文件已存在！" , "" ,Alert.OK|Alert.CANCEL|Alert.YES , null , 
				function($e:CloseEvent):void{
					switch($e.detail){
						case Alert.OK:
							saveFile(f);
							break
						case Alert.YES:
							var s:String = _name + ".png";
							while(f.exists){
								s = "_" + s;
								f.nativePath = ToolsInstance.directory.path;
								f = f.resolvePath(s)
							}
							saveFile(f);
							break
					}
				}
				);
		}
				
			private function saveFile($f:File):void{
				var b:ByteArray = _encoder.encode(_bmd);
				_stream.open($f , FileMode.WRITE);
				_stream.writeBytes(b);
				_stream.close();
				b.clear();
			}
		
	}
}