`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/10/20 19:15:48
// Design Name: 
// Module Name: selector31_32
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


module selector31_32(
    input [31:0] choice_0 , choice_1 , choice_2 ,
	input [1:0] selec,
	output reg [31:0] out

    );
    always@(*)
	begin
		case(selec)
			2'b00: out = choice_0;
			2'b01: out = choice_1;
			2'b10: out = choice_2;
		endcase
	end
	
endmodule