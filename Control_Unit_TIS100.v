module control_unit(
	input wire clk, reset,
	input wire [0:4] instrType,
	input wire [0:1] dType,
	input wire [0:2] sType,
	input wire [0:7] jACC,

	output reg SwpActiveReg,
	output reg [0:1] SwpinA,
	output reg SwpinB,
	output reg enBak,
	output reg [0:1] ALU_desk,
	output reg jmpInstr,
	output reg [0:1] jmpCond,
	output wire [0:7] outACC,
	output reg hlt,
	output reg ack
	);
	wire [0:7] temp;
	always @(*) begin
		case(instrType[0:3])
			4'b0000: //mov
				begin
					case(dType)
						2'b00: hlt = 1'b0;
						2'b01: hlt = 1'b0;
						2'b10: hlt = 1'b1;
						2'b11: hlt = 1'b1;
					endcase
				
					case(sType)
						3'b100: ack = 1'b0;
						3'b101: ack = 1'b0;
						3'b111: ack = 1'b0;
						3'b110: ack = 1'b0;
						default: ack = 1'b1;
					endcase
					
					SwpActiveReg = 1'b0;
					SwpinA = 2'b00;
					SwpinB = 1'b0;
					ALU_desk = 2'b00;
					jmpInstr = 1'b0;
					jmpCond = 2'b00;
					enBak = 1'b0;
				end
			4'b0001: //swp
				begin
					ack = 1'b0;
					hlt = 1'b0;
					SwpActiveReg = 1'b1;
					SwpinA = 2'b11;
					SwpinB = 1'b1;
					ALU_desk = 2'b00;
					jmpInstr = 1'b1;
					jmpCond = 2'b00;
					enBak = 1'b1;
				end
			4'b0010: //sub
				begin
					ack = 1'b0;
					hlt = 1'b0;
					SwpActiveReg = 1'b0;
					SwpinA = 2'b01;
					SwpinB = 1'b0;
					ALU_desk = 2'b10;
					jmpInstr = 1'b0;
					jmpCond = 2'b00;
					enBak = 1'b0;
				end
			4'b0011: //add
				begin
					ack = 1'b0;
					hlt = 1'b0;
					SwpActiveReg = 1'b0;
					SwpinA = 2'b01;
					SwpinB = 1'b0;
					ALU_desk = 2'b01;
					jmpInstr = 1'b0;
					jmpCond = 2'b00;
					enBak = 1'b0;
				end
			4'b0100: //jmp
				begin
					ack = 1'b0;
					hlt = 1'b0;
					if(instrType[4])
						jmpCond = 2'b01;
					else
						jmpCond = 2'b10;
					SwpActiveReg = 1'b0;
					SwpinA = 2'b00;
					SwpinB = 1'b0;
					ALU_desk = 2'b00;
					jmpInstr = 1'b1;
					enBak = 1'b0;
				end
			4'b0101: //jez
				begin
					ack = 1'b0;
					hlt = 1'b0;
					if(|jACC)
					begin
						if(instrType[4])
							jmpCond = 2'b01;
						else
							jmpCond = 2'b10;
					end
					else
						jmpCond = 2'b00;
					SwpActiveReg = 1'b0;
					SwpinA = 2'b00;
					SwpinB = 1'b0;
					ALU_desk = 2'b00;
					jmpInstr = 1'b1;
					enBak = 1'b0;
				end
			4'b0110: //jnz
				begin
					ack = 1'b0;
					hlt = 1'b0;
					if(&jACC)
					begin
						if(instrType[4])
							jmpCond = 2'b01;
						else
							jmpCond = 2'b10;
					end
					else
						jmpCond = 2'b00;
					SwpActiveReg = 1'b0;
					SwpinA = 2'b00;
					SwpinB = 1'b0;
					ALU_desk = 2'b00;
					jmpInstr = 1'b1;
					enBak = 1'b0;
				end
			4'b0111: //jgz
				begin
					ack = 1'b0;
					hlt = 1'b0;
					if(~jACC[0])
					begin
						if(instrType[4])
							jmpCond = 2'b01;
						else
							jmpCond = 2'b10;
					end
					else
						jmpCond = 2'b00;
					SwpActiveReg = 1'b0;
					SwpinA = 2'b00;
					SwpinB = 1'b0;
					ALU_desk = 2'b00;
					jmpInstr = 1'b1;
					enBak = 1'b0;
				end
			4'b1000: //jlz
				begin
					ack = 1'b0;
					hlt = 1'b0;
					if(jACC[0])
					begin
						if(instrType[4])
							jmpCond = 2'b01;
						else
							jmpCond = 2'b10;
					end
					else
						jmpCond = 2'b00;
					SwpActiveReg = 1'b0;
					SwpinA = 2'b00;
					SwpinB = 1'b0;
					ALU_desk = 2'b00;
					jmpInstr = 1'b1;
					enBak = 1'b0;
				end
			4'b1001: //neg
				begin
					ack = 1'b0;
					hlt = 1'b0;
					SwpActiveReg = 1'b1;
					SwpinA = 2'b01;
					SwpinB = 1'b0;
					ALU_desk = 2'b11;
					jmpInstr = 1'b1;
					jmpCond = 2'b00;
					enBak = 1'b0;
				end
			default:
				begin
					ack = 1'b0;
					hlt = 1'b0;
					SwpActiveReg = 1'b0;
					SwpinA = 2'b00;
					SwpinB = 1'b0;
					ALU_desk = 2'b00;
					jmpInstr = 1'b1;
					jmpCond = 2'b00;
					enBak = 1'b0;
				end
		endcase
		
	end
	assign outACC = jACC;
	endmodule
