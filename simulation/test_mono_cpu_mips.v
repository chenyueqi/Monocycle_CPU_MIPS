`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/10/23 19:11:01
// Design Name: 
// Module Name: test_mono_cpu_mips
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


module test_mono_cpu_mips();
	reg clk;
    wire [31:0] pc;
	mono_cpu cpu(
		.clk(clk),
		.pc(pc)
	);
	initial
		clk = 1'b1;
	always
	begin
		#1 clk = ~clk;
		if(pc == 32'h98 || pc == 32'h90)
		  $stop;
	end
endmodule
