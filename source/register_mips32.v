`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/09/04 21:12:57
// Design Name: 
// Module Name: register_mips32
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


module register_mips32
#(parameter DATA_WIDTH = 32 , parameter ADDR_WIDTH = 5)
(
    input [(ADDR_WIDTH -1):0] Rs_addr , Rt_addr , Rd_addr,
    input [(DATA_WIDTH -1):0] Rd_in,
    input [3:0] Rd_Byte_w_en,
    input clk,
    output [(DATA_WIDTH -1):0] Rs_out , Rt_out
);

    reg [(DATA_WIDTH -1):0] register[(2**ADDR_WIDTH -1):0];
    integer i ;
    
    initial 
    begin 
        for(i = 0 ; i < 32 ; i = i + 1)
            register[i] = 0;
    end
    
    always @ (negedge clk)
    begin
        if(Rd_addr != 0)
            begin
                if(Rd_Byte_w_en[3] == 0) register[Rd_addr][31:24] <= Rd_in[31:24]; 
                if(Rd_Byte_w_en[2] == 0) register[Rd_addr][23:16] <= Rd_in[23:16]; 
                if(Rd_Byte_w_en[1] == 0) register[Rd_addr][15:8] <= Rd_in[15:8];
                if(Rd_Byte_w_en[0] == 0) register[Rd_addr][7:0] <= Rd_in[7:0];  
            end       
    end
    
    assign Rs_out = register[Rs_addr];
    assign Rt_out = register[Rt_addr];
endmodule
