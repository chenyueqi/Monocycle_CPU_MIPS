`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/09/19 23:29:17
// Design Name: 
// Module Name: test_alu_controller
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


module test_alu_controller();
	reg [3:0] alu_op;
	wire [2:0] alu_ctr;

	alu_controller t1(
	.alu_op(alu_op),
	.alu_ctr(alu_ctr)
	);

	initial begin
		alu_op = 4'b0000;
		#1
		alu_op = 4'b0001;
		#1
		alu_op = 4'b0010;
		#1
		alu_op = 4'b0011;
		#1
		alu_op = 4'b0100;
		#1
		alu_op = 4'b0101;
		#1
		alu_op = 4'b0110;
		#1
		alu_op = 4'b0111;
		#1
		alu_op = 4'b1000;
		#1
		alu_op = 4'b1001;
		#1
		alu_op = 4'b1010;
		#1
		alu_op = 4'b1011;
		#1
		alu_op = 4'b1110;
		#1
		alu_op = 4'b1111;
		#1
		$stop;
	end
endmodule
