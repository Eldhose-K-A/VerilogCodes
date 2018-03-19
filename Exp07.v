module Main();
	reg [3:0]B;
	wire [3:0]G;
	integer i;
	
	initial begin
	$dumpfile("Exp07.vcd");
	$dumpvars;
	B=4'b0000;
	$display("------------------------------------------");
	$display("      Binary to Gray Code Converter\n");
	$display("Binary code\tGray code");
	$display("------------------------------------------");
	for(i=0;i<16;i=i+1)
	begin
		#1
		$display("%b\t\t%b",B,G);
		B=B+4'b0001;
	end
	#1
	$finish;
	end
	
	assign G[3]=B[3];
	xor x1(G[2],B[3],B[2]);
	xor x1(G[1],B[2],B[1]);
	xor x1(G[0],B[1],B[0]);
	
endmodule