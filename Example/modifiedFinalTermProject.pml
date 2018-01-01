/* Final Term Project: Concurrent Program Verification Using Automata */

show bool b0 = 1;
show bool b1 = 1;

active proctype A()
{	nc0: b0 = 1;
	t0: (b1 != 1);
	c0: b0 = 0;
	goto nc0
}

active proctype B()
{	nc1: b1 = 1;	
	t1: (b0 != 1);
	c1: b1 = 0;
	goto nc1
}
