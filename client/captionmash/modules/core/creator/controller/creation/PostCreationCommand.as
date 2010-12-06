package com.captionmashup.modules.core.creator.controller.creation
{
	import com.adobe.serialization.json.JSON;
	import com.captionmashup.common.model.local.dto.CaptionDTO;
	import com.captionmashup.common.model.local.vo.Frame.Frame;
	import com.captionmashup.common.pipe.message.core.CreatorMessage;
	import com.captionmashup.common.view.bubble.BubblePanel;
	import com.captionmashup.common.log.t;
	import com.captionmashup.modules.core.creator.facade.ApplicationConstants;
	import com.captionmashup.modules.core.creator.model.CreatorFrameProxy;
	import com.captionmashup.modules.core.creator.model.CreatorProxy;
	import com.captionmashup.modules.core.creator.view.CreatorMediator;
	
	import mx.rpc.AsyncResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;
	
	public class PostCreationCommand extends SimpleCommand implements ICommand
	{
		private var creatorProxy:CreatorProxy;
		private var frameProxy:CreatorFrameProxy;
		private var creatorMediator:CreatorMediator;
		
		/*************************
		 * Serialization variables
		 * ***********************/
		//Array of captionVOs of a particular Frame
		private var captionArray:Array;
		
		//Upper layer array holding other data arrays
		private var creationArray:Array;
		
		//Serialized form of creationArray for database storage
		private var creationData:String; 
		
		override public function execute(notification:INotification):void
		{
			
			creatorProxy 	= facade.retrieveProxy(CreatorProxy.NAME) as CreatorProxy;
			frameProxy 		= facade.retrieveProxy(CreatorFrameProxy.NAME) as CreatorFrameProxy;
			creatorMediator = facade.retrieveMediator(CreatorMediator.NAME) as CreatorMediator;
			
			var frames:Array = frameProxy.frames.source;

			var responder:AsyncResponder = new AsyncResponder(resultHandler,faultHandler);
			
			var captionDTO:CaptionDTO = createCaptionDTO(frames);

			trace("PostCreationCommand called from Module: Creator");
			t.obj(captionDTO,"captionDTO in PostCreationCommand");
			
			creatorProxy.addCaption(captionDTO,responder);		
		}
		
		private function resultHandler(evt:ResultEvent,token:Object= null):void
		{
			t.obj(evt.result,"evt.result in PostCreationCommand");
			
			//Send success notification
			sendNotification(ApplicationConstants.POST_SUCCESSFUL);
			
			//Clear frames
			frameProxy.frames = null;
			creatorProxy.setData(null); //No data is being stored already
			
			sendNotification( ApplicationConstants.SEND_MESSAGE_TO_SHELL,
				new CreatorMessage(CreatorMessage.END_CREATE,evt.result as CaptionDTO));
			
			//sendNotification( ApplicationConstants.DISPOSE);
		}
		
		private function faultHandler(evt:FaultEvent,token:Object=null):void
		{
			t.obj(evt.fault,"evt.fault in PostCreationCommand");	
		}
		
		//Creates a captionDTO using an array of frames
		private function createCaptionDTO(frames:Array):CaptionDTO{
			var captionDTO:CaptionDTO = new CaptionDTO();

			var allFramesCaptions:Array = new Array;
			var singleFrameCaptions:Array;
			

			for each(var frame:Frame in frames){
				//Add photoDTO to captionDTO
				captionDTO.photos.push(frame.photo);
				captionDTO.frame_delays.push(frame.delay);
				singleFrameCaptions = new Array;

				for each(var bubblePanel:BubblePanel in frame.captions)
				{
					singleFrameCaptions.push(bubblePanel.getCaptionVO());
				}
				allFramesCaptions.push(singleFrameCaptions);	
			}
			
			//captionDTO.testArray = allFramesCaptions;
			captionDTO.caption_data = JSON.encode(allFramesCaptions);
			
			//Set 1st frame's photo as cover photo
			var firstFrame:Frame = frames[0] as Frame;		
			captionDTO.setCoverPhoto(firstFrame.photo.thumb_path,firstFrame.photo.photo_path);
			
			return captionDTO;
		}
	
	}
}