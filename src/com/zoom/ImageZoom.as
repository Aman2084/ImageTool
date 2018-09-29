///////////////////////////////////////////////////////////
//  ImageZoom.as
//  Macromedia ActionScript Implementation of the Class ImageZoom
//  Created on:      2018-9-29 下午12:28:38
//  Original author: Aman
///////////////////////////////////////////////////////////

package com.zoom
{
	import com.aman.ui.utils.UIUtils;
	import com.aman.utils.Utils_Geom;
	import com.aman.utils.Utils_UI;
	
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import ui.ImgCanvas;
	
	
	/**
	 * 缩放功能图片展示
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-9-29 下午12:28:38
	 */
	public class ImageZoom extends ImgCanvas
	{
		private var _imgW:int;
		private var _imgH:int;
		
		
		public function ImageZoom(){
			super();
		}
		
		override protected function addChildren():void{
			super.addChildren();
			_shp_bg.visible = false;
		}
		
		
		override protected function resize():void{
			if(!_bmp.bitmapData){
				return
			}
			var r_inner:Rectangle = new Rectangle(0 , 0 , _imgW , _imgH);
			var r_out:Rectangle = new Rectangle(0 , 0 , _w , _h);
			var p:Point = Utils_Geom.centerOrLR(r_inner , r_out);
			r_inner.offsetPoint(p)
			Utils_UI.setPosAndSize(_core , r_inner);
		}
		
		override public function getBmd():BitmapData{
			var src:BitmapData = _bmp.bitmapData;
			if(!src){
				return null
			}
			var bmd:BitmapData = new BitmapData(_imgW , _imgH , true , 0x00000000);
			var m:Matrix = new Matrix();
			m.scale(_imgW / src.width , _imgH / src.height);
			bmd.draw(src , m , null , null , null , true);
			return bmd
		}
		
		public function setImageSize($w:int , $h:int):void{
			_imgW = $w;
			_imgH = $h;
			resize()
		}
		
		override public function set bitmapData($b:BitmapData):void{
			if($b){
				_imgW = $b.width;
				_imgH = $b.height;
			}
			super.bitmapData = $b;
		}
		
	}
}