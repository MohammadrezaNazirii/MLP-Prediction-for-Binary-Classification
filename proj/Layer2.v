`timescale 1ns / 1ps

module Layer2 #(
    parameter INTEGRAL_WIDTH = 4,
    parameter FRACTION_WIDTH = 16
) (
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_1,
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_2,
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_3,
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_4,
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_5,
    input clk,
    output signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_1,
    output signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_2,
    output signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_3
);


    wire signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_node [0 : 2];
    Node5 #(
        .INTEGRAL_WIDTH(INTEGRAL_WIDTH),
        .FRACTION_WIDTH(FRACTION_WIDTH),
        .WEIGHT_1(20'b00000100110011001100),//+0.3
		.WEIGHT_2(20'b11111100110011001101),//-0.2
		.WEIGHT_3(20'b00001000000000000000),//+0.5
		.WEIGHT_4(20'b11110110011001100111),//-0.6
		.WEIGHT_5(20'b00000110011001100110)//+0.4
    ) node_1 (
		.inp_1(inp_1), 
		.inp_2(inp_2), 
		.inp_3(inp_3),
		.inp_4(inp_4),
		.inp_5(inp_5),
		.clk(clk), 
		.out(out_node[0])
	);

    Node5 #(
        .INTEGRAL_WIDTH(INTEGRAL_WIDTH),
        .FRACTION_WIDTH(FRACTION_WIDTH),
        .WEIGHT_1(20'b11110100110011001101),//-0.7
		.WEIGHT_2(20'b00001001100110011001),//+0.6
		.WEIGHT_3(20'b11111110011001100111),//-0.1
		.WEIGHT_4(20'b00000011001100110011),//+0.2
		.WEIGHT_5(20'b11110011001100110100)//-0.8
    ) node_2 (
		.inp_1(inp_1), 
		.inp_2(inp_2), 
		.inp_3(inp_3),
		.inp_4(inp_4),
		.inp_5(inp_5),
		.clk(clk), 
		.out(out_node[1])
	);
	
    Node5 #(
        .INTEGRAL_WIDTH(INTEGRAL_WIDTH),
        .FRACTION_WIDTH(FRACTION_WIDTH),
        .WEIGHT_1(20'b00000110011001100110),//+0.4
		.WEIGHT_2(20'b11111000000000000000),//-0.5
		.WEIGHT_3(20'b00001100110011001100),//+0.8
		.WEIGHT_4(20'b11110001100110011010),//-0.9
		.WEIGHT_5(20'b00001011001100110011)//+0.7
    ) node_3 (
		.inp_1(inp_1), 
		.inp_2(inp_2), 
		.inp_3(inp_3),
		.inp_4(inp_4),
		.inp_5(inp_5), 
		.clk(clk), 
		.out(out_node[2])
	);
	
    assign out_1 = out_node[0];
	assign out_2 = out_node[1];
	assign out_3 = out_node[2];
  
endmodule
