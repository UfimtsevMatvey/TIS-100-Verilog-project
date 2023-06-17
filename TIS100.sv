`define SIM_TB
module TIS100(
    input wire          rst_n,
	input wire          clk,

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
    output wire         rresp0,
                        rresp1,
                        rresp2,
                        rresp3,

    //write interface
    //write data
	output wire [0:7]   out0, 
                        out1, 
                        out2, 
                        out3,
    //write val
    output wire         val0,
                        val1,
                        val2,
                        val3,
    //write response
    input wire          wresp0,
                        wresp1,
                        wresp2,
                        wresp3,

`ifdef SIM_TB
    input wire [0:17]   instr,
    output wire [0:7]   addr_instr
`endif
);
	wire [0:13]     datainstr;
	wire [0:1]      SwpinA;
	wire            SwpinB;
	wire [0:1]      ALUdesk;
	wire            jmpInstr;
	wire [0:1]      jmpCond;
	//wire            enBak;
`ifndef SIM_TB
	wire [0:17]     instr;
    wire [0:7]      addr_instr;
`endif
	wire [0:7]      jAddr;
	wire [0:7]      ACCond;
	
	//wire [0:4]      instrType;
	wire            SwpActiveReg;
	wire [0:7]      jACC;
	

    wire [0:4] instrType;
    assign instrType = instr[0:4];
	exe_path               
        exe_path0(
        .clk            (clk            ), 
        .rst_n          (rst_n          ), 
        .SwpActiveReg   (SwpActiveReg   ),
        .SwpinA         (SwpinA         ),
        .SwpinB         (SwpinB         ),
		.ALUdesk        (ALUdesk        ), 
        .jmpInstr       (jmpInstr       ), 
        .jmpCond        (jmpCond        ), 
        .instr          (instr          ), 
        .jAddr          (ACCond         ), 

        .in0            (in0            ), 
        .in1            (in1            ), 
        .in2            (in2            ), 
        .in3            (in3            ),  
        .rrdy0          (rrdy0          ),
        .rrdy1          (rrdy1          ),
        .rrdy2          (rrdy2          ),
        .rrdy3          (rrdy3          ),
        .rresp0         (rresp0         ),
        .rresp1         (rresp1         ),
        .rresp2         (rresp2         ),
        .rresp3         (rresp3         ),

        .ACCond         (jACC           ), 
			
        .out0           (out0           ), 
        .out1           (out1           ), 
        .out2           (out2           ), 
        .out3           (out3           ),

        .val0           (val0           ),
        .val1           (val1           ),
        .val2           (val2           ),
        .val3           (val3           ),

        .wresp0         (wresp0         ),
        .wresp1         (wresp1         ),
        .wresp2         (wresp2         ),
        .wresp3         (wresp3         ),

        .Addr_instr     (addr_instr     )
    );

	control_unit    
        control_unit0(
        .clk            (clk            ), 
        .rst_n          (rst_n          ), 
        .instrType      (instrType      ), 
        .jACC           (jACC           ),
        .SwpActiveReg   (SwpActiveReg   ), 
        .SwpinA         (SwpinA         ),
        .SwpinB         (SwpinB         ),
		.ALU_desk       (ALUdesk        ), 
        .jmpInstr       (jmpInstr       ), 
        .jmpCond        (jmpCond        ),
        .outACC         (ACCond         )
    );
`ifndef SIM_TB
	Memory 
        InstractionMemory0(
        .rst_n          (rst_n          ),
        .clk            (clk            ),
        .addr           (addr_instr     ), 
        .data_out       (instr          )
    );
`endif
	
endmodule
