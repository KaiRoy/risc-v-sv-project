/****************************************************
** RISC-V_B_instr.sv
** Author: Kai Roy, 
** Version: 1.0
** Date: 11/20/2023
** Description: This file handles the B Type instructions
** of a RISC-V Single Cycle Processor. A new PC value
** is generated and then outputted. 
****************************************************/
// `timescale 1ns / 1ps
`timescale 1ns / 1ns
import riscv_pkg::*;


module B_type(Instr_IO.B_type_io_ports bus);
    logic 			[31:0] 	pc, iaddr;
    logic signed 	[31:0] 	imm, rs1, rs2;
    wire 			[2:0] 	instr;

    //Alias
    assign instr	= bus.idata[14:12];
    assign iaddr 	= bus.iaddr;
    assign imm 		= bus.imm;
    assign rs1 		= bus.rv1;
    assign rs2 		= bus.rv2;

    assign bus.iaddr_val = pc;


    //Additional Varibales
	b_func branch;
    logic [31:0] u_rs1, u_rs2;

	assign u_rs1 = unsigned'(rs1);
	assign u_rs2 = unsigned'(rs2);
    assign branch = b_func'(instr);

    always_comb begin
		unique case(branch)
            BEQ:  pc = (rs1 == rs2)     ? (iaddr+imm) : (iaddr+4);
            BNE:  pc = (rs1 != rs2)     ? (iaddr+imm) : (iaddr+4);
            BLT:  pc = (rs1 < rs2)      ? (iaddr+imm) : (iaddr+4);
            BGE:  pc = (rs1 >= rs2)     ? (iaddr+imm) : (iaddr+4);
            BLTU: pc = (u_rs1 < u_rs2)  ? (iaddr+imm) : (iaddr+4);
            BGEU: pc = (u_rs1 >= u_rs2) ? (iaddr+imm) : (iaddr+4);
		    default: ;
		endcase
	 end
endmodule