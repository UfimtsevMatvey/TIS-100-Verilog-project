	module Memory(
		input wire [0:7] A,
		output wire [0:17] RD
	);
		reg [0:17] mem [0:25];
		initial begin
			$readmemb("rom_files/rom_init.txt", mem);
		end
		assign RD = mem[A];
	endmodule
	module neg_Reg(
		input wire clk, enable, reset,
		input wire [0:7] data,
		output wire [0:7] out_data
		);
		reg [0:7] out_data_0;
		always @(negedge clk)
		begin
			if(enable)
				out_data_0 <= data;
			if(reset)
				out_data_0 <= 8'h0;
				
		end
		assign out_data = out_data_0;
	endmodule
	
	module pos_Reg(
		input wire clk, enable, reset,
		input wire [0:7] data,
		output wire [0:7] out_data
		);
		reg [0:7] out_data_0;
		always @(posedge clk)
		begin
			if(enable)
				out_data_0 <= data;
			if(reset)
				out_data_0 <= 8'h0;
				
		end
		assign out_data = out_data_0;
	endmodule