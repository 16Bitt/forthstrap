( Library for overriding old words -- Austin Bittinger 5/31/2016 )
: defer.forth ;

variable deferred
: old ` deferred ! does> deferred @ , ;

forget1 deferred
