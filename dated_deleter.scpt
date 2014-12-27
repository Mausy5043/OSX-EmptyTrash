-- stolen from: https://discussions.apple.com/thread/3172966
property keyPhrase : "Trashed on: "
property securityLevel : 2 -- overwrites: 1=1-pass, 2=7-pass, 3=35-pass,  see man srm
property daysToWait : 7
 
tell application "Finder"
  -- get files in trash that are not new, and check dates
          set oldFiles to (every item of trash whose comment contains keyPhrase)
          set trashmeFiles to ""
          repeat with thisFile in oldFiles
  -- extract trashed date from the spotlight comments
                    set trashedDate to last item of my tid(comment of thisFile, keyPhrase)
                    try
  -- check dates in a try block in case of weirdness)
                              if my checkDate(trashedDate) then
                                        set trashmeFiles to trashmeFiles & " " & my makePosix(thisFile as alias)
                              end if
                    end try
          end repeat
 
  -- trash 'em in a subroutine
          my trashEm(trashmeFiles)
 
  -- gather new files
          set newFiles to every item of trash whose comment does not contain keyPhrase
  -- add the current date to the spotlight comment of the new files
          repeat with thisFile in newFiles
                    set c to comment of thisFile
                    if c = "" then
                              set comment of thisFile to keyPhrase & short date string of (current date)
                    else
                              set comment of thisFile to c & return & keyPhrase & short date string of (current date)
                    end if
          end repeat
end tell
 
on trashEm(fs)
  -- set up proper security level
          if securityLevel = 1 then
                    set cmd to "srm -rfsz"
          else if securityLevel = 3 then
                    set cmd to "srm -rfz"
          else
                    set cmd to "srm -rfmz"
          end if
 
  -- start a secure delete process in the background
          do shell script cmd & fs & " &> /dev/null &"
end trashEm
 
on tid(input, delim)
  -- generic subroutine to handle text items
          set {oldTID, my text item delimiters} to {my text item delimiters, delim}
          if class of input is list then
                    set output to input as text
          else
                    set output to text items of input
          end if
          set my text item delimiters to oldTID
          return output
end tid
 
on makePosix(f)
          return quoted form of POSIX path of f
end makePosix
 
on checkDate(d)
          return (date d) ≤ (current date) - daysToWait * days
end checkDate
