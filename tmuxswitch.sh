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

case $DIR in
    n)
	case $result in
	    emacs)
		emacsclient -e "(next-buffer)"
		exit 0
		;;
	esac
	result=`ratpoison -c "info %t"`
	case $result  in
	    tmux*) 
		tmux next
		;;
		*)
		ratpoison -c "meta s-n"
		exit 0 
		;;
	esac
	;;
    p)
	case $result in
	    emacs)
		emacsclient -e "(previous-buffer)"
		exit 0
		;;
	esac
	result=`ratpoison -c "info %t"`
	case $result  in
	    tmux*) 
		tmux prev
		;;
		*)
		ratpoison -c "meta s-p"
		exit 0 
		;;
	esac
	;;

esac

