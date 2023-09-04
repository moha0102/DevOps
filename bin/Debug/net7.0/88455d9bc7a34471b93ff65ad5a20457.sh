function list_child_processes () {
    local ppid=$1;
    local current_children=$(pgrep -P $ppid);
    local local_child;
    if [ $? -eq 0 ];
    then
        for current_child in $current_children
        do
          local_child=$current_child;
          list_child_processes $local_child;
          echo $local_child;
        done;
    else
      return 0;
    fi;
}

ps 91789;
while [ $? -eq 0 ];
do
  sleep 1;
  ps 91789 > /dev/null;
done;

for child in $(list_child_processes 91814);
do
  echo killing $child;
  kill -s KILL $child;
done;
rm /Users/moha/Projects/DevOps/bin/Debug/net7.0/88455d9bc7a34471b93ff65ad5a20457.sh;
