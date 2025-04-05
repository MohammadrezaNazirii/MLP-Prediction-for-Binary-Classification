`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:47:13 02/02/2025
// Design Name:   Main
// Module Name:   C:/Users/Mohammadreza/Desktop/final/FPGAproject/division_test.v
// Project Name:  FPGAproject
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Main
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module division_test;

	// Inputs
	reg clk;
	reg rst;
	reg [19:0] x_in;
	reg [19:0] y_in;
	reg [19:0] z_in;

	// Outputs
	wire [19:0] x_out;
	wire [19:0] y_out;
	wire [19:0] z_out;

	// Instantiate the Unit Under Test (UUT)
	Main uut (
		.clk(clk), 
		.rst(rst), 
		.x_in(x_in), 
		.y_in(y_in), 
		.z_in(z_in), 
		.x_out(x_out), 
		.y_out(y_out), 
		.z_out(z_out)
	);
	
	always #10 clk = ~clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 1;
		
		#99;
		
		rst = 0;
		#50
		x_in = 20'b00100100000000000000;
		y_in = 20'b01001000000000000000;
		z_in = 20'b00000000000000000000;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

