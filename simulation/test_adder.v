`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/09/20 12:48:10
// Design Name: 
// Module Name: test_adder
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


module test_adder();
	reg [31:0] a_in , b_in;
	reg cin ;
	wire [31:0] O_out;
	wire zero , carry , overflow , negative;

	adder a1(
	.a_in(a_in),
	.b_in(b_in),
	.cin(cin),
	.O_out(O_out),
	.zero(zero),
	.carry(carry),
	.overflow(overflow),
	.negative(negative)
	);

	initial begin 
		a_in = 32'h80000000;
		b_in = 32'h80000001;
		cin = 1;
		#1
		cin = 0;
		#1
		a_in = 32'h00000000;
		b_in = 32'h80000001;
		cin = 0;
		#1
		a_in = 32'h00000000;
		b_in = 32'h00000000;
		#1

	$stop;
    	end
endmodule
