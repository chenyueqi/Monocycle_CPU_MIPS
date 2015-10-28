`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/09/19 23:44:20
// Design Name: 
// Module Name: alu
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


module alu
#(parameter DATA_WIDTH = 32)
(
	input  [(DATA_WIDTH -1):0] a_in, b_in,
	input  [3:0] alu_op,
	output reg   less ,overflow_out ,
	output zero ,
	output reg [(DATA_WIDTH -1):0] alu_out
);
	reg [(DATA_WIDTH -1):0] a_clz;
	wire carry ,overflow , negative;
	wire [(DATA_WIDTH -1):0] O_out;
	wire [2:0] alu_ctr;
	
	reg [15:0] val16;
	reg [7:0] val8;
	reg [3:0] val4;
	reg [1:0] val2;
	integer i;
	integer j;

	alu_controller controller1(
	.alu_op(alu_op),
	.alu_ctr(alu_ctr)
	);

	adder adder1(
	.a_in(a_in),
	.b_in(b_in),
	.cin(alu_op[0]),
	.O_out(O_out),
	.zero(zero),
	.carry(carry),
	.overflow(overflow),
	.negative(negative)	
	);

	always@(*)
	begin
	   less = 1'b0;
	   overflow_out = 1'b0;
	   alu_out = 32'h0;
		if(alu_ctr == 3'b111)
		begin
			alu_out = O_out;
			if((alu_op == 0) || (alu_op == 1)) // addu subu
				overflow_out = 0;
			else if((alu_op == 14) || (alu_op == 15))//add sub
				overflow_out = overflow;
			less = overflow^negative;
		end
		else if(alu_ctr == 3'b000)
		begin
			if(alu_op[0] == 1) //clz
				a_clz = a_in ^ 32'hffffffff;
			else
				a_clz = a_in;

			/*i = 32;
			j = a_clz >> 16; if(j != 0) begin i = i - 16; a_clz = j; end
			j = a_clz >> 8 ; if(j != 0) begin i = i -8 ;a_clz = j; end
			j = a_clz >> 4 ; if(j != 0) begin i = i -4 ;a_clz = j; end
			j = a_clz >> 2 ; if(j != 0) begin i = i -2 ;a_clz = j; end
			j = a_clz >> 1 ; if(j != 0) begin i = i -1; a_clz = j; end
			alu_out = i - a_clz;*/
		       	alu_out = 32'h0;
			if(a_clz == 0)
			alu_out = 32;
			else begin
			alu_out[4] = a_clz[31:16]== 16'd0;
			val16 = alu_out[4] ? a_clz[15:0]:a_clz[31:16];
			alu_out[3] = val16[15:8] == 8'd0;
			val8 = alu_out[3]? val16[7:0]:val16[15:8];
		       	alu_out[2] = val8[7:4] == 4'd0;
			val4 = alu_out[2]? val8[3:0]:val8[7:4];
			alu_out[1] = val4[3:2] == 2'd0;
			val2 = alu_out[1]? val4[1:0]:val4[3:2];
			alu_out[0] = val2[1] == 1'd0;
			end	
		end

		else if(alu_ctr == 3'b100)//and
			alu_out = a_in & b_in;
		else if(alu_ctr == 3'b010)//or
			alu_out = a_in | b_in;
		else if(alu_ctr == 3'b011)//nor
			alu_out = ~(a_in | b_in);
		else if(alu_ctr == 3'b001)//xor
			alu_out = a_in ^ b_in;

		else if(alu_ctr == 3'b101)
		begin
			if(alu_op[1] == 0)//slt/slti
				less = overflow^negative;
			else//sltu/sltiu
				less = ~carry;
			if(less == 0)
				alu_out = 0;
			else
				alu_out = 32'h1;
		end
		else if(alu_ctr == 3'b110)
		begin
			if(alu_op[0] == 0)//seb
			begin
				if(b_in[7] == 1)
				begin
					alu_out[(DATA_WIDTH -1):8] = 24'hffffff;
					alu_out[7:0] = b_in[7:0];
				end
				else
				begin
					alu_out[(DATA_WIDTH -1):8] = 24'h000000;
					alu_out[7:0] = b_in[7:0];
				end

			end
			else//seh
			begin
				if(b_in[15] == 1)
				begin
					alu_out[(DATA_WIDTH -1):16] = 16'hffff;
					alu_out[15:0] = b_in[15:0];
				end
				else
				begin
					alu_out[(DATA_WIDTH -1):16] = 16'h0000;
					alu_out[15:0] = b_in[15:0];
				end
			end
		end
	end	

endmodule
