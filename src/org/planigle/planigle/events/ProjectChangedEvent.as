package org.planigle.planigle.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import flash.events.Event;
	import org.planigle.planigle.model.ViewModelLocator;
	
	public class ProjectChangedEvent extends CairngormEvent
	{
		public static const PROJECT_CHANGED:String = "ProjectChanged";
		
		public function ProjectChangedEvent()
		{
			// Call Caignorm constructor.
			super(PROJECT_CHANGED);
			ViewModelLocator.getInstance().waitingForData();
		}
		
		// Must override the Cairgnorm clone funtion.
		override public function clone():Event
		{
			return new ProjectChangedEvent();
		}
	}
}