
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
 SESSION_TYPE="remote"
# many other tests omitted
else
  case $(ps -o comm= -p $PPID) in
    sshd|*/sshd) SESSION_TYPE="remote";;
  esac
fi
echo $SESSION_TYPE
export SESSION_TYPE=$SESSION_TYPE
