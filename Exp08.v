module MUX(s1,s0,Datain,DataOut);
	input s1,s0;
	input [3:0]Datain;
	output DataOut;
	assign DataOut=(s1==1'b1)?((s0==1'b1)?Datain[3]:Datain[2]):((s0==1'b1)?Datain[1]:Datain[0]);
endmodule
//---------------------------------------------------------------------------------------------------
module DEMUX(s1,s0,DataIn,d0,d1,d2,d3);
	input s1,s0,DataIn;
	output d0,d1,d2,d3;
	assign d0=(s1==1'b0)?((s0==1'b0)?DataIn:1'b0):1'b0;
	assign d1=(s1==1'b0)?((s0==1'b1)?DataIn:1'b0):1'b0;
	assign d2=(s1==1'b1)?((s0==1'b0)?DataIn:1'b0):1'b0;
	assign d3=(s1==1'b1)?((s0==1'b1)?DataIn:1'b0):1'b0;
endmodule
//---------------------------------------------------------------------------------------------------
module Main();
	reg s1,s0,Dip;
	reg [3:0]Dvin;
	wire Dout,da0,da1,da2,da3;
	integer i,j,k;
	
	initial begin
		$dumpfile("Exp08.vcd");
		$dumpvars;
		Dvin=4'b0000;	s1=1'b1;	s0=1'b1;	Dip=1'b0;
		$display("------------------------------------------");
		$display("        Multiplexer\n");
		$display("Time\ts1\ts0\tInput\tOutput");
		$display("------------------------------------------");
		for(i=0;i<2;i=i+1)
		begin
			s1=~s1;
			for(j=0;j<2;j=j+1)
			begin
				s0=~s0;
				for(k=0;k<16;++k)
				begin
					Dvin=k;
					#1;
					$display("%g\t%b\t%b\t%b\t%b",$time,s1,s0,Dvin,Dout);
				end
			end
		end
		s1=1'b1;	s0=1'b1;
		$display("------------------------------------------");
		$display("       Demultiplexer\n");
		$display("Time\ts1\ts0\tInput\tOutput");
		$display("------------------------------------------");
		for(i=0;i<2;i=i+1)
		begin
			s1=~s1;
			for(j=0;j<2;j=j+1)
			begin
				s0=~s0;
				Dip=1'b0;
				#1
				$display("%g\t%b\t%b\t%b\t%b%b%b%b",$time,s1,s0,Dip,da3,da2,da1,da0);
				Dip=1'b1;
				#1
				$display("%g\t%b\t%b\t%b\t%b%b%b%b",$time,s1,s0,Dip,da3,da2,da1,da0);
			end
		end
		$finish;
	end
	
	MUX m1(s1,s0,Dvin,Dout);
	DEMUX m2(s1,s0,Dip,da0,da1,da2,da3);
	
endmodule