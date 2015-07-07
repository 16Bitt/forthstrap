macro rectangle xloc*, yloc*, wt*, ht*, col*
{
	push xloc
	push yloc
	push dword wt
	push dword ht
	push dword col
	call rect
}
