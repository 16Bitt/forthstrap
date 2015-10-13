( Forthstrap vocabulary for UNIX operations )
file.forth
: unix.forth ;

: cat ( s1 s2 ... sn n )
   0 do
      file-read .s
   loop
;
