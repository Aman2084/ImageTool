///////////////////////////////////////////////////////////
//  ImageExtension.as
//  Macromedia ActionScript Implementation of the Class ImageExtension
//  Created on:      2018-9-18 下午5:55:11
//  Original author: Aman
///////////////////////////////////////////////////////////

package com.border
{
	import com.aman.utils.Utils_Geom;
	import com.aman.utils.Utils_UI;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import ui.ImgCanvas;
	
	
	/**
	 * 延展图片
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-9-18 下午5:55:11
	 */
	public class ImageExtension extends ImgCanvas
	{
		public function ImageExtension(){
			super();
		}
		
		
		override protected function resize():void{
			if(!_bmp.bitmapData){
				return
			}
			_core.scaleX = _core.scaleY = 1;
			var r_inner:Rectangle = new Rectangle(0 , 0 , _bmp.width , _bmp.height);
			var r_out:Rectangle = new Rectangle(0 , 0 , _w , _h);
			
			switch(_displayType){
				case ZoomSize:
					var r:Rectangle = Utils_Geom.equalScal2Outter(r_inner , r_out);
					_core.x = r.x;
					_core.y = r.y;
					var s:Number = r.width / r_inner.width;
					_core.scaleX = _core.scaleY = s;
					break;
				case RealSize:
					var p:Point = Utils_Geom.centerOrLR(r_inner , r_out);
					_core.x = p.x;
					_core.y = p.y;
					break;
			}
		}
		override public function change($r:Rectangle=null):void{
			if(!_bmp.bitmapData){
				return;
			}
			
			_rect = _bmp.bitmapData.rect.clone()
			if($r){
				_rect.top -= $r.top;
				_rect.left -= $r.left;
				_rect.bottom += $r.bottom;
				_rect.right += $r.bottom;
			}
			var g:Graphics = _shp_bg.graphics;
			g.clear();
			g.beginFill(0xffffff , 0.3);
			g.drawRect(_rect.x , _rect.y , _rect.width , _rect.height);
			g.endFill()
		}
		
		override public function getBmd():BitmapData{
			var b:BitmapData = new BitmapData(_rect.width , _rect.height , true , 0x00000000);
			
			var p:Point = new Point(-_rect.top , -_rect.left);
			b.copyPixels(_bmp.bitmapData , b.rect , p);
			return b
		}
		
		
	}
}