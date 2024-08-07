
/****************************************************
** RISC-V_R_instr_tb.sv
** Author: Kai Roy, 
** Version: 1.0
** Date: 7/13/2024
** Description: Testbench for the RISC-V_R_instr.sv file
****************************************************/
`timescale 1ns / 1ps
import riscv_pkg::*;

module tb();
	// Base Vars
	logic clk;
	logic reset;
	logic [31:0] iaddr;  
	logic [31:0] pc;     
	logic [31:0] x31;

	// Inputs
    reg [31:0] idata;
    logic signed [31:0] imm, rv1, rv2;

	// Outputs
	logic signed [31:0] rd;

	// Interface
    Instr_IO bus(.*);

	// Aliases
    assign bus.idata = idata;
    assign bus.iaddr = iaddr;
    assign bus.imm = imm;
    assign bus.rv1 = rv1;
    assign bus.rv2 = rv2;

    assign rd = bus.regdata_R;

	// Variables
    r_func func;
    assign func = r_func'({bus.idata[30], bus.idata[25], bus.idata[14:12]});

	// Instantiate the module
    R_type iDUT(bus.R_type_io_ports);

	// Display System
    function void display_state;
        $display("Instruction: %0s\nrv1 = %d\trv2 = %d\nrd: %d\n", 
        func.name(), rv1, rv2, rd);
    endfunction
    function void display_b_txt(string str);
        $display("\n%c[1;34m",27);
        $write(str);
        $display("%c[0m\n",27);
    endfunction
	function void display_pass(string str);
		$write("%c[1;31m",27);
        $write(str);
        $write("%c[0m\n\n",27);
	endfunction

	initial begin
		#10 //ADD
		display_b_txt("Test 1: ADD");
		$cast({idata[30], idata[25], idata[14:12]}, ADD);
		rv1=32'd415;
		rv2=32'd60;
		#1 display_state();
		if (rd == (rv1 + rv2))
			display_pass("PASS");
		else 
			display_pass("FAIL");

		#10 //SUB
		display_b_txt("Test 2: SUB");
		$cast({idata[30], idata[25], idata[14:12]}, SUB);
		rv1=32'd6553;
		rv2=32'd653;
		#1 display_state();
		if (rd == (rv1 - rv2))
			display_pass("PASS");
		else 
			display_pass("FAIL");

		#10 //SLL
		display_b_txt("Test 3: SLL");
		$cast({idata[30], idata[25], idata[14:12]}, SLL);
		rv1=32'd288;
		rv2=32'd349;
		#1 display_state();
		if (rd == (rv1 << rv2[4:0]))
			display_pass("PASS");
		else 
			display_pass("FAIL");

		#10 //SLT
		display_b_txt("Test 4: SLT");
		$cast({idata[30], idata[25], idata[14:12]}, SLT);
		rv1=32'd696;
		rv2=32'd623;
		#1 display_state();
		if (rd == (rv1 < rv2))
			display_pass("PASS");
		else 
			display_pass("FAIL");

		#10 //SLTU
		display_b_txt("Test 5: SLTU");
		$cast({idata[30], idata[25], idata[14:12]}, SLTU);
		rv1=32'd447;
		rv2=32'd726;
		#1; display_state();
		if (rd == (unsigned'(rv1) < unsigned'(rv2)))
			display_pass("PASS");
		else 
			display_pass("FAIL");

		#10 //XOR
		display_b_txt("Test 6: XOR");
		$cast({idata[30], idata[25], idata[14:12]}, XOR);
		rv1=32'd696;
		rv2=32'd939;
		#1 display_state();
		if (rd == (rv1 ^ rv2))
			display_pass("PASS");
		else 
			display_pass("FAIL");

		#10 //SRL
		display_b_txt("Test 7: SRL");
		$cast({idata[30], idata[25], idata[14:12]}, SRL);
		rv1=32'd147;
		rv2=32'd194;
		#1 display_state();
		if (rd == (rv1 >> rv2[4:0]))
			display_pass("PASS");
		else 
			display_pass("FAIL");

		#10 //SRA
		display_b_txt("Test 8: SRA");
		$cast({idata[30], idata[25], idata[14:12]}, SRA);
		rv1=32'd848;
		rv2=32'd325;
		#1 display_state();
		if (rd == (rv1 >>> rv2[4:0]))
			display_pass("PASS");
		else 
			display_pass("FAIL");

		#10 //OR
		display_b_txt("Test 9: OR");
		$cast({idata[30], idata[25], idata[14:12]}, OR);
		rv1=32'd378;
		rv2=32'd960;
		#1 display_state();
		if (rd == (rv1 | rv2))
			display_pass("PASS");
		else 
			display_pass("FAIL");

		#10 //AND
		display_b_txt("Test 10: AND");
		$cast({idata[30], idata[25], idata[14:12]}, AND);
		rv1=32'd404;
		rv2=32'd900;
		#1 display_state();
		if (rd == (rv1 & rv2))
			display_pass("PASS");
		else 
			display_pass("FAIL");

		#5
		$finish;
	end

endmodule : tb