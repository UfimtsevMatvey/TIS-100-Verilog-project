module Adder #(parameter N = 8)(
	input wire [0:N-1] X1, X2,
	output wire [0:N-1] Y
	);
	assign Y = X1 + X2;
endmodule

module mux2_1 #(parameter N = 8) (
	input wire Control,
	input wire [0:N - 1] X1, X2,
	output wire [0:N - 1] Y
);
	assign Y = Control ? X2 : X1;
endmodule

module mux4_1 #(parameter N = 8) (
	input wire [0:1] Control,
	input wire [0:N - 1] X1, X2, X3, X4,
	output reg [0:N - 1] Y
);
	always @(*) begin
		case(Control)
			2'b00:
			Y = X1;
			2'b01:
			Y = X2;
			2'b10:
			Y = X3;
			2'b11:
			Y = X4;
		endcase
	end
	
endmodule
module mux8_1 #(parameter N = 8) (
	input wire [0:2] Control,
	input wire [0:N - 1] X1, X2, X3, X4, X5, X6, X7, X8,
	output reg [0:N - 1] Y
);
	always @(*) begin
		case(Control)
			3'b000:
			Y = X1;
			3'b001:
			Y = X2;
			3'b010:
			Y = X3;
			3'b011:
			Y = X4;
			3'b100:
			Y = X5;
			3'b101:
			Y = X6;
			3'b110:
			Y = X7;
			3'b111:
			Y = X8;
		endcase
	end
	
endmodule
module decode1_8(
	input wire [0:2] Control,
	output reg [0:7] Y
);
	always @(*) begin
		case(Control)
			3'b000:
			Y = 8'b10000000;
			3'b001:
			Y = 8'b01000000;
			3'b010:
			Y = 8'b00100000;
			3'b011:
			Y = 8'b00010000;
			3'b100:
			Y = 8'b00001000;
			3'b101:
			Y = 8'b00000100;
			3'b110:
			Y = 8'b00000010;
			3'b111:
			Y = 8'b00000001;
		endcase
	end
endmodule

module ALU #(parameter N = 8)(
	input wire [0:N - 1] X1, X2,
	input wire [0:1] code,
	output reg [0:N - 1] Y
);
	always @(*) begin
		case(code)
			2'b01:
				Y = X1 + X2;
			2'b10:
				Y = X1 - X2;
			2'b11:
				Y = -X1;
			default:
				Y = 0;
		endcase
	end

endmodule
