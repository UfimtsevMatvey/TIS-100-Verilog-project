module JMP_path(
	input wire clk, reset,
	input wire [0:1] jmpCond,
	input wire jmpInstr,
	input wire [0:17] instr,
	input wire [0:7] jAddr,
	input wire hlt,
	input wire ackw,
	output wire [0:7] Addr_instr,
	output wire [0:4] instrType,
	output wire [0:1] dType,
	output wire [0:2] sType,
	output wire [0:13] datainstr
	);
	wire [0:7] ipNext;
	wire [0:7] ipMNext;
	wire [0:7] incAddr;
	wire selectState;
	reg [0:7] ipCurrent;
	mux4_1 fetchAddr(.Control(jmpCond), .X1(incAddr), .X2(jAddr), .X3(instr[10:17]), .X4(8'b0), .Y(ipMNext));
	Adder incAdder(.X1(ipCurrent), .X2(8'b1), .Y(incAddr));
	pos_Reg IPReg(.clk(clk), .enable(1'b1), .reset(reset), .data(ipNext), .out_data(ipCurrent));
	mux2_1 #(3) instrtype(.Control(jmpInstr), .X1(instr[7:9]), .X2(3'b111), .Y(datainstr[3:5]));
	pos_Reg_asin_reset #(1) startStopReg(.clk(hlt), .enable(1'b1), .reset(ackw), .data(1'b1), .out_data(selectState));
	mux2_1 #(8) selectStateMux(.Control(selectState), .X1(ipMNext), .X2(ipCurrent), .Y(ipNext));
	assign instrType = instr[0:4];
	assign dType = instr[8:9];
	assign sType = instr[4:6];
	assign Addr_instr = ipCurrent;
	assign datainstr[0:2] = instr[4:6];
	assign datainstr[6:13] = instr[10:17];
endmodule