`timescale 1ns / 1ps

module Node5 #(
    parameter INTEGRAL_WIDTH = 4,
    parameter FRACTION_WIDTH = 16,
    parameter WEIGHT_1 = 0,
    parameter WEIGHT_2 = 0,
    parameter WEIGHT_3 = 0,
    parameter WEIGHT_4 = 0,
    parameter WEIGHT_5 = 0
) (
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_1,
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_2,
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_3,
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_4,
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_5,
    input clk,
    output signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out
);
    localparam w_1 = WEIGHT_1;
	localparam w_2 = WEIGHT_2;
	localparam w_3 = WEIGHT_3;
	localparam w_4 = WEIGHT_4;
	localparam w_5 = WEIGHT_5;
	
	wire signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] dotProduct [0 : 7]; 
	 
	wire signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] theta;
	 
	assign dotProduct[0] = w_1 * inp_1;
	assign dotProduct[1] = w_2 * inp_2;
	assign dotProduct[2] = dotProduct[0] + dotProduct[1];
	
	assign dotProduct[3] = w_3 * inp_3;
	assign dotProduct[4] = dotProduct[2] + dotProduct[3];
	assign dotProduct[5] = w_4 * inp_4;
	assign dotProduct[6] = dotProduct[4] + dotProduct[5];
	assign dotProduct[7] = w_5 * inp_5;
	 
	assign theta = dotProduct[6] + dotProduct[7];
	 
	 
	wire [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] x_out;
	wire [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] y_out;
	 
	 
	Main activation (
    .clk(clk), 
    .rst(0), 
    .x_in(20'b00010000000000000000), 
    .y_in(20'b00000000000000000000), 
    .z_in(theta), 
    .x_out(x_out), 
    .y_out(y_out), 
    .z_out(out)
    );
    

endmodule