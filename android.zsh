function adbdata() {
  if [[ $1 == "on" ]]; then
    command=enable
  else
    command=disable
  fi
  adb shell svc data $command
}

function adbwifi() {
  if [[ $1 == "on" ]]; then
    command=enable
  else
    command=disable
  fi
  adb shell svc wifi $command
}

function adbtaps() {
  if [[ $1 == "on" ]]; then
    command=1
  else
    command=0
  fi
  adb shell content insert --uri content://settings/system --bind name:s:show_touches --bind value:i:$command
}

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

function adbproxy() {
  adbwifi off
  adbdata off
  sleep 1
  adbwifi on
  adbdata on
}

function strkey() {
  key=$(echo $1 | tr . _)
  echo "<string name=\"${key}_key\">${1}</string>" | pbcopy
}
