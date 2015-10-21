`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/10/20 19:09:15
// Design Name: 
// Module Name: selector21_5
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


module selector21_5(
    input [4:0] choice_0 , choice_1,
	input selec,
	output reg [4:0] out
    );
    
    always@(*)
        begin
            case(selec)
                1'b0: out = choice_0;
                1'b1: out = choice_1;
            endcase
        end
        
endmodule
