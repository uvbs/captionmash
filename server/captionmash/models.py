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
import string,random
from django.contrib.auth.models import User
from django.db import models

DEFAULT_THUMBNAIL = "http://s3.amazonaws.com/captionmash/media/images/genre_covers/tn_awesome.jpg"
DEFAULT_IMAGE     = "http://s3.amazonaws.com/captionmash/media/images/genre_covers/awesome.jpg"


#Youtube style permalink generation
def createLink(model):
    def generateLink():
        alphanum = string.letters+string.digits  
        return ''.join([alphanum[random.randint(0,61)] for i in xrange(5)])
    
    while 1:
        link = generateLink()
        try:
            model.objects.get(link = link)
        except:
            return link

class UserProfile(models.Model):
    user = models.ForeignKey(User, unique=True)
    nickname = models.CharField(max_length=50)
    thumb_path          = models.CharField(max_length=200,default =DEFAULT_THUMBNAIL,null=True)
    photo_path          = models.CharField(max_length=200,default =DEFAULT_IMAGE,null=True)
    current_login_ip    = models.IPAddressField(null=True)
    last_login_ip       = models.IPAddressField(null=True)
    current_login_date  = models.DateTimeField(null=True,editable=False)
    last_login_date     = models.DateTimeField(null=True,editable=False)
    
    def __str__(self):
        return self.nickname+'/'+self.user.username
    
class UserDTO:
    pass
    
class Network(models.Model):       
    name = models.CharField(max_length=200)
    url  = models.CharField(max_length=200)
    
    def __str__(self):
        return self.name
    
#Genre for CaptionMashup albums
class Genre(models.Model):
    thumb_path      = models.CharField(max_length=200,null=True)
    photo_path      = models.CharField(max_length=200,null=True)
    name            = models.CharField(max_length=50)
    def __str__(self):
        return self.name

class GenreDTO(object):
    pass
    

#Local album model for uploaded photos
class Album(models.Model):
    
    link       		= models.CharField(max_length = 10)
    thumb_path      = models.CharField(max_length=200,default =DEFAULT_THUMBNAIL,null=True)
    photo_path      = models.CharField(max_length=200,default =DEFAULT_IMAGE,null=True)
    name            = models.CharField(max_length=50)
    is_visible      = models.BooleanField(default = True)
    creation_date   = models.DateTimeField(auto_now_add=True,editable=False)
    update_date     = models.DateTimeField(auto_now=True,editable=False)
    
    #Owner is null for official albums
    user  = models.ForeignKey(User,null=True,blank=True)
    #Genre is null for user albums
    genre   = models.ForeignKey(Genre,null=True,blank=True)
    #Used for official albums batch photo insertion 
    #format http://captionmash.s3.amazonaws.com/image/official/<genre_name>/<album_name>/
    s3_path = models.CharField(max_length=200,null=True,blank=True) 
      
    def __str__(self):
        if(self.user != None):
            return self.user.username +'/' + self.name
        else:
            return self.genre.name +'/' + self.name

    def save(self, *args, **kwargs):
        if self.id is None:
            self.link = createLink(self.__class__)
            
        super(Album, self).save(*args, **kwargs)

        
    def delete(self, *args, **kwargs):     
        photos = Photo.objects.filter(album = self)    
        #Delete all photos of album
        for photo in photos:
            photo.delete()       
        super(Album, self).delete(*args, **kwargs)

class AlbumDTO(object):
    pass
    
