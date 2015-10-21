`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NJU_CS_COD_2013
// Engineer: Yueqi Chen
// 
// Create Date: 2015/10/20 15:38:36
// Design Name: mono_cpu_mips
// Module Name: selector
// Project Name: mono_cpu_mips
// Target Devices: xxx
// Tool Versions: xxx
// Description: 
// serve as a 2-1 selector in mono cpu based on mips instruction
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module selector21_32(
	input [31:0] choice_0 , choice_1,
	input selec,
	output reg [31:0] out
);

	always@(*)
	begin
		case(selec)
			1'b0: out = choice_0;
			1'b1: out = choice_1;
		endcase
	end
endmodule
