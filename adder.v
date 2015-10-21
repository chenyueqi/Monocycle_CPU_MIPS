`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/09/20 12:22:05
// Design Name: 
// Module Name: adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module adder
#(parameter DATA_WIDTH = 32)
(
	input [(DATA_WIDTH -1) :0] a_in , b_in,
	input cin,
	output reg [(DATA_WIDTH -1) :0] O_out,
	output reg zero,carry,overflow,negative
);
	reg [(DATA_WIDTH -1):0] b_in_not;
	always@(*)
	begin
		if(cin == 0)
			b_in_not = b_in ^ 32'h00000000;
		else 
			b_in_not = b_in ^ 32'hffffffff;

		{carry ,O_out} = a_in + b_in_not + cin;
		if(O_out == 0)
			zero = 1;
		else 
			zero = 0;
		overflow = ((~a_in[31])&(~b_in_not[31])&O_out[31]) | (a_in[31]&b_in_not[31]&(~O_out[31]));
		negative = O_out[31];
	end
endmodule
