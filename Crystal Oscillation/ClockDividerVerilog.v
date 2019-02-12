module clk_div (clk,reset, clk_out);
 
input clk;
input reset;
output clk_out;

reg [2:0] r_reg;
wire [2:0] r_nxt;
reg clk_track;
 
always @(posedge clk or posedge reset)
 
begin
  if (reset)
     begin
        r_reg <= 1'b0;
		  clk_track <= 1'b0;
     end
 
  else if (r_nxt == 3'b100) // edeges to flip output frequency. make sure to use all reg bits!!
 	   begin
	     r_reg <= 0;
	     clk_track <= ~clk_track;
	   end
 
  else 
      r_reg <= r_nxt;
end
 
 assign r_nxt = r_reg+1;   	      
 assign clk_out = clk_track;
endmodule