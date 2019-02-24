module address_latch_command( 	clk,
								addressLine,
								rst,
								WE,
								CE,
								CLE,
								IOX,
								ALE);

	input[31:0]			addressLine;
	input				rst;
	input				clk;
	output reg			WE;
	output reg			CE;
	output reg			CLE;
	output reg			ALE;
	output reg[7:0] 	IOX;
	integer i;
	reg[7:0]		read_address [0:3];
	reg[3:0]		current_state;
	initial begin
		WE<= 1;
		CE <= 1;
		CLE <= 1;
		ALE <= 0;
	end

	always @(negedge rst) begin
		read_address[0] <= addressLine[7:0];
		read_address[1] <= addressLine[15:8];
		read_address[2] <= addressLine[23:16];
		read_address[3] <= addressLine[31:24];
		write_address();
	end
	
task write_address; begin
	
	@ (posedge clk);
	CE = 0;
	CLE = 0;
	ALE = 1;
	for(i = 0; i <=3; i = i+1) begin
	@ (posedge clk);
	WE = 0;
	IOX[7:0] <= read_address[i];
	@ (posedge clk)
	WE = 1;
	@ (negedge clk)
	ALE = 0;
	@ (posedge clk)
	ALE = 1;
	end
	
	end
endtask
	
endmodule



	
	
