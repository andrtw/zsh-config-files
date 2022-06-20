# Print each PATH entry on a separate line
alias path='echo -e ${PATH//:/\\n}'

export JAVA_HOME="$(/usr/libexec/java_home)"
export ANDROID_HOME="$HOME/Library/Android/sdk"

path+=$ANDROID_HOME/emulator
path+=$ANDROID_HOME/tools
path+=$ANDROID_HOME/platform-tools
