`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2015/09/20 13:35:10
// Design Name: 
// Module Name: test_alu
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


module test_alu();
	reg [31:0] a_in , b_in ;
	reg [3:0] alu_op;
	wire less , overflow , zero;
	wire [31:0] alu_out;
	//wire [31:0] a_clz;

	alu a1(
	.a_in(a_in),
	.b_in(b_in),
	.alu_out(alu_out),
	.alu_op(alu_op),
	//.a_clz(a_clz),
	.less(less),
	.zero(zero),
	.overflow_out(overflow)
	);

	initial begin
		a_in = 32'h81234561;
		b_in = 32'h8edcba91;	
		alu_op = 4'b0000;//addu addiu
		#1
		if(!((alu_out == 32'h0ffffff2) && (less == 1) && (overflow == 0) && (zero == 0)))
			$stop;
		alu_op = 4'b0001;//subu
		a_in = 32'h01234561;
		#1
		if(!((alu_out == 32'h72468ad0) && (less == 0) && (overflow == 0) && (zero == 0)))
			$stop;
		alu_op = 4'b0010;//clz
		a_in = 32'h00000000;
		#1
		if(!(alu_out == 32))
			$stop;
		alu_op = 4'b0011;//clo
		a_in = 32'h81234561;
		#1
		if(!(alu_out == 1))
			$stop;
		alu_op = 4'b0100;//and
	    a_in = 32'h81234561;
        b_in = 32'h8edcba91; 
		#1
		if(!(alu_out == 32'h80000001))
			$stop;
		alu_op = 4'b0101;//slt slti
		a_in = 0;
		b_in = 32'h80000001;
		#1
		if(!((alu_out == 0) && (less == 0) && (overflow == 0) && (zero == 0)))
			$stop;
		alu_op = 4'b0110;//or
		#1
		if(!(alu_out == 32'h80000001))
			$stop;
		alu_op = 4'b0111;//sltu sltiu
		a_in = 32'h80000000;
		#1
		if(!((alu_out == 32'hffffffff) && (less == 1) && (overflow == 0) && (zero == 0)))
			$stop;
		alu_op = 4'b1000;//nor
		a_in = 32'hf0f0f0f0;
		b_in = 0;
		#1
		if(!(alu_out == 32'h0f0f0f0f))
			$stop;
		alu_op = 4'b1001;//xor
		b_in = 32'hffffffff;
		#1
		if(!(alu_out == 32'h0f0f0f0f))
			$stop;
		alu_op = 4'b1010;//seb
		b_in = 32'h0000ff0f;
		#1
		if(!(alu_out == 32'h0000000f))
			$stop;
		alu_op = 4'b1011;//seh
		#1
		if(!(alu_out == 32'hffffff0f))
			$stop;
		alu_op = 4'b1110;//add addi
		a_in = 32'h80000000;
		b_in = 32'h80000000;
		#1
		if(!((alu_out == 0) && (less == 1) && (overflow == 1) && (zero == 1)))
			$stop;
		alu_op = 4'b1111;//sub
		a_in = 32'h7fffffff;
		b_in = 32'hffffffff;
		#1
		if(!((alu_out == 32'h80000000) && (less == 0) && (overflow == 1) && (zero == 0)))
			$stop;
		#1
		$stop;
	end
endmodule
