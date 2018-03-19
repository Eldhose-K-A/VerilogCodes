module ShiftRegister(din,clkIn,data,dout);
	input din,clkIn;
	output dout;
	output [3:0]data;
	reg [3:0]value=4'b0000;
	reg t1;
	
	always @(clkIn)
	begin
		t1=value[0];
		value=value>>1;
		value[3]=din;
	end
	
	assign data=value;
	assign dout=t1;
endmodule
//---------------------------------------------------------------------------------------------------
module Main();
	reg clk,sin,tmp2,tmp4;
	wire [3:0]data1,data2;
	wire tmp1,tmp3;
	integer i;
	
	initial begin
		$dumpfile("Exp11.vcd");
		$dumpvars;
		clk=1'b0;	sin=1'b1;	tmp2=1'b1; tmp4=1'b1;
		$display("------------------------------------------");
		$display("      Ring And Johnson Counters\n");
		$display("            Johnson Counter  Ring Counter");
		$display("Time\tClk\tOutput\t\tOutput");
		$display("------------------------------------------");
		for(i=1;i<=20;i=i+1)
		begin
			$display("%g\t%b\t%b\t\t%b",$time,clk,data1,data2);
			#1	tmp2=~tmp1;	tmp4=tmp3;
		end
		$finish;
	end
	
	always begin
		#1 clk=~clk;
	end
	
	ShiftRegister s1(tmp2,clk,data1,tmp1);
	ShiftRegister s2(tmp4,clk,data2,tmp3);
endmodule