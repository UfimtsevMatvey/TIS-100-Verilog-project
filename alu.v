module alu #(parameter N = 8)(
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