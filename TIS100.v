module TIS100(
	input wire clk, reset, ackw,
	input wire [0:7] in0, in1, in2, in3,
	output wire [0:7] out0, out1, out2, out3,
	output wire [0:7] Addr_instr,
	output wire [0:17] instr,
	output wire ack
);
	wire [0:13] datainstr;
	wire [0:1] SwpinA;
	wire SwpinB;
	wire [0:1] ALUdesk;
	wire jmpInstr;
	wire [0:1] jmpCond;
	wire enBak;
	//wire [0:17] instr;
	wire [0:7] jAddr;
	wire [0:7] ACCond;
	//wire [0:7] Addr_instr;
	wire [0:4] instrType;
	wire [0:1] dType;
	wire [0:2] sType;
	wire SwpActiveReg;
	wire [0:7] jACC;
	wire hlt;
	
	Exe_path Exe_path(.clk(clk), .reset(reset), .ackw(ackw), .SwpActiveReg(SwpActiveReg),.SwpinA(SwpinA), .SwpinB(SwpinB), .enBak(enBak), .hlt(hlt),
		.ALUdesk(ALUdesk), .jmpInstr(jmpInstr), .jmpCond(jmpCond), .instr(instr), .jAddr(ACCond), .in0(in0), .in1(in1), .in2(in2), .in3(in3),  .ACCond(jACC), 
			.out0(out0), .out1(out1), .out2(out2), .out3(out3), .Addr_instr(Addr_instr), .instrType(instrType), .dType(dType), .sType(sType));
	control_unit control_unit(.clk(clk), .reset(reset), .instrType(instrType), .dType(dType), .sType(sType), .jACC(jACC), .SwpActiveReg(SwpActiveReg), .SwpinA(SwpinA), .SwpinB(SwpinB),
		.enBak(enBak), .ALU_desk(ALUdesk), .jmpInstr(jmpInstr), .jmpCond(jmpCond), .outACC(ACCond), .hlt(hlt), .ack(ack));
	Memory InstractionMemory(.A(Addr_instr), .RD(instr));
	
endmodule