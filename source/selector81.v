`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NJU_CS_COD_2013
// Engineer: Yueqi Chen
//
// Create Date: 2015/10/20 18:35:31
// Design Name: mono_cpu_mips
// Module Name: selector81
// Project Name: mono_cpu_mips
// Target Devices: xxx
// Tool Versions: xxx
// Description: 
// serve as an 8-1 selector in mono cpu based on mips instruction
// Dependencies: nono
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module selector81_1(
	input[7:0] in,
	input [2:0] condition,
	output reg out
);

    always@(*)
    begin
	    out = in[condition];
    end
endmodule
