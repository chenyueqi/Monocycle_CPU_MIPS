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
// Dependencies: controller , selector21_32 , selector81_1 , alu , 
// selector31_32 , selector21_5 , barrel_shift_mips , program_count
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mono_cpu(
	input clk,
	output [31:0] pc
);
	wire [31:0] pc_next;
	wire [31:0] instr;
//	wire [31:0] pc;

	/*controller related*/
	wire Jump , Extend_sel , Shift_amount_sel , Rd_addr_sel;
	wire ALU_Shift_sel , Rt_addr_sel , overflow;
	wire [1:0] Shift_op , B_in_sel;	
	wire [3:0] ALU_op , Rd_byte_w_en;
	wire [2:0] condition;
	
	/*alu related*/
	wire [31:0] B_in;
	wire [31:0] ALU_out;
	wire less , zero;

	/* register group related*/
	wire [4:0] Rt_addr;
	wire [4:0] Rd_addr;
	wire [31:0] Rd_in;
	wire [31:0] Rs_out;
	wire [31:0] Rt_out;

	/*shifter related*/
	wire [4:0] Shift_amount;
	wire [31:0] Shift_out;

	
	wire [31:0] Ex_offset;
	wire [31:0] Ex_offset_2;
	wire [31:0] Imm_ex;
	wire branch_selec;
	wire [31:0] jump_selec_choice0;
	wire [31:0] jump_selec_choice1;

	/*controller to generate control signal*/
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

	/*alu*/
	alu alu(
		.a_in(Rs_out),
		.b_in(B_in),
		.alu_op(ALU_op),
		.less(less),
		.overflow_out(overflow),
		.zero(zero),
		.alu_out(ALU_out)
	);

	/* register group*/
	register_mips32 registers(
		.Rs_addr(instr[25:21]),
		.Rt_addr(Rt_addr),
		.Rd_addr(Rd_addr),
		.clk(clk),
		.Rd_Byte_w_en(Rd_byte_w_en),
		.Rd_in(Rd_in),
		.Rs_out(Rs_out),
		.Rt_out(Rt_out)
	);

	/*barrel shifter*/
	barrel_shift_mips shifter(
		.data_in(Rt_out),
		.shift_count(Shift_amount),
		.op(Shift_op),
		.data_out(Shift_out)
	);

	/*programmer counter*/
	program_counter Program_c(
		.PC_in(pc_next),
		.PC_out(pc),
		.clk(clk)
	);

	/*instruction memory*/
	instr_memory IM(
		.addr(pc),
		.instr(instr)
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
		.selec(Rd_addr_sel),
		.out(Rd_addr)
	);

	selector21_5 shift_amount_selector(
		.choice_0(instr[10:6]),
		.choice_1(Rs_out[4:0]),
		.selec(Shift_amount_sel),
		.out(Shift_amount)
	);

	selector21_32 alu_shift_selector(
		.choice_0(ALU_out),
		.choice_1(Shift_out),
		.selec(ALU_Shift_sel),
		.out(Rd_in)
	);

	extend_selector extend_selector(
		.Instr(instr[15:0]),
		.Extend_sel(Extend_sel),
		.Ex_offset(Ex_offset)
	);	

	selector31_32 B_in_selector(
		.choice_0(Rt_out),
		.choice_1(Ex_offset),
		.choice_2(Imm_ex),
		.selec(B_in_sel),
		.out(B_in)
	);

	selector81_1 condition_selector(
		.in0(1'b0),
		.in1(zero),
		.in2(~zero),
		.in3(~less),
		.in4(~(zero|less)),
		.in5(zero|less),
		.in6(less),
		.in7(1'b1),
		.condition(condition),
		.out(branch_selec)
	);

	selector21_32 branch_selector(
		.choice_0(pc + 4),
		.choice_1(pc + 4 + Ex_offset_2),
		.selec(branch_selec),
		.out(jump_selec_choice0)
	);

	selector21_32 jump_selector(
		.choice_0(jump_selec_choice0),
		.choice_1(jump_selec_choice1),
		.selec(Jump),
		.out(pc_next)
	);




	assign Imm_ex[31:16] = instr[15:0];
	assign Imm_ex[15:0] = 16'h0;
	assign jump_selec_choice1[31:28] = pc[31:28];
	assign jump_selec_choice1[27:2] = instr[25:0];
	assign jump_selec_choice1[1:0] = 2'b0;
	assign Ex_offset_2[31:2] = Ex_offset[29:0];
	assign Ex_offset_2[1:0] = 2'b00;
endmodule
