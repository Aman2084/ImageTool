///////////////////////////////////////////////////////////
//  ImageFlip.as
//  Macromedia ActionScript Implementation of the Class ImageFlip
//  Created on:      2018-9-20 下午3:44:01
//  Original author: Aman
///////////////////////////////////////////////////////////

package com.flip
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import ui.ImgCanvas;
	
	
	/**
	 * 翻转
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-9-20 下午3:44:01
	 */
	public class ImageFlip extends ImgCanvas
	{
		
		public static const Type_Normal:String = "normal";
		public static const Type_Horizontal:String = "horizontal";
		public static const Type_Vertical:String = "vertical";
		
		private var _type:String = Type_Normal;
		
		private var _bmd_target:BitmapData
		private var _bmd_source:BitmapData
			
		public function ImageFlip(){
			super();
		}
		
		override public function change($r:Rectangle=null):void{
			if(!_bmp.bitmapData){
				return;
			}
			
			if(_bmd_target !=_bmp.bitmapData){
				_bmd_source = _bmp.bitmapData;
				if(_bmd_target){
					_bmd_target.dispose();
				}
				_bmd_target = new BitmapData(_bmd_source.width , _bmd_source.height , true , 0x0);
				_bmp.bitmapData = _bmd_target;
			}
			
			switch(_type){
				case Type_Normal:
					_bmd_target.copyPixels(_bmd_source , _bmd_target.rect , new Point());
					break;
				case Type_Horizontal:
				case Type_Vertical:
					filp();
					break;
			}
		}
		
		private function filp():void{
			var m:Matrix = new Matrix();
			if(_type==Type_Horizontal){
				m.a = -1;
				m.tx = _bmd_source.width;
			}else if(_type==Type_Vertical){
				m.d = -1;
				m.ty = _bmd_source.height;
			}
			_bmd_target.draw(_bmd_source , m);
		}
		
		override public function getBmd():BitmapData{
			return _bmd_target
		}
		
		public function get type():String{
			return _type;
		}

		public function set type($t:String):void{
			if($t==_type){
				return
			}
			_type = $t;
			change();
		}
	}
}