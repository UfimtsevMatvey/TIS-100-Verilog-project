module jmp_path(
	input wire 			rst_n,
	input wire 			clk,
	input wire [0:1] 	jmpCond,
	input wire 			jmpInstr,
	input wire [0:17] 	instr,
	input wire [0:7] 	jAddr,
	output wire [0:7] 	Addr_instr,
	input wire			hlt_en
	);
	reg [0:7] ipNext;
	wire [0:7] incAddr;
	reg [0:7] ipCurrent;

	wire [0:7] imm;
	assign imm = instr[10:17];
	always @(*) begin
		case(jmpCond)
			2'b00:
				ipNext = incAddr;
			2'b01:
				ipNext = jAddr;
			2'b10:
				ipNext = imm;
			2'b11:
				ipNext = 8'b0;
		endcase
	end

	//Adder incAdder(.X1(ipCurrent), .X2(8'b1), .Y(incAddr));
	assign incAddr = ipCurrent + 8'h1;

	always @(posedge clk) begin
		if(~rst_n) ipCurrent <= 'h0;
		else if(hlt_en)
			ipCurrent <= ipCurrent;
		else
			ipCurrent <= ipNext;
	end

	assign Addr_instr = ipCurrent;
endmodule