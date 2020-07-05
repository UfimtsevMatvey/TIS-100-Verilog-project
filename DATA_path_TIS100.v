module DATA_path(
	input wire clk, reset,
	input wire SwpActiveReg,
	input wire [0:1] SwpinA,
	input wire SwpinB,
	input wire enBak,
	input wire [0:1] ALUdesk,
	input wire [0:13] datainstr,
	input wire [0:7] in0, in1, in2, in3,
	output wire [0:7] out0, out1, out2, out3,
	output wire [0:7] ACCond
);
	wire [0:7] enableOut, enableIn;
	reg [0:7] ACC, bak;
	wire [0:7] ACCdata, bakdata;
	wire enableACC, enablebak;
	wire [0:7] ALURes;
	decode1_8 InputDec(.Control(datainstr[3:5]), .Y(enableOut));
	mux8_1 InputMux(.Control(datainstr[0:2]), .X1(in0), .X2(in1),.X3(in2), .X4(in3), .X5(ACC), .X6(datainstr[6:13]), .X7(bak), .X8(8'b0), .Y(enableIn));
	neg_Reg outreg0(.clk(clk), .enable(enableOut[0]), .reset(reset), .data(enableIn), .out_data(out0));
	neg_Reg outreg1(.clk(clk), .enable(enableOut[1]), .reset(reset), .data(enableIn), .out_data(out1));
	neg_Reg outreg2(.clk(clk), .enable(enableOut[2]), .reset(reset), .data(enableIn), .out_data(out2));
	neg_Reg outreg3(.clk(clk), .enable(enableOut[3]), .reset(reset), .data(enableIn), .out_data(out3));
	mux4_1 SwapACC(.Control(SwpinA), .X1(enableIn), .X2(ALURes),.X3(8'b0), .X4(bak), .Y(ACCdata));
	mux2_1 Swapbak(.Control(SwpinB), .X1(enableIn), .X2(ACC), .Y(bakdata));
	neg_Reg ACCreg(.clk(clk), .enable(enableACC), .reset(reset), .data(ACCdata), .out_data(ACC));
	neg_Reg bakreg(.clk(clk), .enable(enablebak), .reset(reset), .data(bakdata), .out_data(bak));
	
	mux2_1 #(1) ACCeb(.Control(SwpActiveReg), .X1(enableOut[4]), .X2(1'b1), .Y(enableACC));
	mux2_1 #(1) bakeb(.Control(SwpActiveReg), .X1(enableOut[5]), .X2(enBak), .Y(enablebak));
	
	ALU ALU(.X1(ACC), .X2(enableIn), .code(ALUdesk), .Y(ALURes));
	
	
	assign ACCond = ACC;
	
endmodule