# Turn on/off mobile data
function adbdata() {
  if [[ $1 == "on" ]]; then
    command=enable
  else
    command=disable
  fi
  adb shell svc data $command
}

# Turn on/off wi-fi
function adbwifi() {
  if [[ $1 == "on" ]]; then
    command=enable
  else
    command=disable
  fi
  adb shell svc wifi $command
}

# Show/hide touches
function adbtaps() {
  if [[ $1 == "on" ]]; then
    command=1
  else
    command=0
  fi
  adb shell content insert --uri content://settings/system --bind name:s:show_touches --bind value:i:$command
}

# Prepare the device for demo mode:
#   - hides notifications from the status bar
#   - sets the clock to always be 9:00
#   - sets wi-fi and mobile data to the maximum signal
#   - sets the battery as not charging and 100%
#
# Useful for live demos and screenshots
function adbdemo() {
  if [[ $1 == "on" ]]; then
    adb shell settings put global sysui_demo_allowed 1
    adb shell am broadcast -a com.android.systemui.demo -e command clock -e hhmm 0900
    adb shell am broadcast -a com.android.systemui.demo -e command network -e wifi show -e level 4
    adb shell am broadcast -a com.android.systemui.demo -e command network -e mobile show -e datatype none -e level 4
    adb shell am broadcast -a com.android.systemui.demo -e command battery -e plugged false -e level 100
    adb shell am broadcast -a com.android.systemui.demo -e command notifications -e visible false
  else
    adb shell am broadcast -a com.android.systemui.demo -e command exit
  fi
}

# Wake up proxy by turning off and on wi-fi and mobile data
function adbproxy() {
  adbwifi off
  adbdata off
  sleep 1
  adbwifi on
  adbdata on
}

# Copy to clipboard a string resource from a dot-separated string key
function strkey() {
  key=$(echo $1 | tr . _)
  echo "<string name=\"${key}_key\">${1}</string>" | pbcopy
}

# Turn on/off system animations
# Useful to avoid flaky UI tests
function adbanim() {
  if [[ $1 == "on" ]]; then
    command=1
  else
    command=0
  fi
  adb shell settings put global window_animation_scale $command
  adb shell settings put global transition_animation_scale $command
  adb shell settings put global animator_duration_scale $command
}
