module test_controller(		CLK,
									reset,
									feedbackALC,
									feedbackRO,
									feedbackWR,
									CLKOUT,
									
									rstALC,
									toAddressLine,
									forRead,
									forWrite,
									writeEnable,
									
									rstWRO,
									
									
									rstRO,
									readEnable,
									data_amount,
									
									
									
									CPINSselect,
									outselect);
	input CLK;
	input reset;
	input feedbackALC;
	input feedbackRO;
	input feedbackWR;
	
	
	output reg		rstALC;
	output reg 		rstRO;
	output reg		rstWRO;
	output reg		outselect;
	output reg[15:0]	data_amount;
	
	output reg			CLKOUT;
	output reg			writeEnable;
	output reg			readEnable;
	output reg			forRead;
	output reg			forWrite;
	output reg[1:0]	CPINSselect;
	
	//	I/O(0) 	I/O(1) 	I/O(2)	I/O(3) 	I/O(4) 	I/O 5 	I/O(6) 	I/O(7) 	Address
	//	A 0 		A 1 		A 2 		A 3		A 4 		A 5 		A  6		A 7 		Column Address
	// 31			30			29			28			27			26			25			24
	output[31:0]		toAddressLine;
	// COL 1 [31:24]
	reg[7:0] 			col1;
	// COL 2 [23:16]
	reg[3:0]				col2;
	reg[3:0]				col2L;
	// ROW 1 [15:8]
	reg[7:0]				row1;
	// ROW 2 [7:0]
	reg[7:0]				row2;
	reg[31:0]			address;
	assign toAddressLine		= address;
	
	
	
	reg					start;
	reg[7:0]				state;
	
	initial begin
		col2L = 4'b0;
		start = 0;
		state = 0;
		writeEnable = 0;
		readEnable 	= 0;
	end

	
	always @(posedge reset)begin
		start = 1;
	end
	always @(posedge CLK) begin
		if(start) begin
		case(state)
			8'b0: begin
				outselect 	= 0;
				forRead 		= 1;
				forWrite 	= 0;
				//assign the addres in which to next send
				address[31:24] 	= col1;
				address[23:20] 	= col2;
				address[19:16]		= col2L;
				address[15:8] 		= row1;
				address[7:0] 		= row2;
				writeEnable = 1;
				state = state+1;
				CPINSselect = 2'b00;
			end
			8'b1: begin
				rstALC = 1;
				state = state +1;
			end
			8'd2: begin
				rstALC  = 0;
				state  = state + 1;
			end
			8'd3: begin
				if(feedbackALC) state = 8'b0;
			end
		endcase	//END Case(state)
		end		//END start if
	end			//END always block
endmodule