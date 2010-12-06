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
from captionmash.models import Photo,PhotoDTO
from captionmash.services.networks import NetworkService
from django.core.exceptions import ObjectDoesNotExist
from datetime import datetime

try:
    pyamf.register_class( PhotoDTO,  'com.captionmashup.common.model.local.dto.PhotoDTO')
except ValueError:
    None
    
class PhotoService:
    
    def getPhotoByLink(self,photo_link):
        photo = Photo.objects.get(link = photo_link)
        return self.to_dto(photo)
    
    def getAlbumPhotos(self,album_id):
        photos = list(Photo.objects.filter(album = album_id, is_visible = True))
        photoResult = []
                
        for photo in photos:
            photoResult.append(self.to_dto(photo))
        
        return photoResult
    
    def getLatestCaptionedPhotos(self):
        photos = list(Photo.objects.filter(is_captioned = True, 
                                           is_visible = True).
                                           order_by('-last_caption_date'))
        photoResult = []
                
        for photo in photos:
            photoResult.append(self.to_dto(photo))
        
        return photoResult
    
    def getLatestAddedPhotos(self):
        photos = list(Photo.objects.filter(is_visible = True).
                                           order_by('-creation_date'))
        photoResult = []
                
        for photo in photos:
            photoResult.append(self.to_dto(photo))
        
        return photoResult       
    
    def deletePhoto(self,photo_id,user):
        photo = Photo.objects.get(id=photo_id)
        photo.delete()
        return self.getAlbumPhotos(photo.album.id)
    '''
    Takes an array of photo objects
    For each photo checks if the photo is in database (True)
        True: returns photo object with local id
        False: inserts object and returns inserted photo with local id
      
    Returned photos are inserted in the result array and
    result array is returned  
    '''
    def saveCaptionPhotos(self,photos):
        
        resultArray = []
        photoService    = PhotoService()
        
        for photo in photos:
            resultArray.append(photoService.savePhoto(photo))
             
        #Return result        
        return resultArray 
            
    def updatePhoto(self,photoDTO,user):
        
        photo = Photo.objects.get(id = photoDTO.django_id)
        
        photo.source_url    = photoDTO.source_url
        photo.title         = photoDTO.title
        photo.page_no       = photoDTO.page_no
        
        photo.save()
        return photo 

    def savePhoto(self,photo):
        
        networkService = NetworkService()
        network = networkService.saveNetwork(photo.network_name)
        now = datetime.now()
        
        try:
            #Photo has been inserted before
            if photo.django_id != 0:
                photo = Photo.objects.get(id=photo.django_id)
                photo.is_captioned = True
                photo.last_caption_date = now
                photo.save()
                #Add photo to result array
                return photo
            #Copies of new photos are in the source array
            else:
                photo = Photo.objects.get(network = network,
                                          foreign_photo_id = photo.photo_id,
                                          foreign_album_id = photo.album_id,
                                          foreign_owner_id = photo.owner_id
                                          )
                photo.is_captioned = True
                photo.last_caption_date = now
                photo.save()
                #Add photo to result array
                return photo
        except ObjectDoesNotExist:
            #return 'photo not found'
            photo = Photo(foreign_photo_id = photo.photo_id,
                          foreign_album_id = photo.album_id,
                          foreign_owner_id = photo.owner_id,
                          last_caption_date = now,
                          photo_path    = photo.photo_path,
                          thumb_path    = photo.thumb_path,
                          is_public     = True,
                          is_captioned  = True,
                          network       = network)
            
            #Insert new photo
            photo.save()
            #Add photo to result array
            return photo

  
    def to_dto(self,photo):
        
        
        photoDTO = PhotoDTO()
        
        photoDTO.django_id = photo.id
        photoDTO.network_name = photo.network.name

        photoDTO.thumb_path = photo.thumb_path
        photoDTO.photo_path = photo.photo_path
        photoDTO.file_size  = photo.file_size
        photoDTO.source_url = photo.source_url
        photoDTO.title      = photo.title
        photoDTO.page_no    = photo.page_no
        photoDTO.link       = photo.link

        return photoDTO