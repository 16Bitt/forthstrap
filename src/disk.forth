( forthstrap FAT disk interface )
variable diskbuffer 
here @ diskbuffer ! 512 allot
: disk diskbuffer @ ;
: +diskbuffer disk + ;
variable num-sectors
variable num-heads
variable num-sectors-fat
variable num-sectors-cluster
variable num-reserved
variable num-bytes
variable num-entries
variable num-fats
variable disknum
( FAT constants )
: fat-bpb 0 0 1 ;
: diskinfo dup disknum ! disk swap fat-bpb diskread
24 +diskbuffer @ num-sectors !
26 +diskbuffer @ num-heads !
14 +diskbuffer @ num-reserved !
16 +diskbuffer c@ num-fats !
22 +diskbuffer @ num-sectors-fat !  
13 +diskbuffer c@ num-sectors-cluster ! 
17 +diskbuffer @ num-entries ! 
11 +diskbuffer @ num-bytes !
;
: fda 0 ;
: fdb 1 ;
variable head
variable sector
variable cylinder
: /% 2dup rem >r / r> ;
: lba2chs ( lba -- ) 
   num-sectors @ /% 1 + sector !
   num-heads @ /% head ! cylinder !
;
: diskstat 
   ." S: " sector @ . space
   ." C: " cylinder @ . space
   ." H: " head @ . space
;

: readblock ( block -- )
        lba2chs disk disknum @ cylinder @ head @ sector @
        diskread
;

