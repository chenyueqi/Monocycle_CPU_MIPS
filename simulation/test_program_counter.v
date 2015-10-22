`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/10/21 20:37:09
// Design Name: 
// Module Name: test_program_counter
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


module test_program_counter();
	reg clk;
	reg [31:0] pc_in;
	wire [31:0] pc_out;

	program_counter pc(
		.PC_in(pc_in),
		.PC_out(pc_out),
		.clk(clk)
	);

	initial begin
		clk = 1'b1;
		pc_in = 32'h1;
		#1
		clk = 1'b0;
		#1
		clk = 1'b1;
		pc_in = 32'h2;
		#1
		clk = 1'b0;
		#1
		$stop;

	end
endmodule
