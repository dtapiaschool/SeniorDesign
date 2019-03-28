module adress_Latch( 		clk,
							addressLine,
							rst,
							WE,
							CE,
							CLE,
							IOX,
							ALE);

	input[31:0]		addressLine;
	input			rst;
	input			clk;
	output 			WE;
	output			CE;
	output			CLE;
	output			ALE;
	output reg[7:0] 	IOX;

	reg[7:0]		read_adress [0:3];


	always @(negedge rst) begin
		read_adress[0] <= addressLine[7:0];
		//read_adress[1] <=addressLine[0:7];
	end
	always @(posedge clk)begin
	if(!rst) begin
		IOX[7:0] <= read_adress[0];
	end 
	end
	
	
endmodule
