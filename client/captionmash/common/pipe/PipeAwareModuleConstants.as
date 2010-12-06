package com.captionmashup.common.pipe
{
	/**
	 * Store constants which are used by shell and modules
	 * to avoid references of a module within a shell at compiling time
	 */
	public class PipeAwareModuleConstants
	{
		//
		// vars

		//
		// const	
		public static const SHELL_TO_MODULE_PIPE:String = 'shellToModulePipe';			
		public static const MODULE_TO_SHELL_PIPE:String = 'moduleToShellPipe';

		public static const MODULE_TO_SHELL_MESSAGE: String = "moduleToShellMessage";

		//public static const SHELL_TO_MODULE_MESSAGE:String = 'shellToModuleMessage';
		
		//Creator Module
		public static const CREATOR_TO_SHELL_MESSAGE:String = "creatorToShellMessage";
		public static const SHELL_TO_CREATOR_MESSAGE:String = "shellToCreatorMessage";
		
		/**
		 * Standard output pipe name constant.
		 */
		public static const STDOUT:String 				= 'pipe/standard/output';
		
		/**
		 * Standard input pipe name constant.
		 */
		public static const STDIN:String 				= 'pipe/standard/input';
		
		/**
		 * Standard log pipe name constant.
		 */
		public static const STDLOG:String 				= 'pipe/standard/log';
		
		/**
		 * Standard shell pipe name constant.
		 */
		public static const STDSHELL:String 			= 'pipe/standard/shell';
		
		//Creator Pipe
		public static const CREATOR:String		= "pipe/creator";
		//
		// instances
		
		
		public function PipeAwareModuleConstants()
		{
			

		}

	}
}