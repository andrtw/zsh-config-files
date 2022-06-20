alias killjava="ps -ef | grep java | grep -v grep | tr -s ' ' | cut -d ' ' -f 3 | xargs kill -9"

# Update the Java version to use for the session
function jdk() {
  version=$1
  export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
  java -version
}
