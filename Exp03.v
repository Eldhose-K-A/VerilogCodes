module Main();
	reg A,B,Cin;
	wire FSum,Fcout,HSum,Hcout,t1,t2,t3,t4;
	
	initial begin
	
	$dumpfile("Exp03.vcd");
	$dumpvars;
	A=1'b0;
	$display("---------------------------------------------------------------------------------------------------");
	$display("                                            Adder");
	$display("Time\tA\tB\tCin\tFull_Adder_Sum\tFull_Adder_Cout\tHalf_Adder_Sum\tHalf_Adder_Cout");
	$display("---------------------------------------------------------------------------------------------------");
	$monitor("%g\t%b\t%b\t%b\t%b\t\t%b\t\t%b\t\t%b",$time,A,B,Cin,FSum,Fcout,HSum,Hcout);

	A=1'b0;	B=1'b0;	Cin=1'b0;	#5
	A=1'b0;	B=1'b0;	Cin=1'b1;	#5
	A=1'b0;	B=1'b1;	Cin=1'b0;	#5
	A=1'b0;	B=1'b1;	Cin=1'b1;	#5
	A=1'b1;	B=1'b0;	Cin=1'b0;	#5
	A=1'b1;	B=1'b0;	Cin=1'b1;	#5
	A=1'b1;	B=1'b1;	Cin=1'b0;	#5
	A=1'b1;	B=1'b1;	Cin=1'b1;	#5
	
	$finish;
	end
	
	xor x1(t1,A,B);	xor x2(FSum,t1,Cin);
	and a1(t2,B,Cin);
	and a2(t3,A,Cin);
	and a3(t4,A,B);
	or o1(Fcout,t2,t3,t4);	
	xor x2(HSum,A,B);
	and a4(Hcout,A,B);
	
endmodule