class Photo(models.Model):
    #Foreign network values
    foreign_photo_id = models.CharField(max_length=50,null=True,blank=True)
    foreign_album_id = models.CharField(max_length=50,null=True,blank=True)
    foreign_owner_id = models.CharField(max_length=50,null=True,blank=True)
    
    #Obligatory fields
    link       = models.CharField(max_length = 10)
    photo_path = models.CharField(max_length=200)
    thumb_path = models.CharField(max_length=200)
    #Used for privacy check
    is_public  = models.BooleanField(default = True)
    #Set to false on delete
    is_visible = models.BooleanField(default = True)
    #If a photo takes part in any caption
    #Checked while deleting photo
    is_captioned        = models.BooleanField(default = False)
    creation_date       = models.DateTimeField(auto_now_add=True,editable=False)
    last_caption_date   = models.DateTimeField(null=True,editable=False)
    
    #Network will be either a website (Penny-Arcade) 
    #or other album networks Facebook/Flickr etc
    network = models.ForeignKey(Network)
    
    #Local values
    #Photo title
    title   = models.CharField(max_length=50,null=True,blank=True)
    #Used for multipage albums/comics
    page_no = models.IntegerField(default = 0,null=True)
    file_size  = models.IntegerField(null=True,blank=True)
    #Photos from other social networks don't belong to any local albums
    album   = models.ForeignKey(Album,null=True,blank=True)
    
    #URL for an image 'page', used for webcomic redirecting 
    #example: http://www.penny-arcade.com/comic/2010/10/29/
    source_url  =  models.CharField(max_length=200,null=True,blank=True)
    
    def __str__(self):
        if(self.album == None): #Photo from foreign album
            name = self.network.name+"/"+self.foreign_owner_id+"/"+self.foreign_album_id+"/"+self.foreign_photo_id
        else:
            album = self.album
            
            if(self.album.user == None):    
                genre = self.album.genre
                name = genre.name+"/"+album.name+"/"+ ('Page: '+str(self.page_no) if self.page_no > 0 else 'id: '+str(self.id))
            else:
                userProfile = UserProfile.objects.get(user = self.album.user)
                name = userProfile.nickname+"/"+album.name+"/"+ ('Page: '+str(self.page_no) if self.page_no > 0 else 'id: '+str(self.id))
        
        return name
    
    def save(self, *args, **kwargs):
        if self.id is None:
            self.link = createLink(self.__class__)
            
        super(Photo, self).save(*args, **kwargs)
    
    def delete(self, *args, **kwargs):
        self.is_visible = False
        self.save()
        if self.album is not None:     
            if Photo.objects.filter(album = self.album,is_visible = True).count() == 0:
                self.album.thumb_path = DEFAULT_THUMBNAIL
                self.album.photo_path = DEFAULT_IMAGE
                self.album.save()
            else :
                q = Photo.objects.filter(album = self.album,is_visible = True)
                self.album.thumb_path = q[0].thumb_path
                self.album.photo_path = q[0].photo_path
                self.album.save()


class PhotoDTO(object):
    pass
    
class Caption(models.Model):
    author          = models.ForeignKey(User,null=True)
    author_ip       = models.IPAddressField(null=True)
    creation_date   = models.DateTimeField(auto_now_add=True,editable=False)
    update_date     = models.DateTimeField(auto_now=True,editable=False)
    thumb_path      = models.CharField(max_length=200)
    photo_path      = models.CharField(max_length=200)
    caption_data    = models.TextField(default = "")
    effect_data     = models.TextField(default = "")
    object_data     = models.TextField(default = "")
    filter_data     = models.TextField(default = "")
    link            = models.CharField(max_length = 10,unique=True)
    
    is_visible = models.BooleanField(default = True)
    #List of photos, multiple entries allowed
    frames          = models.CommaSeparatedIntegerField(max_length=200)
    frame_delays    = models.CommaSeparatedIntegerField(max_length=200)
    
    def save(self, *args, **kwargs):
        if self.id is None:
            self.link = createLink(self.__class__)
            
        super(Caption, self).save(*args, **kwargs)      
         
    def __str__(self):
        if(self.author == None): #Photo from foreign album
            name = "Anonymous/"+self.author_ip+"/"+str(self.id)
        else:
            userProfile = UserProfile.objects.get(user = self.author)
            name = userProfile.nickname+"/"+str(self.id)
            
        return name


class CaptionDTO(object):
    pass

#Node class for ManyToMany relation
class Node_Caption_Photo(models.Model):
    caption    = models.ForeignKey(Caption)
    photo      = models.ForeignKey(Photo)
    
    class Meta:
        unique_together = (("caption", "photo"),)


#
