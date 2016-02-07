module X_SERVER(clk, valid,  x, y, r, g, b);

input clk;
input valid;
input wire[9:0] x, y;

output reg r, g, b;

wire [7:0] sline;

reg aaa;
wire bbb;
reg ddd;

reg [31:0] timer;

wire [15:0] char_code;

reg [15:0] cc_code;

reg [5:0] hline;
reg [7:0] vline;
reg [5:0] hline_old;

reg [7:0] matrix [64];

reg [7:0] next_char;



initial $readmemh("matrix.hex", matrix);

assign bbb = timer[14];

//			  clk, 	data_a, 	data_b,  	addr_a,					addr_b,				we_a, 	we_b, 	q_a,       	q_b (not used)
V_RAM vram(clk, 	16'b0,  	cc_code, 	{y[8:4], x[8:3]}, 	{vline[4:0], hline}, 	1'b0, 	ddd,  	char_code);

CHARSET charset(clk, {char_code[7:0], y[3:0]}, sline);

			
always @(posedge clk)
begin	
	aaa = sline[3'b111 - x[2:0] + 2];
	r = 1'b0;
	g = y[9] || x[9] ? 1'b0 : (char_code[9] && timer[24] ? 1'b0 : (char_code[8] ? ~aaa : aaa));
	b = 1'b0;	
end

always @(posedge clk)
begin
	timer <= timer + 1;
	if (hline != hline_old)
	begin
		hline_old = hline;
		ddd = 1'b1;
	end
	else
	begin
		ddd = 1'b0;
	end
end	
	
genvar c;
generate 
	for (c = 0; c < 64; c = c + 1) begin: test
		always @(posedge bbb)
			if (hline === 0)
				matrix[c] <= matrix[c] + 1;
	end
endgenerate	
	
always @(posedge bbb)
begin
	hline <= hline + 1;
	vline <= matrix[hline];
	if (matrix[hline] > 8'b000011111 )
	begin
		cc_code <= 16'h00_00;
	end
	else
	begin
		cc_code <= {8'h00, next_char};
		next_char <= next_char + 3;
	end
end	
	
	
endmodule