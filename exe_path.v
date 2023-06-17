module exe_path(
	input wire 			rst_n,
	input wire 			clk,
	input wire 			SwpActiveReg,
	input wire [0:1] 	SwpinA,
	input wire 			SwpinB,
	//input wire 			enBak,
	input wire [0:1] 	ALUdesk,
	input wire 			jmpInstr,
	input wire [0:1] 	jmpCond,
	input wire [0:17] 	instr,
	input wire [0:7] 	jAddr,
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


	output wire [0:7] 	ACCond,
	output wire [0:7] 	Addr_instr
);
	wire [0:13] datainstr;
	assign datainstr = instr[4:17]; //cut instr type
	wire hlt_en;
	data_path 
		data_path(
		.clk			(clk			), 
		.rst_n			(rst_n			), 
		.SwpActiveReg	(SwpActiveReg	), 
		.SwpinA			(SwpinA			), 
		.SwpinB			(SwpinB			),
		//.enBak			(enBak			), 
		.ALUdesk		(ALUdesk		), 
		.jmpInstr		(jmpInstr		),
		.datainstr		(datainstr		), 
		.hlt_en			(hlt_en			),

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

		.ACCond			(ACCond			)
	);

	jmp_path 
		jmp(
		.clk			(clk			), 
		.rst_n			(rst_n			),
		.jmpCond		(jmpCond		),
		.jmpInstr		(jmpInstr		), 
		.instr			(instr			), 
		.jAddr			(jAddr			), 
		.Addr_instr		(Addr_instr		),
		.hlt_en			(hlt_en			)
	);
endmodule