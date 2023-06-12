`include ".v"
`default_nettype none
`timescale 1ns/1ps
module testbench;

reg clk;
reg rst_n;


localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

TIS100
    DUT(
    rst_n       (rst_n  ),
	clk         (clk    ),
	in0         (), 
    in1         (),
    in2         (),
    in3         (),
	out0        (),
    out1        (),
    out2        (),
    out3        (),
	Addr_instr  (),
	instr       (),
);

initial begin
    $dumpfile("tb.vcd");
    $dumpvars(0, tb_);
end

initial begin
    #1 rst_n<=1'bx;clk<=1'bx;
    #(CLK_PERIOD*3) rst_n<=1;
    #(CLK_PERIOD*3) rst_n<=0;clk<=0;
    repeat(5) @(posedge clk);
    rst_n<=1;
    @(posedge clk);
    repeat(2) @(posedge clk);
    $finish(2);
end

endmodule
`default_nettype wire