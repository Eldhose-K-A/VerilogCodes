module Main();
	reg a,b;
	wire and1,or1,nota,notb,nand1,nor1,xor1,xnor1;
	
	initial begin
	
	$dumpfile("Exp01.vcd");
	$dumpvars;
	a=1'b0;
	$display("-------------------------------------------------------------------------------------");
	$display("                               Basic Logic Gates");
	$display("Time\tA\tB\tAnd\tOr\tNot A\tNot B\tNand\tNor\tXor\tXnor");
	$display("-------------------------------------------------------------------------------------");
	$monitor("%g\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b",$time,a,b,and1,or1,nota,notb,nand1,nor1,xor1,xnor1);
	
	a=1'b0;	b=1'b0;
	#5	a=1'b0;	b=1'b1;
	#5	a=1'b1;	b=1'b0;
	#5	a=1'b1;	b=1'b1;
	#5
	$finish;
	end
	
	and a1(and1,a,b);
	or o1(or1,a,b);
	not n1(nota,a);
	not n2(notb,b);
	nand na1(nand1,a,b);
	nor no1(nor1,a,b);
	xor x1(xor1,a,b);
	xnor x2(xnor1,a,b);
	
endmodule