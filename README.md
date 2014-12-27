OSX-EmptyTrash
==============

Regularly remove old files fromt the trashbin to keep it organised.
The code was taken from the Apple Discussions forum: https://discussions.apple.com/thread/3172966

> Here's a script and launchagent that will do what you want:
First, copy the following into the Applescript editor, and save it as dated_deleter.scpt in (say) /Library/Scripts.  Set the security level and days to wait properties to what you want.
> second copy the following into a plain text file (use TextWrangler, or TextEdit in plain-text mode, don't use rich text), modify the /path/to/dated_deleter.scpt line so that it is a POSIX path to the script (if you use the above, that would be /Library/Scripts/dated_deleter.scpt) and save it as user.trash.dated.plist in ~/Library/LaunchAgents or /Library/LaunchAgents. (use the former if there's just one user on the machine; use the latter if you want it to apply to multiple users)
> Finally, open terminal and enter the command launchctl load /Library/LaunchAgents/user.trash.dated.plist (or alternately just restart the machine).  Either of these will load the plist into launchd as a job, launchd will wait until midnight of each day (hour 0, minute 0) and then run the dated_deleter script.  Basically the script writes the date into the items spotlight comments the first time it sees it in the trash, and then deletes it if the written date gets too old.
> 
> Two caveats:
> if you recover a file from the trash and then accidentally delete it again, it may be deleted next pass through unless you delete the key phrase from the spotlight comments.  you can do that in the Finder get info window.
> I noticed in testing that if I copy a file, run the deleter on it, delete it, and then copy the same file again for a second test, spotlight remembers the comments applied to the first file.  Somehow Spotlight recognizes that the new copy is identical to the old copy and retains information from the old - completely unexpected.  This might be an issue in odd cases if you do lots of file duplicating; if so we'll need to add in a routine that deletes the key phrase from spotlight comments before the file gets deleted.
