///////////////////////////////////////////////////////////
//  ImageSelecter.as
//  Macromedia ActionScript Implementation of the Class ImageSelecter
//  Created on:      2018-9-20 下午5:29:23
//  Original author: Aman
///////////////////////////////////////////////////////////

package com.tools
{
	import com.aman.event.ZEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import tools.ImageSelecterFile;
	
	/**
	 * 图片选择器
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-9-20 下午5:29:23
	 */
	public class ImageSelecter extends EventDispatchBase
	{
		private var _selecter_image:ImageSelecterFile;
		private var _loader:Loader;
		
		public function ImageSelecter(){
			_loader = new Loader();
			_selecter_image = new ImageSelecterFile();
			
			_selecter_image.addEventListener(Event.SELECT , onSelecter);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE , onLoad);
		}
		
		private function onSelecter($e:Event):void{
			var r:URLRequest = new URLRequest(_selecter_image.nativePath);
			_loader.load(r)
			var evt:ZEvent = new ZEvent(ZEvent.Selected)
			this.dispatchEvent(evt);
		}
		
		private function onLoad($e:Event=null):void{
			var b:BitmapData = (_loader.content as Bitmap).bitmapData;
			var evt:ZEvent = new ZEvent(ZEvent.Loaded , b)
			this.dispatchEvent(evt);
		}
		
		override protected function myEventTypes():Array{
			return [
				ZEvent.Selected , ZEvent.Loaded
			];
		}
		
//interface 
		public function select($callBack:Function):void{
			this.listener = $callBack;
			_selecter_image.selectImage();
		}
		
		public function get fileName():String{
			var s:String =_selecter_image.name;
			s = s.replace(_selecter_image.type , "");
			return s;
		}
		
		public function get parentFloder():String{
			return _selecter_image.parent.nativePath
		}
	}
}