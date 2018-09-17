package tools
{
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	public class ImageSelecter extends File
	{
		private var _filter:FileFilter;
		
		public function ImageSelecter(){
			super("F:\我的文档\播放器开发\001_myApp");
			_filter = new FileFilter("Image", "*.bmp;*.jpg;*.jpeg;*.JPG;*.JPEG;*.png;");
		}
		
		public function selectImage():void{
			this.browseForOpen("请选择图片" , [_filter]);
		}
	}
}