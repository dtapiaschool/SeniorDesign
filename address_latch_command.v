module address_latch_command( 	clk,
								addressLine,
								rst,
								CPINS,
								WE,
								CE,
								CLE,
								ALE,
								RE,
								writeline,
								writeEnable,
								forread);
	
	input[31:0]			addressLine;
	// COL 1 [31:24]
	// COL 2 [23:16]
	// ROW 1 [15:8]
	// ROW 2 [7:0]
	input				rst;
	input				clk;
	input				forread;
	input				writeEnable;
	
	
	output[4:0]			CPINS;
	output reg			WE;
	output reg			CE;
	output reg			CLE;
	output reg			ALE;
	output reg			RE;
	inout[7:0] 			writeline;
	
	reg[7:0] 			IOX;
	reg[7:0]				read_address [0:3];
	reg[3:0]				state;
	reg					complete;
	
	assign CPINS[0] = WE;
	assign CPINS[1] = CE;
	assign CPINS[2] = CLE;
	assign CPINS[3] = ALE;
	assign CPINS[4] = RE;
	integer addrCount;
	//If forread is enable write line will be values in IOX
	//If forread is low, output will be high Z
	assign writeline = writeEnable ? IOX: 8'bz;
	initial begin
		RE = 1;
	end
	
	always@(posedge rst) begin
		read_address[3] = addressLine[7:0];
		read_address[2] = addressLine[15:8];
		read_address[1] = addressLine[23:16];
		read_address[0] = addressLine[31:24];
	end
	
	always @(posedge clk or posedge rst ) begin
		if(rst) begin
			state 		= 4'b0000;
			addrCount 	= 0;
			complete 	= 0;
			IOX 		= 0;
			WE 			= 1;
			CE			= 1;
			CLE 		= 1;
			ALE 		= 0;
		end
		else begin
		if(!complete)begin
		case(state)
		4'd0: begin
			
				CE 	= 0;
				CLE 	= 0;
		//If NOT for read skip the commands lines
				if(!forread) begin
					ALE = 1;
					state = 4'd3;	//move to address write skip command
				end
		end 
		//for reading command start
		4'd1: begin
				WE 	= 0;
				CLE 	= 1;
				IOX 	= 8'd0;
		end
		4'd2: begin
				
				WE		= 1;
		end	
		4'd3: begin
				CLE 	= 0;
		end
		
		//Next block of code is for writing the address 
		//Addressline LSB is which is First column address
		//read_address[0] = Col 1, ..[1] Col 2, .. Row 1, .. Row 2
		4'd4: begin
				ALE		= 1;
				WE 		= 0;	
				IOX[7:0] = read_address[addrCount];
		end
		4'd5: begin
				WE 		= 1;
				
				if(addrCount < 3) state = 4'd3;
				
				addrCount = addrCount + 1;
		end	
		
		4'd6: begin
				ALE 	= 0;
				
				if(forread) 
					CLE 	= 1;
				else 
					state 	= 4'd8;
		end
		//start extra read command write
		4'd7: begin
				WE 			= 0;
				IOX[7:0] 	= 8'h30; //write and 8 bit command
		end
		4'd8: begin
				WE  	= 1;
		end
		4'd9: begin
			IOX[7:0] = 8'bz; // set the writeline to high Z
			complete = 1;
		end
		
		
		endcase//endcase
		state = state + 1;
		end//END IF complete state
	end // ENDS RESET CASE IF
end//END always

endmodule
	
	
