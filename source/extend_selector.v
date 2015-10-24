`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/10/20 19:18:40
// Design Name: 
// Module Name: extend_selector
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


module extend_selector(
    	input [15:0] Instr,
	    input Extend_sel,
    	output reg [31:0] Ex_offset
);
	   always@(*)
	   begin
            if(Extend_sel == 1'b0)
            begin
                 Ex_offset[31:16] = 16'b0;
                 Ex_offset[15:0] = Instr[15:0];
            end
            else
            begin
                if(Instr[15] == 0)
                     Ex_offset[31:16] = 16'b0;
                else
                     Ex_offset[31:16] = 16'hffff;
                Ex_offset[15:0] = Instr[15:0];	
            end
        end
endmodule
