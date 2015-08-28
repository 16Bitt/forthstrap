( forthstrap FAT disk interface )

variable chs

chs is on

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
: fat-bpb chs @ if 0 0 1 else 0 then ;
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


: dirsize 32 ;
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

: loaddir ( disk pos -- )
   swap diskinfo
   num-fats @ num-sectors-fat @ * num-reserved @ + +
   lba2chs diskstat
   disk disknum @ cylinder @ head @ sector @ diskread
;

: [dir-size] 28 + ;
: [dir-name] ;
: [dir-attrib] 11 + ;
: [dir-low] 26 + ;

: ls 
   512 dirsize / 0 do
      disk i dirsize * + [dir-attrib] c@ dup 15 = swap 0 = + not if
         disk i dirsize * + dup dup [dir-name] .s [dir-size] dup 2 + @ . @ . 
         space ." bytes " space [dir-low] @ . space ." start " cr
      then
   loop
;
