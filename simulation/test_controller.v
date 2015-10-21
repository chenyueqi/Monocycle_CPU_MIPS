`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NJU_CS_COD_2013
// Engineer: Yueqi chen
// 
// Create Date: 2015/10/17 15:24:08
// Design Name: mono_cpu_mips
// Module Name: test_controller
// Project Name: mono_cpu_mips
// Target Devices: xxx
// Tool Versions: xxx
// Description: 
// test controller
// 
// Dependencies: xxx
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_controller();
	reg [5:0] op;
	reg [4:0] Rs , Rt;
	reg [4:0] Shamt;
	reg [5:0] Func;
	reg overflow;

	wire Jump , Extend_sel , Shift_amount_sel , Rd_addr_sel;
	wire ALU_Shift_sel , Rt_addr_sel;
	wire [1:0] Shift_op , B_in_sel;
	wire [3:0] ALU_op , Rd_byte_w_en;
	wire [2:0] condition;

	controller c1(
		.op(op),
		.Rs(Rs),
		.Rt(Rt),
		.Shamt(Shamt),
		.Func(Func),
		.Overflow_out(overflow),
		.Rd_byte_w_en(Rd_byte_w_en),
		.B_in_sel(B_in_sel),
		.Extend_sel(Extend_sel),
		.ALU_op(ALU_op),
		.Rd_addr_sel(Rd_addr_sel),
		.Shift_amount_sel(Shift_amount_sel),
		.ALU_Shift_sel(ALU_Shift_sel),
		.condition(condition),
		.Shift_op(Shift_op),
		.Jump(Jump),
		.Rt_addr_sel(Rt_addr_sel)
	);

	initial begin
		//add
		overflow = 0;
		op = 0;
		Rs = 0;
		Rt = 0;
		Shamt = 0;
		Func = 6'h20;
		#1
		Func = 6'h21;//addu
		#1
		Func = 6'h22;//sub
		#1
		Func = 6'h23;//subu
		#1
		Func = 6'h24;//and
		#1
		Func = 6'h25;//or
		#1
		Func = 6'h26;//xor
		#1
		Func = 6'h27;//nor
		#1
		Func = 6'h2a;//slt
		#1
		Func = 6'h2b;//sltu
		#1//bltz
		op = 6'h1;
		Rt = 5'h0;
		#1//bgez
		Rt = 5'h1;
		#1//beq
		op = 6'h4;
		#1//bne
		op = 6'h5;
		#1//blez
		op = 6'h6;
		Rt = 5'h0;
		#1//bgtz
		op = 6'h7;
		#1//addi
		op = 6'h8;
		#1//addiu
		op = 6'h9;
		#1//slti
		op = 6'ha;
		#1//sltiu
		op = 6'hb;
		#1//andi
		op = 6'hc;
		#1//ori
		op = 6'hd;
		#1//xori
		op = 6'he;
		#1//lui
		op = 6'hf;
		Rs = 5'h0;
		#1//clz
		op = 6'h1c;
		Shamt = 0;
		Func = 6'h20;
		#1//clo
		Func = 6'h21;
		#1//seb
		op = 6'h1f;
		Rs = 0;
		Shamt = 5'h10;
		Func = 6'h20;
		#1//seh
		Shamt = 5'h18;
		#1//sll
		op = 0;
		Rs = 0;
		Func = 0;
		#1//sllv
		Shamt = 0;
		Func = 6'h4;
		#1//sra
		Func = 6'h3;
		#1//srav
		Func = 6'h7;
		#1//srl
		Func = 6'h2;
		#1//srlv
		Func = 6'h6;
		#1//rotr
		Rs = 1;
		Func = 6'h2;
		#1//rotrv
		Shamt = 1;
		Func = 6'h6;
		#1//j
		op = 2;
		#1



		overflow = 1;
		op = 0;
		Rs = 0;
		Rt = 0;
		Shamt = 0;
		Func = 6'h20;
		#1
		Func = 6'h21;//addu
		#1
		Func = 6'h22;//sub
		#1
		Func = 6'h23;//subu
		#1
		Func = 6'h24;//and
		#1
		Func = 6'h25;//or
		#1
		Func = 6'h26;//xor
		#1
		Func = 6'h27;//nor
		#1
		Func = 6'h2a;//slt
		#1
		Func = 6'h2b;//sltu
		#1//bltz
		op = 6'h1;
		Rt = 5'h0;
		#1//bgez
		Rt = 5'h1;
		#1//beq
		op = 6'h4;
		#1//bne
		op = 6'h5;
		#1//blez
		op = 6'h6;
		Rt = 5'h0;
		#1//bgtz
		op = 6'h7;
		#1//addi
		op = 6'h8;
		#1//addiu
		op = 6'h9;
		#1//slti
		op = 6'ha;
		#1//sltiu
		op = 6'hb;
		#1//andi
		op = 6'hc;
		#1//ori
		op = 6'hd;
		#1//xori
		op = 6'he;
		#1//lui
		op = 6'hf;
		Rs = 5'h0;
		#1//clz
		op = 6'h1c;
		Shamt = 0;
		Func = 6'h20;
		#1//clo
		Func = 6'h21;
		#1//seb
		op = 6'h1f;
		Rs = 0;
		Shamt = 5'h10;
		Func = 6'h20;
		#1//seh
		Shamt = 5'h18;
		#1//sll
		op = 0;
		Rs = 0;
		Func = 0;
		#1//sllv
		Shamt = 0;
		Func = 6'h4;
		#1//sra
		Func = 6'h3;
		#1//srav
		Func = 6'h7;
		#1//srl
		Func = 6'h2;
		#1//srlv
		Func = 6'h6;
		#1//rotr
		Rs = 1;
		Func = 6'h2;
		#1//rotrv
		Shamt = 1;
		Func = 6'h6;
		#1//j
		op = 2;
		#1


		$stop;

	end
endmodule
