package org.planigle.planigle.commands
{
	import org.planigle.planigle.business.Delegate;
	import org.planigle.planigle.business.ProjectsDelegate;

	public class DeleteProjectCommand extends DeleteCommand
	{
		public function DeleteProjectCommand(object:Object, aSuccessFunction:Function, aFailureFunction:Function)
		{
			super(object, aSuccessFunction, aFailureFunction);
		}

		// This should be overriden by subclasses to provide the specific delegate class.
		override protected function createDelegate():Delegate
		{
			return new ProjectsDelegate( this )
		}
	}
}