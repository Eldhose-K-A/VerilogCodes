module Main();
	reg A,B,Bin;
	wire FSub,Fbout,HSub,Hbout,t1,t2,t3,t4,nA;
	
	initial begin
	
	$dumpfile("Exp04.vcd");
	$dumpvars;
	A=1'b0;
	$display("-------------------------------------------------------------------------------------------------------------------------");
	$display("                                                  Subtractor");
	$display("Time\tA\tB\tBin\tFull_Subtractor_Diff\tFull_Subtractor_Bout\tHalf_Subtractor_Diff\tHalf_Subtractor_Bout");
	$display("-------------------------------------------------------------------------------------------------------------------------");
	$monitor("%g\t%b\t%b\t%b\t%b\t\t\t%b\t\t\t%b\t\t\t%b",$time,A,B,Bin,FSub,Fbout,HSub,Hbout);
	
	A=1'b0;	B=1'b0;	Bin=1'b0;	#5
	A=1'b0;	B=1'b0;	Bin=1'b1;	#5
	A=1'b0;	B=1'b1;	Bin=1'b0;	#5
	A=1'b0;	B=1'b1;	Bin=1'b1;	#5
	A=1'b1;	B=1'b0;	Bin=1'b0;	#5
	A=1'b1;	B=1'b0;	Bin=1'b1;	#5
	A=1'b1;	B=1'b1;	Bin=1'b0;	#5
	A=1'b1;	B=1'b1;	Bin=1'b1;	#5
	
	$finish;
	end
	
	not n1(nA,A);
	xor x1(t1,A,B);	xor x2(FSub,t1,Bin);
	and a1(t2,B,Bin);
	and a2(t3,nA,Bin);
	and a3(t4,nA,B);
	or o1(Fbout,t2,t3,t4);	
	xor x2(HSub,A,B);
	and a4(Hbout,nA,B);
	
endmodule