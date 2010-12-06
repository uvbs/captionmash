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
from captionmash.models import Album,Photo,Network

DEFAULT_EXTENSION = "jpg"

class PhotoScript(object):
 
    def batch_photo_create(self,form):
        
        network_id      = form.cleaned_data['network_id']
        album_id        = form.cleaned_data['album_id']
        num_photos      = form.cleaned_data['num_photos']
        start_index     = form.cleaned_data['start_index']
        write_page_no   = form.cleaned_data['write_page_no']
        source_url      = form.cleaned_data['source_url']
        
        network = Network.objects.get(id = network_id)
        album   = Album.objects.get(id = album_id)
        
        if(start_index < 0 or num_photos <= 0):
            return
        
        for i in range(start_index,start_index+num_photos):
            
            
            photo_path  = album.s3_path +self.handle_index_format(i)+"."+DEFAULT_EXTENSION
            thumb_path  = album.s3_path +"tn_"+self.handle_index_format(i)+"."+DEFAULT_EXTENSION
            
            if(write_page_no):
                page_no = i
            else:
                page_no = 0
            
            if source_url == "":
                source_url = None
            
            photo = Photo(photo_path    = photo_path,
                          thumb_path    = thumb_path,
                          network       = network,
                          album         = album,
                          page_no       = page_no,
                          source_url    = source_url)
            
            photo.save()
        
        else:
            pass
        
        
    def handle_index_format(self,index):
        if index < 10:
            result = "00"+str(index)
        elif 9 < index < 100:
            result = "0"+str(index)
        else:
            result = str(index)

        return result

