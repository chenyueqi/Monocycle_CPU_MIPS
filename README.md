# Monocycle_CPU_MIPS
A simple monocycle cpu based on mips instruction set, which served as a part of course 'computer organization and design'.

Develop environment:
Xilinx_Vivado_SDK_2014.2_0606_1_Win64
FPGA:xc7a100tcsg324-1

File struct:
  directory ./source 
    |adder.v -- adder module whose top module is alu
    |alu.v -- alu , achieve basic arithmetic fuction 
    |alu_controller.v -- alu control  , used to translate op to control signal in alu whose top module is alu
    |barrel_shift_mips.v -- barrel_shifter , used to logic right/left shift , round right shift , arithmetic right shift
    |controller.v -- control signal generator , used to translate instruction to significent signal in cpu
    |extend_selector.v  -- extend immediate instruction according extend signal generated by controller
    |momo_cpu.v --top module
    |program_counter.v -- pc
    |register_mips32.v -- 32 registers in mips cpu , register0 is always zero
    |selector21_5.v -- 2 to 1 selector with data path wedth 5 bits
    |selector21_32.v -- 2 to 1 selector with data path wedth 31 bits
    |selector31_31.v -- 3/4 to 1 selector with data path wedth 31 bits
    |selector81_1.v -- 8 to 1 selector with data path wedth 1 bit
  directory ./simulation
    |test_control.v -- simulate controller 
    |test_alu.v -- simulate alu
    |test_alu_controller.v --simulate alu controller
    |test_barrel_shift_mips.v --simulate barrel shifter
    |test_controller.v --simulate controller
    |test_program_counter.v --simulate pc
    |test_register_mips32.v --simulate register group
    
How to use?
open vivado and creat a project, then add the source file and simulate file into the project. The file struct and logic relationship between each module are self-organized.
