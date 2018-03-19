module SRFlipFlop(sin,rin,clkin,qout,qnout);
	input sin,rin,clkin;
	output qout,qnout;
	wire t1,t2;
	nand n1(t1,sin,clkin);
	nand n2(t2,rin,clkin);
	nand n3(qout,t1,qnout);
	nand n4(qnout,t2,qout);	
endmodule
//-------------------------------------------------------------
module DFlipFlop(Din,clkin,qout,qnout);
	input Din,clkin;
	output qout,qnout;
	SRFlipFlop sr1(Din,~Din,clkin,qout,qnout);
endmodule
//-------------------------------------------------------------
module JKFlipFlop(jin,kin,clkin,qout,qnout);
	input jin,kin,clkin;
	output qout,qnout;
	reg temp;
	always @(clkin)
	begin
		if((jin==1'b0)&&(kin==1'b1))
		begin
			temp=1'b0;
		end
		else if((jin==1'b1)&&(kin==1'b0))
		begin
			temp=1'b1;
		end
		else if((jin==1'b1)&&(kin==1'b1))
		begin
			temp=~temp;
		end
		else if((jin==1'b0)&&(kin==1'b0))
		begin
			temp=temp;
		end
	end
	assign qout=temp;
	assign qnout=~temp;
endmodule
//-------------------------------------------------------------
module TFlipFlop(tin,clkin,qout,qnout);
	input tin,clkin;
	output qout,qnout;
	reg temp2=1'b0;
	
	always @(posedge clkin)
	begin
		if(tin==1'b0)
			temp2=temp2;
		else
			temp2=~temp2;
	end
	assign qout=temp2;
	assign qnout=~temp2;
		
endmodule
//-------------------------------------------------------------
module MasterSlaveJK(jin,kin,clkin,qout,qnout);
	input jin,kin,clkin;
	output qout,qnout;
	wire t1,t2;

	JKFlipFlop jk1(jin,kin,clkin,t1,t2);
	JKFlipFlop jk2(t1,t2,~clkin,qout,qnout);
	
endmodule
//-------------------------------------------------------------
module Main();
	reg D,S,R,J,K,T,clk;
	wire Qsr,Qnsr,Qd,Qnd,Qjk,Qnjk,Qt,Qnt,Qmsjk,Qnmsjk;
		
	initial begin
		$dumpfile("Exp06.vcd");
		$dumpvars;
		clk=1'b1;	S=1'b0;	R=1'b1;	D=1'b0;	J=1'b0;	K=1'b1; T=1'b0;
		$display("------------------------------------------");
		$display("             Flip Flops\n");
		$display("SR Flip Flop");
		$display("Time\tClk\tS\tR\tQ\tQn");
		$display("------------------------------------------");
		#1	R=1'b0;
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,S,R,Qsr,Qnsr);
		#1	S=1'b1;	R=1'b0;
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,S,R,Qsr,Qnsr);
		#1	S=1'b0;	R=1'b0;
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,S,R,Qsr,Qnsr);
		#1	S=1'b0;	R=1'b1;
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,S,R,Qsr,Qnsr);
		#1	R=1'b0;
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,S,R,Qsr,Qnsr);
		//-----------------------------------------------------------------------
		$display("------------------------------------------");
		$display("D Flip Flop");
		$display("Time\tClk\tD\tQ\tQn");
		$display("------------------------------------------");
		#1	D=1'b0;
		$display("%g\t%b\t%b\t%b\t%b",$time,clk,D,Qd,Qnd);
		#1	D=1'b1;	#2
		$display("%g\t%b\t%b\t%b\t%b",$time,clk,D,Qd,Qnd);
		#1	D=1'b0; #2
		$display("%g\t%b\t%b\t%b\t%b",$time,clk,D,Qd,Qnd);
		#1
		//-----------------------------------------------------------------------
		$display("------------------------------------------");
		$display("JK Flip Flop");
		$display("Time\tClk\tJ\tK\tQ\tQn");
		$display("------------------------------------------");
		#1	J=1'b0;	K=1'b0;	#2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qjk,Qnjk);
		#1	J=1'b1;	K=1'b0;	#2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qjk,Qnjk);
		#1	J=1'b0;	K=1'b0;	#2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qjk,Qnjk);
		#1	J=1'b0;	K=1'b1; #2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qjk,Qnjk);
		#1	J=1'b0;	K=1'b0; #2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qjk,Qnjk);
		#1	J=1'b1;	K=1'b1; #2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qjk,Qnjk);
		#1	J=1'b1;	K=1'b1; #2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qjk,Qnjk);
		#1
		//------------------------------------------------------------------------
		$display("------------------------------------------");
		$display("T Flip Flop");
		$display("Time\tClk\tT\tQ\tQn");
		$display("------------------------------------------");
		T=1'b0;	#1
		$display("%g\t%b\t%b\t%b\t%b",$time,clk,T,Qt,Qnt);
		T=1'b1;	#1
		$display("%g\t%b\t%b\t%b\t%b",$time,clk,T,Qt,Qnt);
		T=1'b0;	#1
		$display("%g\t%b\t%b\t%b\t%b",$time,clk,T,Qt,Qnt);
		T=1'b1;	#1
		$display("%g\t%b\t%b\t%b\t%b",$time,clk,T,Qt,Qnt);
		T=1'b0;	#1
		$display("%g\t%b\t%b\t%b\t%b",$time,clk,T,Qt,Qnt);
		#1
		//------------------------------------------------------------------------
		$display("------------------------------------------");
		$display("Master Slave JK Flip Flop");
		$display("Time\tClk\tJ\tK\tQ\tQn");
		$display("------------------------------------------");
		#1	J=1'b0;	K=1'b0;	#2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qmsjk,Qnmsjk);
		#1	J=1'b1;	K=1'b0;	#2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qmsjk,Qnmsjk);
		#1	J=1'b0;	K=1'b0;	#2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qmsjk,Qnmsjk);
		#1	J=1'b0;	K=1'b1; #2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qmsjk,Qnmsjk);
		#1	J=1'b0;	K=1'b0; #2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qmsjk,Qnmsjk);
		#1	J=1'b1;	K=1'b1; #2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qmsjk,Qnmsjk);
		#1	J=1'b1;	K=1'b1; #2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qmsjk,Qnmsjk);
		#1	J=1'b1;	K=1'b1; #2
		$display("%g\t%b\t%b\t%b\t%b\t%b",$time,clk,J,K,Qmsjk,Qnmsjk);
		#1
		//------------------------------------------------------------------------
		$finish;
	end
	always begin
		#1 clk=~clk;
	end
	
	SRFlipFlop FF1(S,R,clk,Qsr,Qnsr);
	DFlipFlop FF2(D,clk,Qd,Qnd);
	JKFlipFlop FF3(J,K,clk,Qjk,Qnjk);
	TFlipFlop FF4(T,clk,Qt,Qnt);
	MasterSlaveJK FF5(J,K,clk,Qmsjk,Qnmsjk);
	
endmodule