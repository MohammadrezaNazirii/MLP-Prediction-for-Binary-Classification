`timescale 1ns / 1ps

module divisionCORDIC(clk, rst, x_in, y_in, z_in, iteration_in, x_out, y_out, z_out, iteration_out
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
	 
	 wire d_wire = y_in[INTEGRAL_WIDTH + FRACTION_WIDTH - 1];
	 
	 reg [INTEGRAL_WIDTH + FRACTION_WIDTH - 1:0] reciprocal_table [19:0];
	
	 initial begin
        reciprocal_table[0]  = 20'h10000; // 1 / 2^0 in Q4.12 format // 1 / 2^0 in Q4.12 format // 1 / 2^0 in fixed point
        reciprocal_table[1]  = 20'h08000; // 1 / 2^0 in Q4.12 format // 1 / 2^0 in fixed point
        reciprocal_table[2]  = 20'h04000; // 1 / 2^1 // 1 / 2^1
        reciprocal_table[3]  = 20'h02000; // 1 / 2^2 // 1 / 2^2
        reciprocal_table[4]  = 20'h01000; // 1 / 2^3 // 1 / 2^3
        reciprocal_table[5]  = 20'h00800; // 1 / 2^4 // 1 / 2^4
        reciprocal_table[6]  = 20'h00400; // 1 / 2^5 // 1 / 2^5
        reciprocal_table[7]  = 20'h00200; // 1 / 2^6 // 1 / 2^6
        reciprocal_table[8]  = 20'h00100; // 1 / 2^7 // 1 / 2^7
        reciprocal_table[9]  = 20'h00080; // 1 / 2^8 // 1 / 2^8
        reciprocal_table[10] = 20'h00040; // 1 / 2^9 // 1 / 2^9
        reciprocal_table[11] = 20'h00020; // 1 / 2^10 // 1 / 2^10
        reciprocal_table[12] = 20'h00010; // 1 / 2^11 // 1 / 2^11
        reciprocal_table[13] = 20'h00008; // 1 / 2^12 // 1 / 2^12
        reciprocal_table[14] = 20'h00004; // 1 / 2^13 // 1 / 2^13
        reciprocal_table[15] = 20'h00002; // 1 / 2^14 // 1 / 2^14
		  reciprocal_table[16] = 20'h00001;
		  reciprocal_table[17] = 20'h00000;
		  reciprocal_table[18] = 20'h00000;
		  reciprocal_table[19] = 20'h00000;
    end

	 
	 always @(posedge clk, posedge rst) begin
        if (rst) begin
            x_out <= x_in;
            y_out <= y_in;
            z_out <= z_in;
        end
        else begin
				x_out <= x_in;
				y_out <= (d_wire) ? (y_in + (x_in >>>(iteration_in))) : (y_in - (x_in>>>(iteration_in)));
				z_out <= (d_wire) ? (z_in - reciprocal_table[iteration_in]) : (z_in + reciprocal_table[iteration_in]);
				iteration_out <= iteration_in + 1;
        end
    end


endmodule
