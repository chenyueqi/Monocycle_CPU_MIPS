`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NJU_CS_COD_2013 
// Engineer: Yueqi Chen
// 
// Create Date: 2015/10/21 19:58:14
// Design Name: mono_cpu_mips
// Module Name: program_counter
// Project Name: mono_cpu_mips
// Target Devices: xxx
// Tool Versions: xxx
// Description: 
// program counter
// Dependencies: none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module program_counter(
	input [31:0] PC_in,
	output [31:0] PC_out,
	input clk
);
    reg [31:0] pc;
    
    initial
        pc = 32'h0;
    always@(negedge clk)
	    pc = PC_in;
	assign PC_out = pc;
endmodule
