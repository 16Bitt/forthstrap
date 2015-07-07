;Load eax with a properly adjusted 565 16bit color
macro to565 r, g, b {
	push ((r and 0xF8) shl 8) or ((g and 0xFC) shl 3) or (b shr 3)
}
