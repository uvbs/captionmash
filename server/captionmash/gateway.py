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

TODO: Map urls to services and remove method names from gateway
'''
import pyamf
from pyamf.remoting.gateway.django import DjangoGateway
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User
from captionmash import views
from captionmash.services.captions  import CaptionService
from captionmash.services.users     import UserService
from captionmash.services.genres    import GenreService
from captionmash.services.albums    import AlbumService
from captionmash.services.photos    import PhotoService

try:
    pyamf.register_class( User,  'django.contrib.auth.models.User')
except ValueError:
    print "Classes already registered"


def testGateway(request):
    return "Test gateway message"

def login_user(http_request,username,password):
    user = authenticate(username=username, password=password)
    userService = UserService()
    if user is not None:
        login(http_request, user)
        userService.save_ip(http_request)
        return userService.to_dto(user)
    return None

def logout_user(http_request):
    logout(http_request)
    return True
    
def create_user(http_request,email,password,nickname):
    userService = UserService()
    userService.createUser(email, password, nickname)
    user = authenticate(username=email, password=password)
    login(http_request, user)
    userService.save_ip(http_request)
    return userService.to_dto(user)

def get_user(http_request):
    userService = UserService()
    if http_request.user.is_authenticated():
        return userService.to_dto(http_request.user)
    return None

'''User Methods'''
def getUsers(http_request):
    userService = UserService()
    return userService.getUsers()

def checkNickname(http_request,nickname):
    userService = UserService()
    return userService.checkNickname(nickname)

def checkEmail(http_request,email):
    userService = UserService()
    return userService.checkEmail(email)

'''Genre Methods'''
def getGenres(http_request):
    genreService = GenreService()
    return genreService.getGenres()

'''Album Methods'''
def getGenreAlbums(http_request,genre_id):
    albumService = AlbumService()
    return albumService.getGenreAlbums(genre_id)

def getUserAlbums(http_request,user_id):
    albumService = AlbumService()
    return albumService.getUserAlbums(user_id)

def createAlbum(http_request,album_name):
    albumService = AlbumService()
    albumService.createAlbum(album_name, http_request.user)
    return albumService.getUserAlbums(http_request.user.id)

def deleteAlbum(http_request,album_id):
    albumService = AlbumService()
    albumService.deleteAlbum(album_id, http_request.user)
    return albumService.getUserAlbums(http_request.user.id)

'''Photo Methods'''
def getPhotoByLink(http_request,photo_link):
    photoService = PhotoService()
    return photoService.getPhotoByLink(photo_link)

def getAlbumPhotos(http_request,album_id):
    photoService = PhotoService()
    return photoService.getAlbumPhotos(album_id)

def getLatestCaptionedPhotos(http_request):
    photoService = PhotoService()
    return photoService.getLatestCaptionedPhotos()

def getLatestAddedPhotos(http_request):
    photoService = PhotoService()
    return photoService.getLatestAddedPhotos()

def deletePhoto(http_request,photo_id):
    photoService = PhotoService()
    return photoService.deletePhoto(photo_id,http_request.user)

def updatePhotoGateway(http_request,photoDTO):
    photoService = PhotoService()
    return photoService.updatePhoto(photoDTO,http_request.user)

'''Caption Methods'''
def getCaptions(request):
    captionService = CaptionService()
    return captionService.getLatestCaptions()

def addCaption(http_request,captionDTO):
    captionService = CaptionService()
    return captionService.addCaption(http_request,captionDTO)

def getCaptionByLink(http_request,caption_link):
    captionService = CaptionService()
    return captionService.getCaptionByLink(caption_link)

services = {
    'AccountService.userLogin'          : login_user,       
    'AccountService.userLogout'         : logout_user,
    'AccountService.getUser'        : get_user,
    'AccountService.createUser'     : create_user,
    'AccountService.checkNickname'  : checkNickname,
    'AccountService.checkEmail'     : checkEmail,
    'AccountService.getUsers'        : getUsers,

    
    
    'AlbumService.getGenres'            : getGenres,
    'AlbumService.getGenreAlbums'       : getGenreAlbums,
    'AlbumService.getUserAlbums'        : getUserAlbums,
    'AlbumService.getAlbumPhotos'       : getAlbumPhotos,
    'AlbumService.getPhotoByLink'       : getPhotoByLink,

    'AlbumService.deletePhoto'          : deletePhoto,
    'AlbumService.savePhoto'            : updatePhotoGateway,
    'AlbumService.createAlbum'          : createAlbum,
    'AlbumService.deleteAlbum'          : deleteAlbum,
    'AlbumService.getLatestCaptionedPhotos'      : getLatestCaptionedPhotos,
    'AlbumService.getLatestAddedPhotos'          : getLatestAddedPhotos,
    
    
    "CaptionService.addCaption"         : addCaption,
    "CaptionService.getLatestCaptions"  : getCaptions,
    "CaptionService.getCaptionByLink"     : getCaptionByLink,

}

gw = DjangoGateway(services,expose_request=True)