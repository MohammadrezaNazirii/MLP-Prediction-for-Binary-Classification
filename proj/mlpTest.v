`timescale 1ns / 1ps


module mlpTest;

	// Inputs
	reg [19:0] inp_1;
	reg [19:0] inp_2;
	reg [19:0] inp_3;
	reg clk;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	MLP uut (
		.inp_1(inp_1), 
		.inp_2(inp_2), 
		.inp_3(inp_3), 
		.clk(clk), 
		.out(out)
	);
	
	always #10 clk = ~clk;

	initial begin
		// Initialize Inputs
		inp_1 = 0;
		inp_2 = 0;
		inp_3 = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		
		
		// Test Number 1: 0.3, 0.1, 0.3 
      inp_1 = 20'b00000100110011001100;
      inp_2 = 20'b00000001100110011001;
      inp_3 = 20'b00000100110011001100;
		
		
		/*
		// Test Number 3: 0.01, 0.2, 0.03 
      inp_1 = 20'b00000000001010001111;
      inp_2 = 20'b00000011001100110011;
      inp_3 = 20'b00000000011110101110;
		*/
		
		
		/*
		// Test Number 4: 0.04, 0.9, 0.003 
      inp_1 = 20'b00000000101000111101;
      inp_2 = 20'b00001110011001100110;
      inp_3 = 20'b00000000000011000100;
		*/
		
		
        
		// Add stimulus here

	end
      
endmodule

