( Forthstrap editor -- Austin Bittinger 10/23/15 )
memory.forth file.forth
: editor.forth ;





                ( Constants and variables )

( How big the scratchpad should be )
4 kilobytes constant small
8 kilobytes constant medium
16 kilobytes constant large

( Create our scratchpad )
object medium allot value scratch





                ( Data structures )





                ( Helper functions )




                ( Primary vocabulary )





                ( Cleanup )
