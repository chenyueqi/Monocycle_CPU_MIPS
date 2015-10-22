`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/09/05 10:32:27
// Design Name: 
// Module Name: test_register_mips32
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


module test_register_mips32();
 parameter DATA_WIDTH = 32 ;
 parameter ADDR_WIDTH = 5;
    reg [(ADDR_WIDTH -1):0] Rs_addr , Rt_addr ,Rd_addr;
    reg [(DATA_WIDTH -1):0] Rd_in;
    reg [3:0] Rd_Byte_w_en;
    reg clk;
    wire [(DATA_WIDTH -1):0] Rs_out , Rt_out;
  register_mips32 t1(
  .Rs_addr(Rs_addr),
  .Rt_addr(Rt_addr),
  .Rd_addr(Rd_addr),
  .Rd_in(Rd_in),
  .clk(clk),
  .Rd_Byte_w_en(Rd_Byte_w_en),
  .Rs_out(Rs_out),
  .Rt_out(Rt_out)
  );
  
  always 
  #1 clk = ~clk;
  
  initial begin
    clk = 1'b1;
    Rs_addr = 1;
    Rt_addr = 2;
    Rd_in = 32'b1001000;
    #3 Rd_addr = 1;
    #3 Rd_Byte_w_en = 4'b0000;
    #3 Rd_addr = 2;
    #3 Rd_in = 32'b00001111111;
    Rd_Byte_w_en = 4'b1110;
    #3
    $stop;
  end
endmodule
