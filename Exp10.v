module ShiftRegister(din,clkIn,dout);
	input din,clkIn;
	output [3:0]dout;
	reg [3:0]value=4'b0000;
	
	always @(clkIn)
	begin
		value=value>>1;
		value[3]=din;
	end
	
	assign dout=value;
endmodule
//---------------------------------------------------------------------------------------------------
module Main();
	reg clk,sin;
	wire [3:0]data;
	integer i;
	initial begin
		$dumpfile("Exp10.vcd");
		$dumpvars;
		clk=1'b0;	sin=1'b1;	
		$display("------------------------------------------");
		$display("      Serial To Parallel Converter\n");
		$display("Time\tClk\tInput\tOutput");
		$display("------------------------------------------");
		$monitor("%g\t%b\t%b\t%b",$time,clk,sin,data);
		for(i=0;i<2;i=i+1)
		begin
			sin=~sin;
			#4
			sin=~sin;
			#4;
		end
		$finish;
	end
	
	always begin
		#1 clk=~clk;
	end
	
	ShiftRegister s1(sin,clk,data);
	
endmodule