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
import uuid
from captionmash.models import Photo,Album,Network
from google.appengine.api import images

from boto.s3.connection import S3Connection
from boto.s3.key import Key
import mimetypes
import settings

THUMBNAIL_WIDTH  = 200
THUMBNAIL_HEIGHT = 200

if settings.DEBUG:
    AWS_ADDRESS = 'http://captionmash-dev.s3.amazonaws.com'
    BUCKET_NAME = 'captionmash-dev'


else:
    AWS_ADDRESS = 'http://captionmash.s3.amazonaws.com'
    BUCKET_NAME = 'captionmash'


class UploadService(object):
    '''
    Uploading process goes like this:
        1- Create an uuid
        2- Create filename and thumbname relative paths 
            using user_id and uuid
        3- Read the file contents
        4- Create reduced size jpeg using the content
            save to S3 using filename
        5- Create thumbnail using the content
            save to S3 using thumbname
        6- Create and save a photo record for given album_id
            and 'Captionmash' network
        7- If photo's album has only 1 photo, set album cover
            to that photo
        8- Return True if everything goes OK
    '''
    def receive_single_file(self,file,user_id,album_id):
     
        uuid_name = str(uuid.uuid4())

        filename    = self.create_filename(user_id,uuid_name)
        thumbname   = self.create_thumbname(user_id,uuid_name)
        
        content = file.read()
        
        #self.store_in_s3(filename,content)
        image_jpeg = self.create_jpeg(content)
        self.store_in_s3(filename, image_jpeg)

        thumbnail       = self.create_thumbnail(content)
        self.store_in_s3(thumbname, thumbnail)
        
        size    = len(image_jpeg)
        album   = Album.objects.get(id = album_id)
        network = Network.objects.get(name='Captionmash')
 
        photo   = Photo(photo_path = AWS_ADDRESS + filename,
                        thumb_path = AWS_ADDRESS + thumbname,
                        is_public = True,
                        network = network,
                        album = album,
                        file_size = size)

        photo.save()
        
        num_photos = Photo.objects.filter(album = album,is_visible = True).count()
        
        #Set album image to uploaded image if there's no photos
        if num_photos == 1:
            album.thumb_path = photo.thumb_path
            album.photo_path = photo.photo_path
            album.save()
            
        return True
    
    #Create a relative path for image using given user_id and uuid
    #Return value used for creating absolute image path URL
    def create_filename(self,user_id,uuid_name):
        return '/image/user/'+str(user_id) +'/'+uuid_name+'.jpeg'

    #Create a relative path for thumbnail using given user_id and uuid
    #Return value used for creating absolute thumbnail path URL
    def create_thumbname(self,user_id,uuid_name):
        return '/image/user/'+str(user_id) +'/tn_'+uuid_name+'.jpeg'

    #Convert image to JPEG (also reduce size)
    def create_jpeg(self,content):
        img = images.Image(content)
        img_jpeg = images.resize(content,img.width,img.height,images.JPEG)
        return img_jpeg

    #Create thumbnail image using file
    def create_thumbnail(self,content):
        image = images.resize(content,THUMBNAIL_WIDTH, THUMBNAIL_HEIGHT,images.JPEG)
        return image
    
    #Stores the file in S3 using created filename and file content
    def store_in_s3(self,filename,content):
        conn = S3Connection(settings.ACCESS_KEY, settings.PASS_KEY)
        b = conn.get_bucket(BUCKET_NAME)
        mime = mimetypes.guess_type(filename)[0]
        k = Key(b)
        k.key = filename
        k.set_metadata("Content-Type", mime)
        k.set_contents_from_string(content)
        k.set_acl("public-read")  
        
        
