#!/usr/bin/bash
#Used for going forward or backward a buffer and emacs 
#as well as in tmux.  Takes as an argument either n for next
#or p for previous.  This command is bound to s-n and s-p
#in ratpoison with
#definekey top s-p  exec ~/bin/tmuxswitch p 
#definekey top s-n  exec ~/bin/tmuxswitch n
#The command determines if the current frame is tmux 
#or emacs and changes the buffer or window accordingly.
#If not in emacs or tmux, the function passes the  s-n or s-p to
#the frame. 


#Determine Direction
DIR=$1 
#Determine current frame
result=`ratpoison -c "info %a"`

#Go forward or backward accordingly
if [ "$DIR" == "n" ]
then
if [ "$result" == "emacs" ]
then  emacsclient -e "(next-buffer)"
else  
result=`ratpoison -c "info %t"`
if  echo $result |grep "tmux" -q 
then 
tmux next
else  
ratpoison -c "meta s-n"
exit 0 
fi
fi
ratpoison -c "meta s-n"
exit 0 
fi


if [ "$DIR" == "p" ]
then
if [ "$result" == "emacs" ]
then   emacsclient -e "(previous-buffer)"; exit 0
else  
result=`ratpoison -c "info %t"`
if  echo "$result" |grep "tmux" -q 
then 
tmux prev #tmuxfocus.sh D
else
ratpoison -c "meta s-p"
exit 0 #ratpoison -c "focusdown"
fi
fi
ratpoison -c "meta s-p"
exit 0 
fi
