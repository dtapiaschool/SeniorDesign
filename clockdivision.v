module clockdivision (CLK, BUTTON, CE, CLE, ALE, WE, RE, WP, IO);


input CLK;
input BUTTON;


output CE = 0;	//Chip Enable
output CLE = 0; //Command Latch Enable
output ALE = 0; //Address Latch Enable
output WE;
output RE = 1;	//Read Enable
output WP;
output IO [7:0] = 8'b11111111; //DatA In/Out
reg CE, CLE, ALE, WE, RE, WP;
reg  [7:0]  IO ;
reg  [31:0] r_reg1=0; //used as counter variable -will continue to increase and not resest 
wire [31:0] addr;   //used as temp counter variable


wire [31:0] r_nxt;  //used as counter variable
reg  [31:0] r_reg=0;
reg clk_track;



always @(posedge CLK or posedge BUTTON)
begin
	if(BUTTON)
		begin
		r_reg <=0;
		r_reg1 <=0;
		clk_track <=0;
		WE <= 0;
		end
	else if(r_nxt == 4'b0010) // this portion will flip the WE sinal( r_nxt will dictate the desired frequeny)
		begin
		r_reg <= 0;
		clk_track <= ~clk_track;
		WE <= ~WE;
		end
	else
		r_reg <= r_nxt;
		r_reg1 <=  addr;
		
end
	
assign	r_nxt = r_reg +1;
assign   addr  = r_reg1 +1;

always @(posedge CLK)
case(r_reg1)
15: IO [7:0] <= 8'h10; //case # to be changed to XXXX: last page number
endcase


endmodule
