`timescale 1ns / 1ps

module Main(clk, rst, x_in, y_in, z_in, x_out, y_out, z_out
    );
	 parameter INTEGRAL_WIDTH = 4;
    parameter FRACTION_WIDTH = 16;
	 parameter N = 20;
	 
	 input clk;
	 input rst;
	 input [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] x_in;
    input [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] y_in;
    input [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] z_in;
    output [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] x_out;
    output [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] y_out;
    output [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] z_out;
	 
	 
	 wire[19:0] x [20:0];
	 wire[19:0] y [20:0];
	 wire[19:0] z [20:0];
	 wire[4:0] iteration [20:0];
	 
	 wire[19:0] x_div [20:0];
	 wire[19:0] y_div [20:0];
	 wire[19:0] z_div [20:0];
	 wire[4:0] iteration_div [20:0];
	 
	 assign x[0] = x_in;
	 assign y[0] = y_in;
	 assign z[0] = z_in;
	 assign iteration[0] = 1;
	 assign iteration_div[0] = 0;
	 
	 
	 genvar i;
    generate
		  for (i = 0; i < N; i = i + 1) begin  : sinCordic
		  SinCosCORDIC SinCos (
					.clk(clk), 
					.rst(rst), 
					.x_in(x[i]), 
					.y_in(y[i]), 
					.z_in(z[i]), 
					.iteration_in(iteration[i]), 
					.x_out(x[i+1]), 
					.y_out(y[i+1]), 
					.z_out(z[i+1]), 
					.iteration_out(iteration[i+1])
					);
		  end
	 endgenerate
	 
	 assign x_div[0] = x[19];
	 assign y_div[0] = y[19];
	 assign z_div[0] = 0; //z[19]
	 
	 
	 generate
        for (i = 0; i < N; i = i + 1) begin  : divCordic
            divisionCORDIC division (
					.clk(clk), 
					.rst(rst), 
					.x_in(x_div[i]), 
					.y_in(y_div[i]), 
					.z_in(z_div[i]), 
					.iteration_in(iteration_div[i]), 
					.x_out(x_div[i+1]), 
					.y_out(y_div[i+1]), 
					.z_out(z_div[i+1]), 
					.iteration_out(iteration_div[i+1])
					);
        end
	 endgenerate
	 
	 assign x_out = x_div[19];
	 assign y_out = y_div[19];
	 assign z_out = z_div[19];
	 


endmodule
