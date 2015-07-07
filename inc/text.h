	use32

macro draw_text s*, col*, x*, y* {
	push s
	push col
	push x
	push y
	call text
}
