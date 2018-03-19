module ModNineCounter(clkIn,Dat);
	input clkIn;
	output [3:0]Dat;
	reg [3:0]count=4'b0000;
	
	always @(clkIn)
	begin
		count=count+4'b0001;
		if(count==4'b1001)
			count=4'b0000;
	end
	
	assign Dat=count;
endmodule
//---------------------------------------------------------------------------------------------------
module Main();
	reg clk,sigip;
	wire [3:0]value;
	
	initial begin
		$dumpfile("Exp09.vcd");
		$dumpvars;
		clk=1'b0;	
		$display("------------------------------------------");
		$display("        Mod 9 Counter\n");
		$display("Time\tClk\tOutput");
		$display("------------------------------------------");
		$monitor("%g\t%b\t%b",$time,clk,value);
		#30;
		$finish;
	end
	
	always begin
		#1 clk=~clk;
	end
	
	ModNineCounter m1(clk,value);
	
endmodule