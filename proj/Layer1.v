`timescale 1ns / 1ps

module Layer1 #(
    parameter INTEGRAL_WIDTH = 4,
    parameter FRACTION_WIDTH = 16
) (
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_1,
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_2,
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_3,
    input clk,
    output signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_1,
    output signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_2,
    output signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_3,
    output signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_4,
    output signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_5
);


	 

    wire signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_node [0 : 4];
    Node3 #(
        .INTEGRAL_WIDTH(INTEGRAL_WIDTH),
        .FRACTION_WIDTH(FRACTION_WIDTH),
        .WEIGHT_1(20'b00000011001100110011),//+0.2
		.WEIGHT_2(20'b11111001100110011010),//-0.4
		.WEIGHT_3(20'b00000001100110011001)//+0.1
    ) node_1 (
		.inp_1(inp_1), 
		.inp_2(inp_2), 
		.inp_3(inp_3), 
		.clk(clk), 
		.out(out_node[0])
	);
	
    Node3 #(
        .INTEGRAL_WIDTH(INTEGRAL_WIDTH),
        .FRACTION_WIDTH(FRACTION_WIDTH),
        .WEIGHT_1(20'b11111000000000000000),//-0.5
		.WEIGHT_2(20'b00001011001100110011),//+0.7
		.WEIGHT_3(20'b11110110011001100111)//-0.6
    ) node_2 (
		.inp_1(inp_1), 
		.inp_2(inp_2), 
		.inp_3(inp_3), 
		.clk(clk), 
		.out(out_node[1])
	);
	
    Node3 #(
        .INTEGRAL_WIDTH(INTEGRAL_WIDTH),
        .FRACTION_WIDTH(FRACTION_WIDTH),
        .WEIGHT_1(20'b00001100110011001100),//+0.8
		.WEIGHT_2(20'b11111110011001100111),//-0.1
		.WEIGHT_3(20'b00000100110011001100)//+0.3
    ) node_3 (
		.inp_1(inp_1), 
		.inp_2(inp_2), 
		.inp_3(inp_3), 
		.clk(clk), 
		.out(out_node[2])
	);
	
    Node3 #(
        .INTEGRAL_WIDTH(INTEGRAL_WIDTH),
        .FRACTION_WIDTH(FRACTION_WIDTH),
        .WEIGHT_1(20'b11111011001100110100),//-0.3
		.WEIGHT_2(20'b00001110011001100110),//+0.9
		.WEIGHT_3(20'b11110011001100110100)//-0.8
    ) node_4 (
		.inp_1(inp_1), 
		.inp_2(inp_2), 
		.inp_3(inp_3), 
		.clk(clk), 
		.out(out_node[3])
	);
	
    Node3 #(
        .INTEGRAL_WIDTH(INTEGRAL_WIDTH),
        .FRACTION_WIDTH(FRACTION_WIDTH),
        .WEIGHT_1(20'b00001001100110011001),//+0.6
		.WEIGHT_2(20'b11111100110011001101),//-0.2
		.WEIGHT_3(20'b00001000000000000000)//+0.5
    ) node_5 (
		.inp_1(inp_1), 
		.inp_2(inp_2), 
		.inp_3(inp_3), 
		.clk(clk), 
		.out(out_node[4])
	);
	
	/*
	always @(out_node[4]) begin
	   $display("In L1: %b, %b, %b, %b", out_node[0], out_node[1], out_node[2], out_node[3]);
	end
	*/
	
	assign out_1 = out_node[0];
	assign out_2 = out_node[1];
	assign out_3 = out_node[2];
	assign out_4 = out_node[3];
	assign out_5 = out_node[4];
    
endmodule
