`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/09/19 23:06:54
// Design Name: 
// Module Name: alu_controller
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


module alu_controller
(
    input [3:0] alu_op,
    output reg [2:0] alu_ctr 
);
    always@(*)
    begin
	    alu_ctr[2] = ((~alu_op[3]) & (~alu_op[1])) | ((~alu_op[3]) & alu_op[2] & alu_op[0]) | (alu_op[3] & alu_op[1]);
	    alu_ctr[1] = ((~alu_op[3]) & (~alu_op[2]) & (~alu_op[1])) | (alu_op[3] & (~alu_op[2]) & ( ~alu_op[0])) | (alu_op[2] & alu_op[1] & (~alu_op[0])) | (alu_op[3] & alu_op[1]);
	    alu_ctr[0] = ((~alu_op[2]) & (~alu_op[1])) | ((~alu_op[3]) & alu_op[2] & alu_op[0]) | (alu_op[3] & alu_op[2] & alu_op[1]);
    end
endmodule
