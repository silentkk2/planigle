package org.planigle.planigle.model
{
	import mx.collections.ArrayCollection;
	
	import org.planigle.planigle.commands.CreateReleaseCommand;
	
	[Bindable]
	public class ReleaseFactory
	{
		public var releases:ArrayCollection = new ArrayCollection();
		public var releaseSelector:ArrayCollection = new ArrayCollection();
		private var releaseMapping:Object = new Object();
		private static var instance:ReleaseFactory;
		
		public function ReleaseFactory(enforcer:SingletonEnforcer)
		{
			if (enforcer == null) 
				throw new Error("You Can Only Have One ReleaseFactory");
		}

		// Returns the single instance.
		public static function getInstance():ReleaseFactory
		{
			if (instance == null)
				instance = new ReleaseFactory(new SingletonEnforcer);
			return instance;
		}
		
		// Update my releases to be the specified releases.
		public function updateReleases( newReleases:ArrayCollection ):void
		{
			var newReleaseSelector:ArrayCollection = new ArrayCollection();
			releaseMapping = new Object();

			for each (var release:Release in newReleases)
			{
				newReleaseSelector.addItem(release);
				releaseMapping[release.id] = release;
			}
			
			var noRelease:Release = new Release();
			noRelease.name = "No Release";
			newReleaseSelector.addItem( noRelease );
			releases = newReleases;
			releaseSelector = newReleaseSelector;
		}

		// Populate the releases based on an Array of Releases.
		public function populate(releases:Array):void
		{
			updateReleases(new ArrayCollection(releases));
		}
		
		// Create a new release.  Params should be of the format (record[param]).  Success function
		// will be called if successfully updated.  FailureFunction will be called if failed (will
		// be passed an Array with errors).
		public function createRelease(params:Object, successFunction:Function, failureFunction:Function):void
		{
			var newRelease:Release = new Release();
			newRelease.populateFromObject(params);
			new CreateReleaseCommand(newRelease, successFunction, failureFunction).execute(null);
		}
		
		// An release has been successfully created.  Change myself to reflect the changes.
		public function createReleaseCompleted(newRelease:Release):Release
		{
			// Create copy to ensure any views get notified of changes.
			var newReleases:ArrayCollection = new ArrayCollection();
			for each (var release:Release in releases)
				newReleases.addItem(release);
			newReleases.addItem(newRelease);
			updateReleases(newReleases);
			return newRelease;
		}

		// Find an release given its ID.  If no release, return an Release representing the backlog.
		public function find(id:String):Release
		{
			var release:Release = releaseMapping[id];
			return release ? release : Release(releaseSelector.getItemAt(releaseSelector.length-1));	
		}
		
		// Answer the first release whose dates include today.  If none, return null.
		public function current():Release
		{
			for each (var release:Release in releases)
			{
				if(release.isCurrent())
					return release;
			}
			return null;
		}
	}
}

// Utility class to deny access to contructor.
class SingletonEnforcer {}