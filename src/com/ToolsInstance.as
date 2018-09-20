///////////////////////////////////////////////////////////
//  ToolsInstance.as
//  Macromedia ActionScript Implementation of the Class ToolsInstance
//  Created on:      2018-9-20 下午5:28:47
//  Original author: Aman
///////////////////////////////////////////////////////////

package com
{
	import com.tools.DirectorySelecter;
	import com.tools.ImageSaver;
	import com.tools.ImageSelecter;
	
	/**
	 * 公用类引用入口
	 * @author Aman
	 * @version 1.0
	 * 
	 * @created  2018-9-20 下午5:28:47
	 */
	public class ToolsInstance
	{
		
		private static var _selecter:ImageSelecter;
		private static var _saver:ImageSaver;
		private static var _directory:DirectorySelecter;
		
		public static function get selecter():ImageSelecter{
			if(!_selecter){
				_selecter = new ImageSelecter();
			}
			return _selecter;
		}

		public static function get saver():ImageSaver{
			if(!_saver){
				_saver = new ImageSaver()
			}
			return _saver;
		}

		public static function get directory():DirectorySelecter{
			if(!_directory){
				_directory = new DirectorySelecter();
			}
			return _directory;
		}
	}
}