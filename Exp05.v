module FA(v1,v2,vci,vsum,vco);
	input v1,v2,vci;
	output vsum,vco;
	wire t1,t2,t3,t4;
	
	xor x1(t1,v1,v2);	xor x2(vsum,t1,vci);
	and a1(t2,v2,vci);
	and a2(t3,v1,vci);
	and a3(t4,v1,v2);
	or o1(vco,t2,t3,t4);	
endmodule

module FourBit_Adder(num1,num2,carryIn,sum,carryOut);
	input [3:0]num1,num2;
	input carryIn;
	output [3:0]sum;
	output carryOut;
	wire btc1,btc2,btc3;
	FA m5(num1[0],num2[0],carryIn,sum[0],btc1);
	FA m6(num1[1],num2[1],btc1,sum[1],btc2);
	FA m7(num1[2],num2[2],btc2,sum[2],btc3);
	FA m8(num1[3],num2[3],btc3,sum[3],carryOut);	
endmodule

module BCD_Adder(No1,No2,BCDSum,Overflow);
	input [3:0]No1,No2;
	output [3:0]BCDSum;
	output Overflow;
	wire [3:0]tmp,tmp2;
	wire bt1,bt2,bt3,bt4;
	FourBit_Adder BCDA1(No1,No2,1'b0,tmp,bt1);
	or bo1(bt2,tmp[2],tmp[1]);
	and ba1(bt3,tmp[3],bt2);
	or bo2(Overflow,bt1,bt3);
	assign tmp2=(Overflow==1'b1)?4'b0110:4'b0000;
	FourBit_Adder BCDA2(tmp,tmp2,1'b0,BCDSum,bt4);
endmodule

module Main();
	reg [3:0]A,B,A_bcd,B_bcd;
	reg mod;
	wire [3:0]Bvalue,Ans,Ans_bcd;
	wire tc1,tc2,tc3,tcout,tcout_bcd;
	integer i,j;
	
	initial begin
	$dumpfile("Exp05.vcd");
	$dumpvars;
	mod=1'b0;
	A=4'b0000;	B=4'b0000;
	A_bcd=4'b0000;	B_bcd=4'b0000;
	$display("-------------------------------------------------------");
	$display("                  4-Bit Adder");
	$display("Time\tA\tB\tmod\tSum/Diff\tVout");
	$display("-------------------------------------------------------");
	for(i=0;i<16;i=i+1)
	begin
		for(j=0;j<16;j=j+1)
		begin
			#1
			$display("%g\t%b\t%b\t%b\t%b\t\t%b",$time,A,B,mod,Ans,tcout);
			B=B+4'b0001;
		end
		A=A+4'b0001;
	end
	#1
	$display("-------------------------------------------------------");
	$display("                  4-Bit Subtractor");
	$display("Time\tA\tB\tmod\tSum/Diff\tVout");
	$display("-------------------------------------------------------");
	mod=1'b1;
	A=4'b0000;	B=4'b0000;
	for(i=0;i<16;i=i+1)
	begin
		for(j=0;j<16;j=j+1)
		begin
			#1
			$display("%g\t%b\t%b\t%b\t%b\t\t%b",$time,A,B,mod,Ans,tcout);
			B=B+4'b0001;
		end
		A=A+4'b0001;
	end
	#1
	$display("-------------------------------------------------------");
	$display("              BCD Adder Output");
	$display("Time\tA\tB\tSum\tOverflow");
	$display("-------------------------------------------------------");
	for(i=0;i<10;i=i+1)
	begin
		for(j=0;j<10;j=j+1)
		begin
			#1
			$display("%g\t%b\t%b\t%b\t%b",$time,A_bcd,B_bcd,Ans_bcd,tcout_bcd);
			B_bcd=B_bcd+4'b0001;
		end
		A_bcd=A_bcd+4'b0001;
		B_bcd=4'b0000;
	end
	#1
	$finish;
	end
	
	xor x1(Bvalue[0],B[0],mod);
	xor x2(Bvalue[1],B[1],mod);
	xor x3(Bvalue[2],B[2],mod);
	xor x4(Bvalue[3],B[3],mod);
	FourBit_Adder AddCir(A,Bvalue,mod,Ans,tcout);
	BCD_Adder bcdAddCir(A_bcd,B_bcd,Ans_bcd,tcout_bcd);
	
endmodule