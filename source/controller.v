`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NJU_CS_COD_2013 
// Student: Yueqi Chen
// 
// Create Date: 2015/10/13 13:19:11
// Design Name: mono_cpu_mips
// Module Name: controller
// Project Name: mono_cpu_mips
// Target Devices:  xxx
// Tool Versions:  xxx
// Description: 
// controller in the mips-cpu to generate control signal
// according to the very instruction 
// 
// Dependencies:  none
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//to be read easily, use .define

module controller
(
	input [5:0] op,
	input [4:0] Rs,Rt,
	input [4:0] Shamt,
	input [5:0] Func,
	input Overflow_out,
	output reg Jump, Extend_sel, Shift_amount_sel, Rd_addr_sel,
	output reg ALU_Shift_sel, Rt_addr_sel,
	output reg [1:0] Shift_op, B_in_sel, 
	output reg [3:0] ALU_op , Rd_byte_w_en,
	output reg [2:0] condition
);

	always@(*)//to avoid latch , assign completely
	begin
		Shift_amount_sel <= 1'b0;
		Shift_op <= 2'b00;
		ALU_op <= 4'b1110; 
		condition <= 3'b000;
		if(Overflow_out == 0)begin//Rd_byte_w_en in overflow_out = 0
			if((op < 5'h8) && (op > 5'h0))
				Rd_byte_w_en <= 4'b1111;
			else
				Rd_byte_w_en <= 4'b0000;
		end
		else begin//Rd_byte_w_en in overflow_out = 1
			if((op < 5'h9) && (op > 5'h0))
				Rd_byte_w_en <= 4'b1111;
			else if((op == 0) && ((Func == 6'h20) || (Func == 6'h22)))
				Rd_byte_w_en <= 4'b1111;
			else
				Rd_byte_w_en <= 4'b0000;
		end

		if((op > 5'h7) && (op < 5'h10))//B_in_sel , Rd_addr_sel
		begin
			if(op == 5'hf)
				B_in_sel <= 2'b10;
			else
				B_in_sel <= 2'b01;
			Rd_addr_sel <= 0;
		end
		else 
		begin
			B_in_sel <= 2'b00;
			Rd_addr_sel <= 1;
		end

		if((op > 5'ha) && (op < 5'hf))//Extend_sel
			Extend_sel <= 0;
		else
			Extend_sel <= 1;

		if(op == 0)// ALU_Shift_sel , Shift_amount_sel
		begin
			if((Func == 0) || (Func == 6'h3) || (Func == 6'h2)) 
			begin
				ALU_Shift_sel <= 1'b1;
				Shift_amount_sel <= 1'b0;
			end
			else if((Func == 6'h4) || (Func == 6'h7) || (Func == 6'h6))
			begin
				ALU_Shift_sel <= 1;
				Shift_amount_sel <= 1;
			end
			else
				ALU_Shift_sel <= 0;
		end
		else
			ALU_Shift_sel <= 0;

		if(op == 1)//condition
		begin
			if(Rt == 0)
				condition <= 3'b110;//bltz
			else if(Rt == 1)
				condition <= 3'b011;//bgez
		end
		else if(op == 4)//beq
			condition <= 3'b001;
		else if(op == 5)//bne
			condition <= 3'b010;
		else if(op == 6)//blez
			condition <= 3'b101;
		else if(op == 7)//bgtz
			condition <= 3'b100;
		else
			condition <= 3'b000;

		if(op == 0)//Shift_op
		begin
			if((Func == 0) || (Func == 6'h4))//sll,sllv
				Shift_op <= 2'b00;
			else if((Func == 6'h3) || (Func == 6'h7))//sra,srav
				Shift_op <= 2'b10;
			else if(Func == 6'h2)
			begin
				if(Rs == 0)
					Shift_op <= 2'b01;//srl,srlv
				else if(Rs == 1)
					Shift_op <= 2'b11;//rotr,rotrv
			end
			else if(Func == 6'h6)
			begin
				if(Shamt == 0)
					Shift_op <= 2'b01;//srl,srlv
				else if(Shamt == 1)
					Shift_op <= 2'b11;//rotr,rotrv
			end
		end

		if(op == 6'h2)//Jump
			Jump <= 1;
		else
			Jump <= 0;

		if(((op == 6'h1) && (Rt == 1)) || ((op == 6'h7) && (Rt == 0)))//Rt_addr_sel
			Rt_addr_sel <= 1;
		else
			Rt_addr_sel <= 0;

		if(((op == 0) && (Func == 6'h20)) || op == 6'h8)//add addi
			ALU_op <= 4'b1110; 
		else if(((op == 0) && (Func == 6'h21)) || op == 6'h9 || op == 6'hf)//addu addiu lui
			ALU_op <= 4'b0000;
		else if((op == 0) && (Func == 6'h22))//sub
			ALU_op <= 4'b1111;
		else if(((op == 0) && (Func == 6'h23)) || ((op > 0) && (op < 8)))//subu , bltz , bgez , beq , bne , blez , bgtz
			ALU_op <= 4'b0001;
		else if(((op == 0) && (Func == 6'h24)) || op == 6'hc)//and , andi
			ALU_op <= 4'b0100;
		else if(((op == 0) && (Func == 6'h25)) || op == 6'hd)//or , ori
			ALU_op <= 4'b0110;
		else if(((op == 0) && (Func == 6'h26)) || op == 6'he)//xor , xori
			ALU_op <= 4'b1001;
		else if((op == 0) && (Func == 6'h27))//nor
			ALU_op <= 4'b1000;
		else if(((op == 0) && (Func == 6'h2a)) || op == 6'ha)//stl stli
			ALU_op <= 4'b0101;
		else if(((op == 0) && (Func == 6'h2b)) || op == 6'hb)//stlu stliu
			ALU_op <= 4'b0111;
		else if(op == 6'h1c)
		begin
			if(Func == 6'h20)
				ALU_op <= 4'b0010;
			else if(Func == 6'h21)
				ALU_op <= 4'b0011;
		end
		else if(op == 6'h1f)
		begin
			if(Shamt == 5'h10)
				ALU_op <= 4'b1010;
			else if(Shamt == 5'h18)
				ALU_op <= 4'b1011;
		end
	end
endmodule
