`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/10/23 14:51:23
// Design Name: 
// Module Name: instr_memory
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


module instr_memory(
	input [31:0] addr,
	output [31:0] instr
);
	parameter N = 32;
	parameter addr_space = 255;

	reg[N-1 :0] rom [0:addr_space];

	initial
		$readmemh("C:/Users/Administrator/Desktop/ram.txt" , rom);
	
	assign instr = rom[addr>>2];
endmodule
