`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NJU_CS_COD_2013
// Engineer: Yueqi Chen
// 
// Create Date: 2015/10/20 15:49:53
// Design Name: mono_cpu_mips
// Module Name: mono_cpu
// Project Name: mono_cpu_mips
// Target Devices: xxx
// Tool Versions: xxx
// Description: 
// cpu
// Dependencies: controller , selector21_32 , selector81_1
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mono_cpu(
	input clk,
	input [31:0] instr
);
	wire Jump , Extend_sel , Shift_amount_sel , Rd_addr_sel;
	wire ALU_Shift_sel , Rt_addr_sel , overflow;
	wire [1:0] Shift_op , B_in_sel;	
	wire [3:0] ALU_op , Rd_byte_w_en;
	wire [2:0] condition;
	wire [31:0] Rs_out;
	wire [31:0] ALU_out;
	wire [31:0] Shift_out;
	wire [31:0] Ex_offset;
	wire [4:0] Rt_addr;
	wire [4:0] Rd_addr;
	wire [31:0] Rd_in;


	controller ctr(
		.op(instr[31:26]),
		.Rs(instr[25:21]),
		.Rt(instr[20:16]),
		.Shamt(instr[10:6]),
		.Func(instr[5:0]),
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

	selector21_5 rt_addr_selector(
		.choice_0(instr[20:16]),
		.choice_1(5'b0),
		.selec(Rt_addr_sel),
		.out(Rt_addr)
	);

	selector21_5 rd_addr_selector(
		.choice_0(instr[20:16]),
		.choice_1(instr[15:11]),
		.selec(Rd_addr_sel)
	);

	selector21_5 shift_amount_selector(
		.choice_0(instr[10:6]),
		.choice_1(Rs_out[4:0]),
		.selec(Shift_amount_sel)
	);

	selector21_32 alu_shift_selector(
		.choice_0(ALU_out),
		.choice_1(Shift_out),
		.selec(ALU_Shift_sel)
	);

	extend_selector extend_selector(
		.Instr(instr[15:0]),
		.Extend_sel(Extend_sel),
		.Ex_offset(Ex_offset)
	);	

	selector31_32 B_in_selector(
		.choice_0(Rt_out),
		.choice_1(Ex_offset),
		.choice_2(),//incompleted
	);

	selector21_32 jump_selector(
	
	);

	selector21_32 branch_selector(
	
	);

	selector81_1 condition_selector(
	
	);

	alu alu(

	);

	barrel_shift_mips barrel_shifter(

	);

	register_mips32 registers(
		.Rs_addr(instr[25:21]),
		.Rt_addr(Rt_addr),
		.Rd_addr(Rd_addr),
		.clk(clk),
		.Rd_Byte_w_en(Rd_byte_w_en),
		.Rd_in(Rd_in),//incompleted
		.Rs_out(),//incompleted
		.Rt_out(), //incompleted
	);
endmodule
