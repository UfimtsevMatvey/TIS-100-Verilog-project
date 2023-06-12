`define SIM_TB
//`define TEST_MOV
`define TEST_ALU

`timescale 1ns/1ps
module testbench;

reg clk;
reg rst_n;
wire [0:17] instr;
wire [0:7]  addr_instr;
core_intf intf(
    .clk    (clk    ),
    .rst_n  (rst_n  )
);

localparam CLK_PERIOD = 1ns;

initial begin
    clk <= 0;
    forever #CLK_PERIOD clk <= ~clk;
end


TIS100 DUT(
    .rst_n       (intf.rst_n),
	.clk         (intf.clk  ),
	.in0         (intf.in0  ), 
    .in1         (intf.in1  ),
    .in2         (intf.in2  ),
    .in3         (intf.in3  ),
	.out0        (intf.out0 ),
    .out1        (intf.out1 ),
    .out2        (intf.out2 ),
    .out3        (intf.out3 ),
`ifdef SIM_TB
    .instr      (instr      ),
    .addr_instr (addr_instr )
`endif
);


`ifdef TEST_MOV
test_move_gen test(
    .rst_n      (intf.rst_n ),
    .clk        (intf.clk   ),
    .in0        (intf.out0  ),
    .in1        (intf.out1  ),
    .in2        (intf.out2  ),
    .in3        (intf.out3  ),

    .out0       (intf.in0   ),
    .out1       (intf.in1   ),
    .out2       (intf.in2   ),
    .out3       (intf.in3   ),

    .instr      (instr      ),
    .addr_instr (addr_instr )
);
`endif

`ifdef TEST_ALU
test_alu_gen test(
    .rst_n      (intf.rst_n ),
    .clk        (intf.clk   ),
    .in0        (intf.out0  ),
    .in1        (intf.out1  ),
    .in2        (intf.out2  ),
    .in3        (intf.out3  ),

    .out0       (intf.in0   ),
    .out1       (intf.in1   ),
    .out2       (intf.in2   ),
    .out3       (intf.in3   ),

    .instr      (instr      ),
    .addr_instr (addr_instr )
);
`endif

initial $dumpvars;


initial begin
    #1 rst_n<=1'b0;

    #9.5
    @(posedge clk) rst_n<=1'b1;


    #10000 $finish();
end

endmodule