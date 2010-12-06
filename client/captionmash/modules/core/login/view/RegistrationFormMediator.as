package com.captionmashup.modules.core.login.view
{
	import com.captionmashup.common.pipe.message.core.PopupMessage;
	import com.captionmashup.modules.core.login.facade.ApplicationConstants;
	import com.captionmashup.modules.core.login.view.components.RegistrationForm.RegistrationForm;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.events.ValidationResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class RegistrationFormMediator extends Mediator
	{
		public static const NAME:String = "RegistrationFormMediator";
		
		private var nicknameTimer:Timer;
		private var emailTimer:Timer;
		private var registrationForm_displayed_flag:Boolean = false;

		public function RegistrationFormMediator(registrationForm:RegistrationForm)
		{
			super(NAME,registrationForm);

			//Spam prevention
			nicknameTimer 	= new Timer(2000,1);
			emailTimer		= new Timer(2000,1);
			
			nicknameTimer.addEventListener(TimerEvent.TIMER,onNicknameTimer);
			emailTimer.addEventListener(TimerEvent.TIMER,onEmailTimer);
			
			registrationForm.addEventListener(RegistrationForm.NICKNAME_TYPE,onNicknameType);
			registrationForm.addEventListener(RegistrationForm.EMAIL_TYPE,onEmailType);
			registrationForm.addEventListener(RegistrationForm.PASSWORD_TYPE,onPasswordType);
			registrationForm.addEventListener(RegistrationForm.PASSWORD_VERIFY_TYPE,onPasswordVerifyType);

			registrationForm.addEventListener(RegistrationForm.SUBMIT,onSubmit);
			registrationForm.addEventListener(RegistrationForm.CANCEL,onCancel);
			
			registrationForm.emailValidator.addEventListener(ValidationResultEvent.VALID,onEmailValid);
			registrationForm.emailValidator.addEventListener(ValidationResultEvent.INVALID,onEmailInvalid);
			
			registrationForm.passwordValidator.addEventListener(ValidationResultEvent.VALID,onPasswordValid);
			registrationForm.passwordValidator.addEventListener(ValidationResultEvent.INVALID,onPasswordInvalid);
			
			registrationForm.nicknameValidator.addEventListener(ValidationResultEvent.VALID,onNicknameValid);
			registrationForm.nicknameValidator.addEventListener(ValidationResultEvent.INVALID,onNicknameInvalid);
			
		}
		
		public function get registrationForm():RegistrationForm{
			return viewComponent as RegistrationForm;
		}
		
		
		/************************************
		 * Validation flags and variables
		 * *********************************/
		private var nickname_valid:Boolean 	= false;
		private var nickname_unique:Boolean	= false;
		
		private var password_valid:Boolean = false;
		private var password_match:Boolean = false;
		
		private var email_valid:Boolean 	= false;
		private var email_unique:Boolean	= false;
		
		private function get nickname_flag():Boolean{
			return nickname_valid && nickname_unique;
		}
		
		private function get password_flag():Boolean{
			return password_valid && password_match;
		}
		
		private function get email_flag():Boolean{
			return email_unique && email_valid;
		}
		
		/************************************
		 * Event Handlers
		 * **********************************/
		
		//Validation handlers
		
		private function onEmailValid(evt:ValidationResultEvent):void{
			trace("Email valid");
			email_valid = true;
		}
		
		private function onEmailInvalid(evt:ValidationResultEvent):void{
			trace("Email Invalid");
			email_valid = false;
		}
		
		private function onPasswordValid(evt:ValidationResultEvent):void{
			trace("Password valid");
			password_valid = true;
		}
		
		private function onPasswordInvalid(evt:ValidationResultEvent):void{
			trace("Password invalid");
			password_valid = false;
		}
		
		private function onNicknameValid(evt:ValidationResultEvent):void{
			trace("Nickname valid");
			nickname_valid = true;
		}
		
		private function onNicknameInvalid(evt:ValidationResultEvent):void{
			trace("Nickname invalid");
			nickname_valid = false;
		}
		

		//Activate validators of viewcomponent
		
		private function onNicknameType(evt:Event):void{
			//Timer reset
			nicknameTimer.reset();
			nicknameTimer.start();
			
			nickname_unique = false;
			registrationForm.nicknameCheckCross.animatePending();
			registrationForm.nicknameValidator.validate();
			updateRegistrationForm();
		}

		private function onPasswordType(evt:Event):void{

			registrationForm.passwordValidator.validate();
			registrationForm.passwordVerifyContainer.visible = true;
			updateRegistrationForm();
			trace("onPasswordType, text:"+registrationForm.passwordInput.text);
		}
		
		private function onPasswordVerifyType(evt:Event):void{
			
			if(registrationForm.passwordInput.text != registrationForm.passwordVerifyInput.text)
			{
				password_match = false;
			}else{
				password_match = true;
			}
			updateRegistrationForm();
			trace("onPasswordVerifyType, text:"+registrationForm.passwordVerifyInput.text);
		}

		private function onEmailType(evt:Event):void{
			//Reset timer
			emailTimer.reset();
			emailTimer.start();
			email_unique = false;
			registrationForm.emailValidator.validate();
			registrationForm.emailCheckCross.animatePending();
			updateRegistrationForm();
			trace("onEmailType, text:"+registrationForm.emailInput.text );
		}

		
		
		private function onSubmit(evt:Event):void{
			trace("onSubmit called");
			registrationForm.enabled = false;
			sendNotification(ApplicationConstants.CREATE_USER);
		}
		
		private function onCancel(evt:Event):void{
			trace("onCancel called");
			removeRegistrationForm();
		}
		
		/********************************
		 * Nickname check
		 * *****************************/
		private function onNicknameTimer(evt:TimerEvent):void{
			
			if(!nickname_valid) return;
			registrationForm.nicknameCheckCross.animatePending();
			sendNotification(ApplicationConstants.CHECK_UNIQUE_NICKNAME,registrationForm.nicknameInput.text);
		}
		
		/********************************
		 * Email check
		 * ******************************/
		private function onEmailTimer(evt:TimerEvent):void{
			if(!email_valid) return;
			registrationForm.emailCheckCross.animatePending();
			sendNotification(ApplicationConstants.CHECK_UNIQUE_EMAIL,registrationForm.emailInput.text);
		}
		
		
		/*********************************
		 * Email check
		 * *******************************/

		/********************************
		 * Updates submit button using
		 * username, password,email checks
		 * *******************************/
		private function updateRegistrationForm():void{
			
			//registrationForm.usernameLengthError.visible	= !username_flag;
			//registrationForm.passwordError.visible 	= !password_flag && is_password_field_active; 
			//registrationForm.emailError.visible		= !email_flag && is_email_field_active;;
			
			registrationForm.submitButton.enabled = nickname_flag && password_flag && email_flag;
		}
		
		private function updateEmailField(value:Boolean):void{
			registrationForm.emailCheckCross.valid = value;
			updateRegistrationForm();
		}
		
		private function updateNicknameField(value:Boolean):void{
			registrationForm.nicknameCheckCross.valid = value;
			updateRegistrationForm();
		}
		
		private function removeRegistrationForm():void{
			var popupMessage:PopupMessage = new PopupMessage(PopupMessage.REMOVE_POPUP,registrationForm);
			sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,popupMessage);
		}
		
		/*****************************************
		 * Notification Interests and handlers
		 * ***************************************/
		override public function listNotificationInterests():Array
		{
			return [
				ApplicationConstants.POPUP_REGISTRATION,
				ApplicationConstants.EMAIL_UNIQUE,
				ApplicationConstants.EMAIL_NOT_UNIQUE,
				ApplicationConstants.NICKNAME_UNIQUE,
				ApplicationConstants.NICKNAME_NOT_UNIQUE,
				ApplicationConstants.USER_RETRIEVED,
			];
		}
		
		override public function handleNotification(notification:INotification):void
		{
			switch (notification.getName())
			{
				case ApplicationConstants.USER_RETRIEVED:
					removeRegistrationForm();
					registrationForm.enabled = true;
					if(registrationForm_displayed_flag)registrationForm.clear();
					break;
				
				case ApplicationConstants.POPUP_REGISTRATION:
					registrationForm_displayed_flag = true;
					var popupMessage:PopupMessage = new PopupMessage(PopupMessage.CREATE_MODAL_POPUP,registrationForm);
					sendNotification(ApplicationConstants.SEND_MESSAGE_TO_SHELL,popupMessage);
					break;
				
				case ApplicationConstants.EMAIL_UNIQUE:
					email_unique = true;
					updateEmailField(email_unique);
					break;
				
				case ApplicationConstants.EMAIL_NOT_UNIQUE:
					email_unique = false;
					updateEmailField(email_unique);
					break;
				
				case ApplicationConstants.NICKNAME_UNIQUE:
					nickname_unique = true;
					updateNicknameField(nickname_unique);
					break;
				
				case ApplicationConstants.NICKNAME_NOT_UNIQUE:
					nickname_unique = false;
					updateNicknameField(nickname_unique);
					break;
					
			}
		}
		
		
		
	}
}