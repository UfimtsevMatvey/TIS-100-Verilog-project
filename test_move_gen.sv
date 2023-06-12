module test_move_gen(
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
        out0 <= 'h0f;
        out1 <= 'h1f;
        out2 <= 'h2f;
        out3 <= 'h3f;
    end
    else begin
        {out3[0:1], out2[0:1], out1[0:1], out0[0:1]} <= {out3[0:1], out2[0:1], out1[0:1], out0[0:1]} + 8'h1;
    end
end

// mov in0, out0
always @(posedge clk) begin
    if(~rst_n)
        instr <= 'h0;
    else 
        {instr[5:6], instr[8:9]} <= {instr[5:6], instr[8:9]} + 'h1;
end


//check
reg [0:17]  instr_r;
reg [0:7]   out0_r,
            out1_r,
            out2_r,
            out3_r;

reg [0:7]   in0_r,
            in1_r,
            in2_r,
            in3_r;

always @(posedge clk)
    if(~rst_n)
        instr_r <= 'h0;
    else
        instr_r <= instr;
always @(posedge clk) begin
    if(~rst_n) begin
        out0_r <= 'h0;
        out1_r <= 'h0;
        out2_r <= 'h0;
        out3_r <= 'h0;    
    end
    else begin
        out0_r <= out0;
        out1_r <= out1;
        out2_r <= out2;
        out3_r <= out3;
    end
end
always @(*) begin
    in0_r = in0;
    in1_r = in1;
    in2_r = in2;
    in3_r = in3;
end

//move check
always @(posedge clk) begin
    if(rst_n && (instr_r[0:3] == 4'h0))
    case(instr_r[4:6])
        3'b000:
            case(instr_r[7:9])
                3'b000: 
                    if(in0_r == out0_r) $display("test passed\n");
                    else begin
                        $display("in0 = 0x%0h, out0 = 0x%0h, error\n", in0_r, out0_r);
                        $finish;
                    end
                3'b001:
                    if(in1_r == out0_r) $display("test passed\n");
                    else begin
                        $display("in1 = 0x%0h, out0 = 0x%0h, error\n", in1_r, out0_r);
                        $finish;
                    end
                3'b010:
                    if(in2_r == out0_r) $display("test passed\n");
                    else $display("in2 = 0x%0h, out0 = 0x%0h, error\n", in2_r, out0_r);
                3'b011:
                    if(in3_r == out0_r) $display("test passed\n");
                    else begin
                        $display("in3 = 0x%0h, out0 = 0x%0h, error\n", in3_r, out0_r);
                        $finish;
                    end
            endcase
        3'b001:
            case(instr_r[7:9])
                3'b000: 
                    if(in0_r == out1_r) $display("test passed\n");
                    else begin
                        $display("in0 = 0x%0h, out1 = 0x%0h, error\n", in0_r, out1_r);
                        $finish;
                    end
                3'b001:
                    if(in1_r == out1_r) $display("test passed\n");
                    else begin
                        $display("in1 = 0x%0h, out1 = 0x%0h, error\n", in1_r, out1_r);
                        $finish;
                    end
                3'b010:
                    if(in2_r == out1_r) $display("test passed\n");
                    else begin
                        $display("in2 = 0x%0h, out1 = 0x%0h, error\n", in2_r, out1_r);
                        $finish;
                    end
                3'b011:
                    if(in3_r == out1_r) $display("test passed\n");
                    else begin
                        $display("in3 = 0x%0h, out1 = 0x%0h, error\n", in3_r, out1_r);
                        $finish;
                    end
            endcase
        3'b010:
            case(instr_r[7:9])
                3'b000: 
                    if(in0_r == out2_r) $display("test passed\n");
                    else begin
                        $display("in0 = 0x%0h, out2 = 0x%0h, error\n", in0_r, out2_r);
                        $finish;
                    end
                3'b001:
                    if(in1_r == out2_r) $display("test passed\n");
                    else begin
                        $display("in1 = 0x%0h, out2 = 0x%0h, error\n", in1_r, out2_r);
                        $finish;
                    end
                3'b010:
                    if(in2_r == out2_r) $display("test passed\n");
                    else begin
                        $display("in2 = 0x%0h, out2 = 0x%0h, error\n", in2_r, out2_r);
                        $finish;
                    end
                3'b011:
                    if(in3_r == out2_r) $display("test passed\n");
                    else begin
                        $display("in3 = 0x%0h, out2 = 0x%0h, error\n", in3_r, out2_r);
                        $finish;
                    end
            endcase
        3'b011:
            case(instr_r[7:9])
                3'b000: 
                    if(in0_r == out3_r) $display("test passed\n");
                    else begin
                        $display("in0 = 0x%0h, out3 = 0x%0h, error\n", in0_r, out3_r);
                        $finish;
                    end
                3'b001:
                    if(in1_r == out3_r) $display("test passed\n");
                    else begin
                        $display("in1 = 0x%0h, out3 = 0x%0h, error\n", in1_r, out3_r);
                        $finish;
                    end
                3'b010:
                    if(in2_r == out3_r) $display("test passed\n");
                    else begin
                        $display("in2 = 0x%0h, out3 = 0x%0h, error\n", in2_r, out3_r);
                        $finish;
                    end
                3'b011:
                    if(in3_r == out3_r) $display("test passed\n");
                    else begin
                        $display("in3 = 0x%0h, out3 = 0x%0h, error\n", in3_r, out3_r);
                        $finish;
                    end
            endcase
    endcase
end
endmodule