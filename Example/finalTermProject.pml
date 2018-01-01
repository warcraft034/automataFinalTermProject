/* Final Term Project: Concurrent Program Verification Using Automata */

show bool b0 = 0;
show bool b1 = 0;

active proctype A()
{	nc0: b0 = 1;
	t0: (b1 != 1);
	c0: b0 = 0;
	goto nc0
}

active proctype B()
{	nc1: b1 = 1;	
	t1:
	if
	:: (b0 == 1) ->
	   q1: b1 = 0;
	   q1p: (b0 != 1) -> goto nc1
	:: (b0 != 1) -> 
	   c1: b1 = 0;
	fi
	goto nc1
}
