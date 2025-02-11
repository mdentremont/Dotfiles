#compdef gt
###-begin-gt-completions-###
#
# yargs command completion script
#
# Installation: gt completion >> ~/.zshrc
#    or gt completion >> ~/.zprofile on OSX.
#
whence -w gt >/dev/null || return 0

_gt_yargs_completions() {
	local reply
	local si=$IFS
	IFS=$'
' reply=($(COMP_CWORD="$((CURRENT - 1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" gt --get-yargs-completions "${words[@]}"))
	IFS=$si
	_describe 'values' reply
}
compdef _gt_yargs_completions gt
###-end-gt-completions-###
