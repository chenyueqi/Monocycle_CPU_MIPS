`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/09/16 11:02:49
// Design Name: 
// Module Name: barrel_shift_mips
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


module barrel_shift_mips
#(parameter DATA_WIDTH = 32 , parameter ADDR_WIDTH = 5 , parameter lo_l = 0 , parameter lo_r = 1 , parameter al_r = 2 , parameter ci_r = 3)
(
	input [(DATA_WIDTH -1):0] data_in,
	input [(ADDR_WIDTH -1):0] shift_count,
	input [1:0] op,
	output reg [(DATA_WIDTH -1):0] data_out
);
	integer i;
	reg [(DATA_WIDTH -1):0] inter1;
	reg [(DATA_WIDTH -1):0] inter2;
    	always@(*)
    	begin
    	   inter1 = 32'h0;
    	   inter2 = 32'h0;
    		data_out = data_in;
		case(op)
	 	lo_l: data_out = data_in << shift_count;
		lo_r: data_out = data_in >> shift_count;
		al_r: data_out = $signed(data_in) >>> shift_count;
		ci_r: begin 
			inter1 <= data_in >> shift_count; 
			inter2 <= data_in << (DATA_WIDTH -2 - shift_count);
			data_out = inter1 + inter2;
			end
		endcase
	end
endmodule
