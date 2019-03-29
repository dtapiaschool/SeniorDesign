module write_operation(		clk,
									rst,
									CPINS, 
									IO,
									complete,
									writeEnable);


	input clk, rst;
	input writeEnable;
	
	output[7:0] IO;
	output[4:0]			CPINS;
	output reg complete;
	
	reg CE, CLE, ALE, WE, RE;
	assign CPINS[0] = WE;
	assign CPINS[1] = CE;
	assign CPINS[2] = CLE;
	assign CPINS[3] = ALE;
	assign CPINS[4] = RE;
	
	reg	[7:0] IO;
	wire 	[31:0] r_nxt;  //used as counter variable
	reg  	[31:0] r_reg;
	reg  	[31:0] r_reg1; //used as counter variable -will continue to increase and not resest 
	wire 	[31:0] addr;   //used as temp counter variable
	reg 	clk_track;

initial begin //Initial conditions for data input
	r_reg=0;
	r_reg1=0;
	CE = 0;	//Chip Enable
	CLE = 0; //Command Latch Enable
	ALE = 0; //Address Latch Enable
	RE = 1;	//Read Enable
	IO [7:0] =8'b11111111; //DatA In/Out
end


always @(posedge clk or posedge rst)
begin
	if(rst)
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


always@(*)
	case(r_reg1)
	5: begin
		IO [7:0] <= 8'h10; //case # to be changed to XXXX: last page number
		complete <=1;
	end
	endcase


endmodule