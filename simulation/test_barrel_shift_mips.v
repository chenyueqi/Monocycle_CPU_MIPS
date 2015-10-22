`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/09/16 16:37:53
// Design Name: 
// Module Name: test_barrel_shift_mips
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


module test_barrel_shift_mips();
parameter DATA_WIDTH = 32;
parameter ADDR_WIDTH = 5;
parameter lo_l = 0;
parameter lo_r = 1;
parameter al_r = 2;
parameter ci_r = 3;
	reg [(DATA_WIDTH -1):0] data_in;
	reg [(ADDR_WIDTH -1):0] shift_count;
	reg [1:0] op;
	wire [(DATA_WIDTH -1):0] data_out;

	barrel_shift_mips t1(
	.data_in(data_in),
	.shift_count(shift_count),
	.op(op),
	.data_out(data_out)
	);

	initial begin
		data_in = 32'h12345678;
		shift_count = 4;
		op = lo_l;
		#1
		shift_count = 3;
		op = lo_r;
		#1
		data_in = 32'hf2345678;
		shift_count = 2;
		op = al_r;
		#1
		shift_count = 1;
		op = ci_r;
		#1
		$stop;
	end
endmodule
