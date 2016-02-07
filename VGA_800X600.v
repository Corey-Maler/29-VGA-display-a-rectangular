module VGA_800X600(
			clk,rst_n,
			hsync,vsync,
			vga_r,vga_g,vga_b
		);

input clk;    // 50 MHz
input rst_n;	
output hsync;	
output vsync;	
output vga_r;  
output vga_g; 
output vga_b; 

//--------------------------------------------------
reg[10:0] x_cnt;   
reg[9:0] y_cnt;	

always @ (posedge clk or negedge rst_n)
	if(!rst_n) x_cnt <= 11'd0;
	else if(x_cnt == 11'd1039) x_cnt <= 11'd0;
	else x_cnt <= x_cnt+1'b1;

always @ (posedge clk or negedge rst_n)
	if(!rst_n) y_cnt <= 10'd0;
	else if(y_cnt == 10'd665) y_cnt <= 10'd0;
	else if(x_cnt == 11'd1039) y_cnt <= y_cnt+1'b1;

//--------------------------------------------------
wire valid;	

assign valid = (x_cnt >= 11'd187) && (x_cnt < 11'd987) 
					&& (y_cnt >= 10'd31) && (y_cnt < 10'd631); 

wire[9:0] xpos,ypos;	
assign xpos = x_cnt-11'd187;
assign ypos = y_cnt-10'd31;

//--------------------------------------------------
reg hsync_r,vsync_r;	

always @ (posedge clk or negedge rst_n)
	if(!rst_n) hsync_r <= 1'b1;
	else if(x_cnt == 11'd0) hsync_r <= 1'b0;
	else if(x_cnt == 11'd120) hsync_r <= 1'b1;
 
always @ (posedge clk or negedge rst_n)
	if(!rst_n) vsync_r <= 1'b1;
	else if(y_cnt == 10'd0) vsync_r <= 1'b0;
	else if(y_cnt == 10'd6) vsync_r <= 1'b1;

assign hsync = hsync_r;
assign vsync = vsync_r;

X_SERVER xrand(clk, valid, xpos, ypos, vga_r, vga_g, vga_b);

endmodule
