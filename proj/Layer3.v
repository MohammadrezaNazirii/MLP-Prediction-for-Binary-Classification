`timescale 1ns / 1ps

module Layer3 #(
    parameter INTEGRAL_WIDTH = 4,
    parameter FRACTION_WIDTH = 16
) (
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_1,
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_2,
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_3,
    input clk,
    output signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_1
);

    wire signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_node_1;
    Node3 #(
        .INTEGRAL_WIDTH(INTEGRAL_WIDTH),
        .FRACTION_WIDTH(FRACTION_WIDTH),
        .WEIGHT_1(20'b00000001100110011001),//+0.1
		.WEIGHT_2(20'b11111011001100110100),//-0.3
		.WEIGHT_3(20'b00000011001100110011)//+0.2
    ) node_1 (
		.inp_1(inp_1), 
		.inp_2(inp_1), 
		.inp_3(inp_3), 
		.clk(clk), 
		.out(out_node_1)
	);
	
	assign out_1 = out_node_1;
    
endmodule