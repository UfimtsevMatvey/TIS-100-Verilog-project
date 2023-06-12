interface core_intf (
        input logic clk,
        input logic rst_n
    );

    logic [0:7] in0,
                in1,
                in2,
                in3;
    logic [7:0] out0,
                out1,
                out2,
                out3;
    modport data_in (
    input           clk,
    input           rst_n,
    input           in0,
                    in1,
                    in2,
                    in3,
    output          out0,
                    out1,
                    out2,
                    out3
    );
    modport data_out (
    input           clk,
    input           rst_n,
    output           in0,
                    in1,
                    in2,
                    in3,
    input           out0,
                    out1,
                    out2,
                    out3   
    );
endinterface