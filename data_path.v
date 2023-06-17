module data_path(
	input wire 			rst_n,
	input wire 			clk,
	input wire 			SwpActiveReg,
	input wire [0:1] 	SwpinA,
	input wire 			SwpinB,
	//input wire 			enBak,
	input wire 			jmpInstr,
	input wire [0:1] 	ALUdesk,
	input wire [0:13] 	datainstr,
	output wire  		hlt_en,	
//read interface
    //read data
	input wire [0:7]    in0,
                        in1, 
                        in2, 
                        in3,
    //read ready
    input wire          rrdy0,
                        rrdy1,
                        rrdy2,
                        rrdy3,
    //read response
    output reg          rresp0,
                        rresp1,
                        rresp2,
                        rresp3,

    //write interface
    //write data
	output reg [0:7]    out0, 
                        out1, 
                        out2, 
                        out3,
    //write val
    output reg          val0,
                        val1,
                        val2,
                        val3,
    //write response
    input wire          wresp0,
                        wresp1,
                        wresp2,
                        wresp3,

	output wire [0:7] 	ACCond
);
	wire [0:7] enableOut; 
	reg [0:7] data_out;
	reg [0:7] ACC, bak;
	reg [0:7] ACCdata;
	wire [0:7] bakdata;
	wire enableACC, enablebak;
	wire [0:7] ALURes;


	reg [0:7] instr_sourse_decode;
	reg [0:7] instr_decode;

	reg data_ready;
	assign hlt_en = ~data_ready || ((|enableOut[0:3]) || (val0 | val1 | val2 | val3));
	//sourse decode
	always @(*) begin
		case(datainstr[3:5])
			3'b000:
				instr_sourse_decode = 8'b10000000;
			3'b001:
				instr_sourse_decode = 8'b01000000;
			3'b010:
				instr_sourse_decode = 8'b00100000;
			3'b011:
				instr_sourse_decode = 8'b00010000;
			3'b100:
				instr_sourse_decode = 8'b00001000;
			3'b101:
				instr_sourse_decode = 8'b00000100;
			3'b110:
				instr_sourse_decode = 8'b00000010;
			3'b111:
				instr_sourse_decode = 8'b00000001;
		endcase
	end
	assign enableOut = (jmpInstr && ~data_ready) ? 8'h0 : instr_sourse_decode; //if this jmp instr, output disable


	//type instraction decode
	always @(*) begin
			case(datainstr[0:2])
				3'b000: 
					data_out = in0;
				3'b001:
					data_out = in1;
				3'b010:
					data_out = in2;
				3'b011:
					data_out = in3;
				3'b100:
					data_out = ACC;
				3'b101:
					data_out = datainstr[6:13];
				3'b110:
					data_out = bak;
				3'b111:
					data_out = 8'h0;
			endcase
		end

	always @(*) begin
		case(datainstr[0:2])
			3'b000: 
				data_ready = rrdy0;
			3'b001:
				data_ready = rrdy1;
			3'b010:
				data_ready = rrdy2;
			3'b011:
				data_ready = rrdy3;
			default:
				data_ready = 1'b1;
		endcase
	end
	//response to write from out's port
	always @(posedge clk) begin
		if(~rst_n) begin
			rresp0 <= 1'b0;
			rresp1 <= 1'b0;
			rresp2 <= 1'b0;
			rresp3 <= 1'b0;
		end
		else case(datainstr[0:2])
			3'b000:
				rresp0 <= rrdy0;
			3'b001:
				rresp1 <= rrdy1;
			3'b010:
				rresp2 <= rrdy2;
			3'b011:
				rresp3 <= rrdy3;
			default: begin
				rresp0 <= 1'b0;
				rresp1 <= 1'b0;
				rresp2 <= 1'b0;
				rresp3 <= 1'b0;
			end
		endcase
	end

	//output regs (out0, out1, out2, out3)
	always @(posedge clk) begin
		if(~rst_n) begin
			val0 <= 1'b0;
			out0 <= 'h0;
		end 
		else if(enableOut[0]) begin
			val0 <= 1'b1;
			out0 <= data_out;
		end
		else if(wresp0) 
			val0 <= 1'b0;
	end

	always @(posedge clk) begin
		if(~rst_n) begin
			val1 <= 1'b0;
			out1 <= 'h0;
		end 
		else if(enableOut[1]) begin
			val1 <= 1'b1;
			out1 <= data_out;
		end
		else if(wresp1) 
			val1 <= 1'b0;
	end

	always @(posedge clk) begin
		if(~rst_n) begin
			val2 <= 1'b0;
			out2 <= 'h0;
		end 
		else if(enableOut[2]) begin
			val0 <= 1'b1;
			out2 <= data_out;
		end
		else if(wresp2) 
			val2 <= 1'b0;
	end

	always @(posedge clk) begin
		if(~rst_n) begin
			val3 <= 1'b0;
			out3 <= 'h0;
		end 
		else if(enableOut[3]) begin
			val3 <= 1'b1;
			out3 <= data_out;
		end
		else if(wresp3) 
			val3 <= 1'b0;
	end

	always @(*) begin
		case(SwpinA)
			2'b00:
				ACCdata = data_out; //move
			2'b01:
				ACCdata = ALURes;	//add, sub
			2'b10:
				ACCdata = 8'b0;		//nth
			2'b11:
				ACCdata = bak;		//swp
		endcase
	end

	assign bakdata = SwpinB ? ACC : data_out; //swp or mov to bak?


	assign enableACC = SwpActiveReg ? 1'b1 : enableOut[4]; //swp cmd?
	//assign enablebak = SwpActiveReg ? enBak : enableOut[5];
	assign enablebak = SwpActiveReg ? 1'b1 : enableOut[5];

	always @(posedge clk) begin
		if(~rst_n) begin
			ACC <= 'h0;
		end
		else if(enableACC) begin
			ACC <= ACCdata;
		end
	end
	always @(posedge clk) begin
		if(~rst_n) begin
			bak <= 'h0;
		end
		else if(enablebak) begin
			bak <= bakdata;
		end
	end


	alu #(.N(8))
		alu(
		.X1		(ACC		), 
		.X2		(data_out	), 
		.code	(ALUdesk	), 
		.Y		(ALURes		)
	);
	
	assign ACCond = ACC;
	
endmodule