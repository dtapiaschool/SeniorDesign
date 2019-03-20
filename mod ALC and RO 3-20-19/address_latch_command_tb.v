//test bench for Latch address command

`timescale 1ns/1ns
module address_latch_command_tb();

	reg clk;
	reg reset;
	wire CEx;
	wire CLEx;
	wire ALEx;
	wire WEx;
	reg forreadx;
	reg[31:0] adressX;
	wire[7:0] IOXx;
	
	integer i = 0;
	initial begin
		clk = 1;
		adressX = 2880088488;
		reset = 0;
		forreadx <= 1;
		#3 reset = 1;
	end
	
	
	always #5 begin
		clk = ~clk;
		if(reset == 1) begin
			reset <= ~reset;
		end
		i = i+1;
		if(i == 40) begin
			reset <= 1;
			i = 0;
			forreadx <= ~forreadx;
		end
	end
	address_latch_command MUT(clk, adressX, reset, WEx,CEx,CLEx,ALEx,IOXx,forreadx);
		
endmodule