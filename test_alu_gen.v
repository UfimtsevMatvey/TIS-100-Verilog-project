`define NOP             18'b1111_111_111_11111111
`define MOVE_IN0_ACC    18'b0000_000_100_00000000
`define ADD_IN1         18'b0011_001_100_00000000
`define ADD_IN2         18'b0011_010_100_00000000
`define SUB_IN3         18'b0010_011_100_00000000
`define MOVE_ACC_OUT0   18'b0000_100_000_00000000
module test_alu_gen(
    input               rst_n,
    input               clk,

    input  [0:7]        in0,
                        in1,
                        in2,
                        in3,
    output reg [0:7]    out0,
                        out1,
                        out2,
                        out3,
    
    output reg [0:17]   instr,
    input  [0:7]        addr_instr
);

    always @(posedge clk) begin
        if(~rst_n) begin
            instr <= `NOP;
            out0 <= 'hff;
            out1 <= 'hff;
            out2 <= 'hff;
            out3 <= 'hff;
        end
        else begin
            case(instr)
                `NOP: begin
                    instr <= `MOVE_IN0_ACC;
                    out0 <= 8'h1;
                end
                `MOVE_IN0_ACC: begin
                    instr <= `ADD_IN1;
                    out1 <= 8'h2;
                end
                `ADD_IN1: begin
                    instr <= `ADD_IN2;
                    out2 <= 8'h3;
                end
                `ADD_IN2: begin
                    instr <= `SUB_IN3;
                    out3 <= 8'h4;
                end
                `SUB_IN3: begin
                    instr <= `MOVE_ACC_OUT0;
                end
                `MOVE_ACC_OUT0: begin
                    instr <= `NOP;
                end
                default: begin
                    instr <= `NOP;
                end
            endcase
        end
    end
endmodule