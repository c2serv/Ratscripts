#!/usr/bin/bash
#Need to execute emacs find-file from current working directory of tmux pane
cwd=`tmux list-panes -F "#{window_id},active#{window_active},[#{window_layout}],#{pane_current_path}"|rev |cut -d, -f 1 |rev`;
#Find window corresponding to emacs, will find first emacs window
wnum=`ratpoison -c "windows %02n-%t" |grep emacs |cut -d '-' -f 1|head -n1`;
#ratpoison -c "echo #echo $wnum";
#ratpoison -c "select $wnum";
cd $cwd ;emacsclient -e "(call-interactively 'find-file)" -n  >/dev/null 2>&1 1
