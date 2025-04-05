`timescale 1ns / 1ps

module MLP #(
    parameter INTEGRAL_WIDTH = 4,
    parameter FRACTION_WIDTH = 16
) (
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_1,
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_2,
    input signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] inp_3,
    input clk,
    output out
);

    wire signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_layer_1 [0 : 4];
    Layer1 #(
        .INTEGRAL_WIDTH(INTEGRAL_WIDTH),
        .FRACTION_WIDTH(FRACTION_WIDTH)
    ) layer_1 (
        .inp_1(inp_1),
        .inp_2(inp_2),
        .inp_3(inp_3),
        .clk(clk),
        .out_1(out_layer_1[0]),
        .out_2(out_layer_1[1]),
        .out_3(out_layer_1[2]),
        .out_4(out_layer_1[3]),
        .out_5(out_layer_1[4])
    );
    
    wire signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_layer_2 [0 : 2];
    Layer2 #(
        .INTEGRAL_WIDTH(INTEGRAL_WIDTH),
        .FRACTION_WIDTH(FRACTION_WIDTH)
    ) layer_2 (
        .inp_1(out_layer_1[0]),
        .inp_2(out_layer_1[1]),
        .inp_3(out_layer_1[2]),
        .inp_4(out_layer_1[3]),
        .inp_5(out_layer_1[4]),
        .clk(clk),
        .out_1(out_layer_2[0]),
        .out_2(out_layer_2[1]),
        .out_3(out_layer_2[2])
    );
    
    wire signed [INTEGRAL_WIDTH + FRACTION_WIDTH - 1 : 0] out_layer_3;
    Layer3 #(
        .INTEGRAL_WIDTH(INTEGRAL_WIDTH),
        .FRACTION_WIDTH(FRACTION_WIDTH)
    ) layer_3 (
        .inp_1(out_layer_2[0]),
        .inp_2(out_layer_2[1]),
        .inp_3(out_layer_2[2]),
        .clk(clk),
        .out_1(out_layer_3)
    );
    
    reg temp;
	 
	always @(posedge clk) begin
	   if (out_layer_3 > 20'sb0) begin//20'sb0
	       temp <= 1;
	       $display("%b", out_layer_3);
	   end
	   else begin
	       temp <= 0;
			 $display("%b", out_layer_3);
	       $display("Still Zero!");
	   end
	end
	
	
	assign out = temp;
    
endmodule
