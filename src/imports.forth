
( A library for smart imports -- Austin Bittinger 4/8/16 )
safelist.forth file.forth strlib.forth
: import.forth ;

Safelist searchpath

( Add a search directory )
: addpath ( path -- ) searchpath append ;

( Print all of the directories we search )
: showpath ( -- )
        searchpath len 0 do
                cr i searchpath [] .s
        loop
;

( Is the filename found in a given dir? )
: indir? ( filename index -- flag ) searchpath [] swap s+ file-exists? ;

( Find the respective directory of the file )
: finddir ( name -- index|false )
        0 swap
        searchpath len 0 do
                dup i indir? if
                        swap drop i swap
                then
        loop

        drop
;

( Import regardless of vocabulary existence )
: force-import ( name -- )
        dup finddir not if
                cr ." Failed to find file " .s space ." in search path "
        then

        dup finddir searchpath [] swap s+ load
;

( Import if the code doesn't already exist )
: import ( name -- )
        ( Already exists )
        dup find if drop exit then
        force-import
;

( Add a path that does not exist )
" /DOESNOTEXIST " addpath

( Add our default path )
" /usr/src/forthstrap/ " addpath
" ./src/ " addpath

forget1 indir?
forget1 finddir
forget1 searchpath
