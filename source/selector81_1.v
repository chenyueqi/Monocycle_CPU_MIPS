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
	input in0,in1 ,in2 ,in3 , in4 , in5 , in6 , in7,
	input [2:0] condition,
	output reg out
);

    always@(*)
    begin
        case(condition)
            3'b000:out = in0;
            3'b001:out = in1;
            3'b010:out = in2;
            3'b011:out = in3;
            3'b100:out = in4;
            3'b101:out = in5;
            3'b110:out = in6;
            3'b111:out = in7;
	    endcase
    end
endmodule
