//test bench for read operation_TB

`timescale 1ns/1ns
module read_operation_TB();
	reg 		reset;
	reg 		clk;
	reg			RBx;
	reg[7:0] 	datax;
	reg[15:0]  	DAx;
	reg			RSx;
	
	wire[7:0]	data_outx;
	wire 		CEx;
	wire 		CLEx;
	wire 		ALEx;
	wire 		WEx;
	wire		REx;
	wire		completex;
	wire		is_ready_outx;
	wire[7:0]	RLx;
	
	
	
	integer i = 0;
	
	initial begin
		clk 	= 1;
		datax 	= 8'b01010101;
		reset 	= 0;
		RBx 	= 1;
		DAx 	= 15;
		RSx		= 1;
		#3 reset = 1;
	end
	
	//when the memory sees a negedge on RE it outputs data
	//That should be read before RE is raised to hi again
	always @(negedge REx) begin
		datax = datax + 2;
	end
	
	
	always #5 begin
		clk = ~clk;
		if(reset == 1) begin
			reset <= ~reset;
		end
		
	end
	read_operation MUT(clk, reset, WEx, CEx, CLEx,ALEx,REx,RBx,datax,RSx,DAx,data_outx,completex,is_ready_outx,RLx);
endmodule
