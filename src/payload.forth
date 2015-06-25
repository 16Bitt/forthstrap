%variable test

%: loopy
	65 test !
	~loopy-loop
		test @ emit
		test 1+!
	%goto loopy-loop
%;
