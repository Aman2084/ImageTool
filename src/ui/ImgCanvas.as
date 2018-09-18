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
		
		private var _w:Number = 0;
		private var _h:Number = 0;
		
		private var _displayType:String = RealSize;
		private var _loaded:Boolean = false;
		
		private var _core:Sprite;
		private var _bmp:Bitmap;
		private var _shp_bg:Shape;
		private var _shp:Shape;
		private var _rect:Rectangle;
		
		public function ImgCanvas(){
			_core = new Sprite();
			this.addChild(_core);
			
			super();
			addChildren();
			initEvents()
		}
		
//init
		private function addChildren():void{
			_bmp = new Bitmap()
			_shp = new Shape();
			var g:Graphics = _shp.graphics;
			g.beginFill(0x000000);
			g.drawRect(0 , 0 , 64 , 64);
			g.endFill();
			
			_shp_bg = new Shape();
			g = _shp_bg.graphics;
			g.beginFill(0xffffff , 0.2);
			g.drawRect(0 , 0 , 64 , 64);
			g.endFill();
			
			_core.addChild(_shp_bg);
			_core.addChild(_shp);
			_core.addChild(_bmp);
			_bmp.mask = _shp;
			_bmp.smoothing = true;
		}
		
		private function initEvents():void{
			
		}
		
//Tools
		private function resize():void{
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
		
		public function cut($r:Rectangle=null):void{
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
		}
		
//getter and setter
		
		public function set bitmapData($b:BitmapData):void{
			_bmp.bitmapData = $b;
			if($b.width>_w || $b.height>_h){
				_displayType = ZoomSize;
			}else{
				_displayType = RealSize;
			}
			
			resize();
			cut();
		}
		
		public function getBmd():BitmapData{
			var b:BitmapData = new BitmapData(_rect.width , _rect.height , true , 0x00000000);
			b.copyPixels(_bmp.bitmapData , _rect , new Point());
			return b;
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