package ui
{
	import com.aman.utils.Utils_Geom;
	import com.aman.utils.Utils_UI;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import mx.core.UIComponent;
	
	public class ImgCanvas extends UIComponent
	{
		
		public static const RealSize:String = "real";
		public static const ZoomSize:String = "zoom";
		
		protected var _w:Number = 0;
		protected var _h:Number = 0;
		
		protected var _displayType:String = RealSize;
		private var _loaded:Boolean = false;
		
		protected var _core:Sprite;
		protected var _bmp:Bitmap;
		protected var _shp_bg:Shape;
		protected var _rect:Rectangle;
		
		public function ImgCanvas(){
			_core = new Sprite();
			this.addChild(_core);
			
			super();
			
			addChildren();
			initEvents()
		}
		
//init
		protected function addChildren():void{
			_shp_bg = new Shape();
			var g:Graphics = _shp_bg.graphics;
			g.beginFill(0xffffff , 0.2);
			g.drawRect(0 , 0 , 64 , 64);
			g.endFill();
			_core.addChild(_shp_bg);
			
			_bmp = new Bitmap()
			_core.addChild(_bmp);
			_bmp.smoothing = true;
		}
		
		private function initEvents():void{}
		
//Tools
		protected function resize():void{
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
		}
		
//Listener		
		
//interface
		public function setSize($w:Number , $h:Number):void{
			_w = $w;
			_h = $h;
			this.width = $w;
			this.height = $h;
			resize();
		}
		
		public function change($r:Rectangle=null):void{}
		
		
//getter and setter
		
		public function set bitmapData($b:BitmapData):void{
			_bmp.bitmapData = $b;
			if($b.width>_w || $b.height>_h){
				_displayType = ZoomSize;
			}else{
				_displayType = RealSize;
			}
			resize();
			change();
		}
		
		public function getBmd():BitmapData{
			return null;
		}
		
		public function set displayType($type:String):void{
			if($type==_displayType){
				return;
			}
			_displayType = $type
			resize()
		}
	}
}