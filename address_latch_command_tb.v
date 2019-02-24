//test bench for Latch address command

`timescale 1ns/1ns
module address_latch_command_tb();

	reg clk;
	reg reset;
	wire CEx;
	wire CLEx;
	wire ALEx;
	wire WEx;
	reg[31:0] adressX;
	wire[7:0] IOXx;
	
	initial begin
		clk = 1;
		adressX = 2880088488;
		reset = 1;
	end
	always #5 begin
		clk = ~clk;
		if(reset == 1) begin
			reset <= ~reset;
		end
	end
	address_latch_command MUT(clk, adressX, reset, WEx,CEx,CLEx,IOXx,ALEx);
		
endmodule