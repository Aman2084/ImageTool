///////////////////////////////////////////////////////////
//  ImageCut.as
//  Macromedia ActionScript Implementation of the Class ImageCut
//  Created on:      2018-9-18 下午5:54:18
//  Original author: Aman
///////////////////////////////////////////////////////////

package com.border
{
	import com.aman.utils.Utils_Geom;
	import com.aman.utils.Utils_UI;
	
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import ui.ImgCanvas;
	
	
	/**
	 * 裁切图片
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-9-18 下午5:54:18
	 */
	public class ImageCut extends ImgCanvas
	{
		private var _shp:Shape;
		
		public function ImageCut(){
			super();
		}
		
		
		override protected function addChildren():void{
			super.addChildren();
			
			_shp = new Shape();
			var g:Graphics = _shp.graphics;
			g.beginFill(0x000000);
			g.drawRect(0 , 0 , 64 , 64);
			g.endFill();
			_core.addChild(_shp);
			_bmp.mask = _shp;
		}
		
		/*override protected function resize():void{
			if(!_bmp.bitmapData){
				return
			}
			_core.scaleX = _core.scaleY = 1;
			var r_inner:Rectangle = new Rectangle(0 , 0 , _bmp.width , _bmp.height);
			var r_out:Rectangle = new Rectangle(0 , 0 , _w , _h);
			
			switch(_displayType){
				case ZoomSize:
					var r:Rectangle = Utils_Geom.equalScal2Outter(r_inner , r_out);
					Utils_UI.setPosAndSize(_core , r);
					break;
				case RealSize:
					var p:Point = Utils_Geom.centerOrLR(r_inner , r_out);
					_core.x = p.x;
					_core.y = p.y;
					break;
			}
		}*/
		
		override public function change($r:Rectangle=null):void{
			if(!_bmp.bitmapData){
				return;
			}
			
			var b:BitmapData = _bmp.bitmapData;
			if(!$r){
				_rect = new Rectangle(0 , 0 , b.width , b.height)
			}else{
				var r:Rectangle = _bmp.bitmapData.rect.clone();
				r.width -= ($r.left + $r.right);
				r.height -= ($r.top + $r.bottom)
				r.x = $r.left;
				r.y = $r.top;
				r.width = Math.max(r.width , 0);
				r.height = Math.max(r.height , 0);
				_rect = r;
			}
			Utils_UI.setPosAndSize(_shp , _rect);
			Utils_UI.setPosAndSize(_shp_bg , _rect);
			this.toolTip = _rect.toString();
		}
		
		override public function getBmd():BitmapData{
			var b:BitmapData = new BitmapData(_rect.width , _rect.height , true , 0x00000000);
			b.copyPixels(_bmp.bitmapData , _rect , new Point());
			return b;
		}
	}
}