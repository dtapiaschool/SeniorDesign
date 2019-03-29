module read_operation( 	clk,
								rst,
								CPINS,
								read_start,
								data_amount,
								data_out,
								complete_out,
								is_ready_out,
								in);

	input					rst;
	input					clk;
	input					read_start;
	input[15:0]			data_amount;
	input[7:0]			in;
	
	output[4:0]			CPINS;
	output reg			complete_out;
	output reg			is_ready_out;
	output[7:0] 		data_out;
		
	
	reg			is_ready;
	reg			WE;
	reg			CE;
	reg			CLE;
	reg			ALE;
	reg			RE;
	reg[7:0] 	IOX;
	reg[7:0]		slave;
	reg[7:0]		data_in;
	reg[1:0]		state;
	
	
	assign CPINS[0] = WE;
	assign CPINS[1] = CE;
	assign CPINS[2] = CLE;
	assign CPINS[3] = ALE;
	assign CPINS[4] = RE;
	
	integer i;
	integer dataI;
	assign data_out = slave;
	
	always @(negedge clk) begin
		if(is_ready && read_start) begin
			IOX  <= in;
		end
	end
	
	always @(posedge clk or posedge rst) begin
		if(rst)begin
			dataI 	= data_amount;
			CE  	= 0;
			CLE 	= 0;
			ALE 	= 0;
			WE 	= 1;
			RE		= 1;
			i 		= 0;
			state = 0;
			complete_out 	<= 0;
			is_ready		= 0;
			is_ready_out 	= 0;
		end
		else begin
			if(!complete_out) begin
				case(state)
				2'b00: begin
					RE 			= 0;
					is_ready 	= 1;
				end 
				2'b01: begin
					slave 			= IOX;
					is_ready 		= 0;
					is_ready_out 	<= 1;
				end
				2'b10: begin
					i 	= i+1;
					RE 	= 1;
					//If all data has been collected data collection is complete
					if(i >= dataI) begin
						complete_out <= 1;
					end
				end
				2'b11: begin
					is_ready_out <= 0;
				end
				endcase
				state = state + 1;
			end//END complete_out if
			else CE <= 1;
		end//END else for reset condition
		
	end//END always

endmodule