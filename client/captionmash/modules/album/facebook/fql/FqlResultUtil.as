package com.captionmashup.modules.album.facebook.fql
{
	import com.captionmashup.modules.album.facebook.model.dto.Album;
	import com.captionmashup.modules.album.facebook.model.dto.Photo;

	public class FqlResultUtil
	{
		//Create album objects using 2 different objects from FQL query
		//Push albums to result array and return the array
		public static function albumResultToArray(fqlResult:Object):Array
		{
			var result:Array = new Array;
			var albums:Array = fqlResult[0].fql_result_set as Array;
			var albumCovers:Array= fqlResult[1].fql_result_set as Array;
			
			var i:int = 0;
			var length:int = 0;
			
			if(albums.length == albumCovers.length){
				length = albums.length;	
			}else{
				trace("YSBST: array sizes different in handleAlbumData");
				return new Array();
			}
			
			for(i = 0; i < length; i++){
				
				var albumObject:Object = albums[i];
				var albumCoverObject:Object = albumCovers[i]; 
				
				var album:Album = new Album(albumObject.aid,albumObject.owner,
											albumObject.name,albumObject.size,
											albumCoverObject.src_big,
											albumCoverObject.src);
				result.push(album);
			}
			return result;
		}
		
		public static function photoResultToArray(fqlResult:Object):Array{
			var result:Array = new Array;
			var photos:Array = fqlResult as Array;
			
			for each(var source:Object in photos){
				var photo:Photo = new Photo(source.pid,
											source.src_big,
											source.src,
											source.object_id,
											source.caption);
				result.push(photo);
			}
			return result;
		}	
	}
}