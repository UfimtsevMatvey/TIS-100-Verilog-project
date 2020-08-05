module Exe_path(
	input wire clk, reset, ackw,
	input wire SwpActiveReg,
	input wire [0:1] SwpinA,
	input wire SwpinB,
	input wire enBak,
	input wire hlt,
	input wire [0:1] ALUdesk,
	input wire jmpInstr,
	input wire [0:1] jmpCond,
	input wire [0:17] instr,
	input wire [0:7] jAddr,
	input wire [0:7] in0, in1, in2, in3,
	output wire [0:7] out0, out1, out2, out3,
	output wire [0:7] ACCond,
	output wire [0:7] Addr_instr,
	output wire [0:4] instrType,
	output wire [0:1] dType,
	output wire [0:2] sType
);
	wire [0:13] datainstr;
	DATA_path Data(.clk(clk), .reset(reset), .SwpActiveReg(SwpActiveReg), .SwpinA(SwpinA), .SwpinB(SwpinB),.enBak(enBak), .ALUdesk(ALUdesk), 
						.datainstr(datainstr), .in0(in0), .in1(in1), .in2(in2), .in3(in3),
							.out0(out0), .out1(out1), .out2(out2), .out3(out3), .ACCond(ACCond));
	JMP_path jmp(.clk(clk), .reset(reset),.jmpCond(jmpCond), .jmpInstr(jmpInstr), .instr(instr), .jAddr(jAddr), .hlt(hlt), .ackw(ackw),  .Addr_instr(Addr_instr), 
				.instrType(instrType), .dType(dType), .sType(sType), .datainstr(datainstr));
endmodule