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
import settings
from django.http import HttpResponsePermanentRedirect,HttpResponseRedirect

from django.shortcuts import render_to_response,Http404,HttpResponse
from captionmash.services.uploads import UploadService

from forms import photos
from scripts.photos import PhotoScript

if settings.DEBUG == True:
    APP_URL = "client_debug.html"
else:
    APP_URL = "client_production.html"
    
def receive_file(request):
    uploadService = UploadService()
    file     = request.FILES['file']
    user_id  = request.POST['user_id']
    album_id = request.POST['album_id']
    uploadService.receive_single_file(file, user_id, album_id)
    return HttpResponse()

def redirect_to_blog(request):
    return HttpResponsePermanentRedirect('http://captionmash.posterous.com/')


def show_app(request):
    return render_to_response(APP_URL)

def show_caption_by_id(request):
    caption_link = request.GET.get('c')
    return render_to_response(APP_URL, {'caption_link': caption_link})

def start_creation(request):
    template_link = request.GET.get('t') #Not implemented yet
    album_link	  = request.GET.get('a') #Not implemented yet
    photo_link    = request.GET.get('p') 
    
    if	template_link is not None: 	     #Creation from template
        return render_to_response(APP_URL, {'template_link': template_link})
    elif album_link is not None: 		 #Creation from album
        return render_to_response(APP_URL, {'album_link': album_link})
    else: 							     #Creation from single photo
        return render_to_response(APP_URL, {'photo_link': photo_link})
    
#Used by admin to create photo entries for uploaded official albums
def batch_photo_create(request):
    if request.user.is_superuser:
        if request.method == 'POST':
            
            form = photos.BatchCreateForm(request.POST)
            if form.is_valid():
                script = PhotoScript()
                script.batch_photo_create(form)
                return HttpResponseRedirect('/admin/')
        else:
            form = photos.BatchCreateForm() # An unbound form
            return render_to_response('batch_photo_create.html', {
                                        'form': form,
                                    })
    else:
        raise Http404
    
def image_example(request):
    return render_to_response('image_demo.html')