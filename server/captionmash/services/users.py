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
from datetime import datetime
from captionmash.models import UserProfile,UserDTO,Album
from django.contrib.auth.models import User
from django.core.exceptions import ObjectDoesNotExist

try:
    pyamf.register_class( UserDTO,  'com.captionmashup.common.model.local.dto.UserDTO')
except ValueError:
    None
    
class UserService:
    
    def getUsers(self):
        users = list(User.objects.all())
        user_array =  []
        for user in users:
            if not user.is_superuser:
                user_array.append(self.to_dto(user))
            
        return user_array 
    
    def checkEmail(self,email):
        result = bool       
        try:
            User.objects.get(username = email)
            result = False
        except ObjectDoesNotExist:
            result = True
        return result
    
    def checkNickname(self,nickname):
        result = bool
        try:
            UserProfile.objects.get(nickname = nickname)
            result = False
        except ObjectDoesNotExist:
            result = True
        return result
    
    def createUser(self,email,password,nickname):    
        user = User.objects.create_user(email, email, password)
        userProfile = UserProfile(user = user,nickname = nickname)
        userProfile.save()
        return user
    
    def save_ip(self,request):
        userProfile = UserProfile.objects.get(user = request.user)
        now = datetime.now()
        
        userProfile.last_login_date     = userProfile.current_login_date
        userProfile.current_login_date  = now
        
        userProfile.last_login_ip = userProfile.current_login_ip
        userProfile.current_login_ip = request.META['REMOTE_ADDR']
        
        userProfile.save()
    
    def to_dto(self,user):
        
        userDTO = UserDTO()
        userProfile = UserProfile.objects.get(user = user)
        
        userDTO.django_id       = user.id
        userDTO.username        = user.username
        userDTO.is_superuser    = user.is_superuser
        userDTO.nickname        = userProfile.nickname
        userDTO.thumb_path      = userProfile.thumb_path
        userDTO.photo_path      = userProfile.photo_path
        return userDTO
        
        