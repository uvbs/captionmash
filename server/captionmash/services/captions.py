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
from django.contrib.auth.models import User
from captionmash.services.photos import PhotoService
from captionmash.models import Photo,Caption,CaptionDTO, UserProfile,Node_Caption_Photo
from django.core.exceptions import ObjectDoesNotExist

try:
    pyamf.register_class( CaptionDTO,  'com.captionmashup.common.model.local.dto.CaptionDTO')
except ValueError:
    None
    
class CaptionService(object):
    
    def getCaptionByLink(self,caption_link):
        try:
            caption = Caption.objects.get(link = caption_link)
            return self.to_dto(caption)
        except ObjectDoesNotExist:
            return None

    def getLatestCaptions(self):
        
        captions = list(Caption.objects.order_by('-creation_date').all()[0:16])
        
        captionDTO_array = []
        
        for caption in captions:
            captionDTO_array.append(self.to_dto(caption))
            #captionDTO_array.append(caption)
        return captionDTO_array
    
    def addCaption(self,request,captionDTO):
            
        ip   = request.META['REMOTE_ADDR']   
        #Anonymous user
        if request.user.is_anonymous():
            user = None
        else:
            user = request.user
    
        photoService = PhotoService()

        #Batch insert photos
        #Result is array of INSERTED photos (multiple entries allowed,but not inserted)
        photos = photoService.saveCaptionPhotos(captionDTO.photos)

        #Save the queue of photos using their ids 
        frames       = ','.join(str(photo.id)   for photo in photos)
        frame_delays = ','.join(str(delay)      for delay in captionDTO.frame_delays) 
        
        #Start writing into Caption record
        caption = Caption(caption_data  = captionDTO.caption_data,
                          thumb_path    = captionDTO.thumb_path,
                          photo_path    = captionDTO.photo_path,
                          frames        = frames,
                          frame_delays  = frame_delays,
                          author        = user,
                          author_ip     = ip)
        
        caption.save()
        
        #Create nodes for Photo <-> Caption ManyToMany relationship 
        for photo in photos:
            node = Node_Caption_Photo(caption = caption,photo=photo)
            try:
                Node_Caption_Photo.objects.get(caption = caption,photo = photo)
            except:
                node.save();
        
        return self.to_dto(caption)
    
        #Creates CaptionDTO from caption object 
    def to_dto(self,caption):

        try:
            userProfile = UserProfile.objects.get(user = caption.author)
            nickname = userProfile.nickname
        except ObjectDoesNotExist:
            nickname = 'Anonymous'
            
        captionDTO = CaptionDTO()
        photoService = PhotoService()

        #Create array from frames string and retrieve photos
        photos = Photo.objects.filter(pk__in=caption.frames.split(','))
        
        dto_array = []
        
        #Convert photos into PhotoDTOs and append them to result array
        for photo in photos:
            dto_array.append(photoService.to_dto(photo))
            
        captionDTO.photos        = dto_array
        captionDTO.thumb_path    = caption.thumb_path
        captionDTO.photo_path    = caption.photo_path
        captionDTO.caption_data  = caption.caption_data
        captionDTO.effect_data   = caption.effect_data
        captionDTO.filter_data   = caption.filter_data
        captionDTO.object_data   = caption.object_data
        captionDTO.django_id     = caption.id
        captionDTO.author_name   = nickname
        captionDTO.link          = caption.link
        
        return captionDTO