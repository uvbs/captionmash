'''
 * http://www.captionmash.com
 * Developed by O. Can Bascil | ocanbascil at gmail.com
 *
 * License: GPL version 3.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.

 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
'''
import pyamf
from captionmash.models import Album,AlbumDTO,Photo

try:
    pyamf.register_class( AlbumDTO,  'com.captionmashup.common.model.local.dto.AlbumDTO')
except ValueError:
    pass
    
DEFAULT_ALBUM_THUMBNAIL = "http://s3.amazonaws.com/captionmash/media/images/genre_covers/tn_awesome.jpg"
DEFAULT_ALBUM_IMAGE     = "http://s3.amazonaws.com/captionmash/media/images/genre_covers/awesome.jpg"

'''Service that is responsible with Albums CRUD'''
class AlbumService(object):
    
    def getGenreAlbums(self,genre_id):
        albums = list(Album.objects.filter(genre = genre_id))
        
        albumResult = []
        for album in albums:
            albumResult.append(self.to_dto(album))
        
        return albumResult
    
    def getUserAlbums(self,user_id):
        albums = list(Album.objects.filter(user = user_id))
        
        albumResult = []
        for album in albums:
            albumResult.append(self.to_dto(album))
        return albumResult
    
    def createAlbum(self,name,user_id):
        album = Album(thumb_path = DEFAULT_ALBUM_THUMBNAIL,
                      photo_path = DEFAULT_ALBUM_IMAGE,
                      user = user_id,
                      name = name,
                      )
        album.save()
        
    def deleteAlbum(self,album_id,user_id):
        album = Album.objects.get(id = album_id)
        album.delete()
        return True
    
    def to_dto(self,album):
        
        num_photos = Photo.objects.filter(album = album,is_visible = True).count()
        
        albumDTO = AlbumDTO()
        albumDTO.django_id = album.id
        albumDTO.thumb_path = album.thumb_path
        albumDTO.photo_path = album.photo_path
        albumDTO.name   = album.name
        
        album = Album.objects.get(id = album.id)
        
        albumDTO.num_photos = num_photos
        return albumDTO

