// `timescale 1ns / 1ps
`timescale 1ns / 1ns
//DMEM module
    
module dmem(
	Instr_IO_cpu_sig dmem_if
);


 logic clk;
 logic [31:0] daddr;
 logic [31:0] dwdata;
 logic [3:0] we;
 wire [31:0] drdata;
 
assign clk=dmem_if.clk;
assign daddr=dmem_if.daddr;
assign dwdata=dmem_if.dwdata;
assign we=dmem_if.we;
assign dmem_if.drdata=drdata;



     logic [7:0] m [0:127];
	 wire [31:0] add0,add1,add2,add3;
	 //initial $readmemh("dmem_ini.mem",m);
	
	 //assign m=32'hfffffffc;
	 assign add0 = (daddr & 32'hfffffffc)+ 32'h00000000;
	 assign add1 = (daddr & 32'hfffffffc)+ 32'h00000001;
	 assign add2 = (daddr & 32'hfffffffc)+ 32'h00000002;
	 assign add3 = (daddr & 32'hfffffffc)+ 32'h00000003;
	 
	initial m[0]=8'hff;
	 
	 assign drdata = {m[add3], m[add2], m[add1], m[add0]};
	 
	 always @(posedge clk)
	 begin
		if(we[0]==1)
			m[add0] <= dwdata[7:0];
		else if(we[1]==1)
			m[add1] <= dwdata[15:8];
		else if(we[2]==1)
			m[add2] <= dwdata[23:16];
		else if(we[3]==1)
			m[add3] <= dwdata[31:24];
	 end
endmodule