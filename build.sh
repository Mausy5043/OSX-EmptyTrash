echo "Copying the script will require administrator rights"
echo "Installing script"
sudo cp dated_deleter.scpt /Library/Scripts/

echo "Installing plist"
cp user.trash.dated.plist ~/Library/LaunchAgents/

echo "Activating script"
launchctl load ~/Library/LaunchAgents/user.trash.dated.plist
