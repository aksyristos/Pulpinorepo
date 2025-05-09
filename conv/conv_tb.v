//convolver_tb.v

`timescale 1ns / 1ps
module convolver_tb;

	// Inputs
	reg clk;
	reg ce;
	reg [71:0] weight1;
	reg global_rst;
	reg [7:0] activation;

	// Outputs
	wire [8:0] conv_op;
	wire end_conv;
	wire valid_conv;
	integer i;
    parameter clkp = 40;
	// Instantiate the Unit Under Test (UUT)
	main_module  uut (
		.clock(clk), 
		.start(ce), 
		.weights(weight1), 
		.reset(global_rst), 
		.activation(activation), 
		.P_out(conv_op), 
		.finish(end_conv)
		//.valid_conv(valid_conv)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		ce = 0;
		weight1 = 0;
		global_rst = 0;
		activation = 0;
		// Wait 100 ns for global reset to finish
		#100;
         	clk = 0;
		ce = 0;
		weight1 = 0;
		activation = 0;
         	global_rst =1;
         	#50;
         	global_rst =0;	
         	#30000;	
		ce=1;
		#50;	
		ce=0;
        //we use the same set of weights and activations as the sample input in the golden model (python code) above.
		weight1 = 71'h08_07_06_05_04_03_02_01_00; 
		for(i=0;i<800;i=i+1) begin
		activation = i%5;
		#clkp; 
		end
	end 
      always #(clkp/2) clk=~clk;      
endmodule
