( forthstrap FAT disk interface )

variable chs

chs is on

variable diskbuffer 
here @ diskbuffer ! 512 allot

( FAT constants )
: fat-bpb 0 0 1 ;
: bytes-per-sector ;

: chs2lba 
