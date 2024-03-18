set mainScreenIDStr to do shell script "/opt/homebrew/bin/yabai -m query --displays --display | /opt/homebrew/bin/jq -r '.id'"
set mainScreenID to mainScreenIDStr as number
-- dont ask me why i put this here, it just works. obviously importing the frameworks breaks the script
use framework "Foundation"
use framework "CoreGraphics"
set screenWidth to current application's CGDisplayPixelsWide(mainScreenID)
set screenHeight to current application's CGDisplayPixelsHigh(mainScreenID)
-- Calculate the center of the screen
set centerX to screenWidth / 2
set centerY to screenHeight / 2

-- Create a point at the center of the screen
set centerPoint to current application's NSMakePoint(centerX, centerY)

-- Move the mouse cursor to the center of the screen
current application's CGDisplayMoveCursorToPoint(mainScreenID, centerPoint)