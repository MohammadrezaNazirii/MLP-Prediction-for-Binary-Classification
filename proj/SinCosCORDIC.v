`timescale 1ns / 1ps

module SinCosCORDIC(clk, rst, x_in, y_in, z_in, iteration_in, x_out, y_out, z_out, iteration_out
    );

parameter INTEGRAL_WIDTH = 4;
    parameter FRACTION_WIDTH = 16;
	 
	 input clk;
	 input rst;
	 input [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] x_in;
    input [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] y_in;
    input [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] z_in;
	 input [4:0] iteration_in;
    output reg [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] x_out;
    output reg [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] y_out;
    output reg [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] z_out;
	 output reg [4:0] iteration_out;
	 
	 wire d_wire = z_in[INTEGRAL_WIDTH + FRACTION_WIDTH - 1];
	 
	 reg [3:0] k_table [19:0];
	 reg [INTEGRAL_WIDTH + FRACTION_WIDTH - 1:0] w_table [19:0];
	
	 initial begin
        w_table[0]  = 20'b00001000110010011111;
        w_table[1]  = 20'b00000100000101100010; 
        w_table[2]  = 20'b00000010000000101011;
        w_table[3]  = 20'b00000001000000000101;
        w_table[4]  = 20'b00000000100000000000;
        w_table[5]  = 20'b00000000010000000000;
        w_table[6]  = 20'b00000000001000000000;
        w_table[7]  = 20'b00000000000100000000;
        w_table[8]  = 20'b00000000000010000000;
        w_table[9]  = 20'b00000000000001000000;
        w_table[10] = 20'b00000000000000100000;
        w_table[11] = 20'b00000000000000010000;
        w_table[12] = 20'b00000000000000001000;
        w_table[13] = 20'b00000000000000000100;
        w_table[14] = 20'b00000000000000000010;
        w_table[15] = 20'b00000000000000000001;
		  w_table[16] = 20'b00000000000000000000;
		  w_table[17] = 20'b00000000000000000000;
		  w_table[18] = 20'b00000000000000000000;
		  w_table[19] = 20'b00000000000000000000;
    end
	 

	 
	 
	 wire [3:0] temp = ((k_table[iteration_in]) - iteration_in);
	 reg[4:0] n_shift;

	 
	 always @(posedge clk, posedge rst) begin
        if (rst) begin
            x_out <= x_in;
            y_out <= y_in;
            z_out <= 0;
        end
        else begin
				if (iteration_in <= 4)
					n_shift = iteration_in;
				else if (iteration_in <= 14)
					n_shift = iteration_in - 1;
				else
					n_shift = iteration_in - 2;
				
				x_out <= (d_wire) ? (x_in - (y_in >> n_shift)) : (x_in + (y_in >> n_shift));
				y_out <= (d_wire) ? (y_in - (x_in >> n_shift)) : (y_in + (x_in >> n_shift));
				z_out <= (d_wire) ? (z_in + w_table[n_shift-1]) : (z_in - w_table[n_shift-1]);
				iteration_out <= iteration_in + 1;
        end
    end

endmodule
