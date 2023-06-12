module Memory(
	input wire 			rst_n;
	input wire 			clk,
	input wire [0:7] 	addr,
	output wire [0:17] 	data_out
	);
	reg [0:17] data;
	reg [0:17] mem [0:25];
`ifdef SIM
	initial begin
		$readmemb("rom_files/rom_init.txt", mem);
	end
`endif
	always @(posedge clk)
		if(~rst_n)	
			data <= 'h0;
		else
			data <= mem[A];

	assign data_out = data;
endmodule