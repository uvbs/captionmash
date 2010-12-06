package com.captionmashup.modules.album.facebook.fql
{
	public class FqlCreateUtil
	{

		/************************************
		 * Create FQL QUERY
		 * *********************************/
		
		public static function createAlbumFQL(owner_id:String):Object{
			var queryObject:Object = new Object();
			
			queryObject.albums = "SELECT aid,name,object_id, cover_pid,size,owner FROM album WHERE owner='"+owner_id+"' ORDER BY aid";
			queryObject.albumCovers = "SELECT aid,src ,src_big FROM photo WHERE pid IN (SELECT cover_pid FROM #albums) ORDER BY aid";		
	
			return queryObject;
		}
		
		public static function createAlbumPhotosFQL(aid:String):Object{
			var queryObject:Object = new Object();
			queryObject.query = "SELECT pid,aid,object_id,src ,src_big,caption FROM photo WHERE aid='"+aid+"'";
			return queryObject;
		}
		
		public static function createSinglePhotoFQL(photoId:String):Object{
			var queryObject:Object = new Object();
			queryObject.query = "SELECT pid,src ,src_big FROM photo WHERE pid='"+photoId+"'";
			return queryObject;
		}
		
	}
}