module Main();
	reg A1,A0,B1,B0;
	wire nA1,nA0,nB1,nB0,x,AG,BG,E,t1,t2,t3,t4,t5,t6;
	
	initial begin
	
	$dumpfile("Exp02.vcd");
	$dumpvars;
	A1=1'b0;
	$display("------------------------------------------------------------");
	$display("                       Comparator");
	$display("Time\tA\tB\tEqual\tA > B\tA < B");
	$display("------------------------------------------------------------");
	$monitor("%g\t%b%b\t%b%b\t%b\t%b\t%b",$time,A1,A0,B1,B0,E,AG,BG);

	A1=1'b0;	A0=1'b0;	B1=1'b0;	B0=1'b0;	#5
	A1=1'b0;	A0=1'b0;	B1=1'b0;	B0=1'b1;	#5
	A1=1'b0;	A0=1'b0;	B1=1'b1;	B0=1'b0;	#5
	A1=1'b0;	A0=1'b0;	B1=1'b1;	B0=1'b1;	#5
	A1=1'b0;	A0=1'b1;	B1=1'b0;	B0=1'b0;	#5
	A1=1'b0;	A0=1'b1;	B1=1'b0;	B0=1'b1;	#5
	A1=1'b0;	A0=1'b1;	B1=1'b1;	B0=1'b0;	#5
	A1=1'b0;	A0=1'b1;	B1=1'b1;	B0=1'b1;	#5
	A1=1'b1;	A0=1'b0;	B1=1'b0;	B0=1'b0;	#5
	A1=1'b1;	A0=1'b0;	B1=1'b0;	B0=1'b1;	#5
	A1=1'b1;	A0=1'b0;	B1=1'b1;	B0=1'b0;	#5
	A1=1'b1;	A0=1'b0;	B1=1'b1;	B0=1'b1;	#5
	A1=1'b1;	A0=1'b1;	B1=1'b0;	B0=1'b0;	#5
	A1=1'b1;	A0=1'b1;	B1=1'b0;	B0=1'b1;	#5
	A1=1'b1;	A0=1'b1;	B1=1'b1;	B0=1'b0;	#5
	A1=1'b1;	A0=1'b1;	B1=1'b1;	B0=1'b1;	#5
	
	$finish;
	end
	
	not n1(nA1,A1);	not n2(nA0,A0);	not n3(nB1,B1);	not n4(nB0,B0);
	xnor x1(t1,A0,B0);	xnor x2(t2,A1,B1);
	and a1(E,t1,t2);
	and a2(t3,A1,nB1);	and a3(t4,t2,A0,nB0);
	or o1(AG,t3,t4);
	and a4(t5,t2,B0,nA0);	and a5(t6,nA1,B1);
	or o2(BG,t5,t6);
	
endmodule