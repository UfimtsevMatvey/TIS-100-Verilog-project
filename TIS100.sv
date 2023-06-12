`define SIM_TB
module TIS100(
    input wire          rst_n,
	input wire          clk,
	input wire [0:7]    in0, 
                        in1, 
                        in2, 
                        in3,
	output wire [0:7]   out0, 
                        out1, 
                        out2, 
                        out3,
    
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
        .clk            (clk     ), 
        .rst_n          (rst_n   ), 
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
        .ACCond         (jACC           ), 
			
        .out0           (out0           ), 
        .out1           (out1           ), 
        .out2           (out2           ), 
        .out3           (out3           ), 
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
