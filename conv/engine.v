//file: convolver.v
`timescale 1ns / 1ps

module convolver #(
parameter n = 9'h01c,     // activation map size
parameter k = 9'h003,     // kernel size 
parameter s = 1,          // value of stride (horizontal and vertical stride are equal)
parameter N = 8,         //total bit width
parameter Q = 0          //number of fractional bits in case of fixed point representation.
)(
input clk,
input ce,
input global_rst,
input [N-1:0] activation,
input [(k*k)*N-1:0] weight1,
output[10 + N-1:0] conv_op,
output valid_conv,
output end_conv
);
    
    
wire [17:0] tmp [k*k+1:0];
wire [7:0] weight [0:k*k-1];

parameter  IDLE=0,  PIPE_FILL=1,  PROCESS_ROW=2,  ROW_WRAP=3,  DONE=4;

reg [2:0] state, next_state;
reg [$clog2(n):0] row_idx, col_idx, wrapc;
reg [$clog2(n):0] nrow, ncol, nwrap;
reg [7:0] count, ncount;


//breaking our weights into separate variables. We are forced to do this because verilog does not allow us to pass multi-dimensional 
//arrays as parameters
//----------------------------------------------------------------------------------------------------------------------------------
generate
	genvar l;
	for(l=0;l<k*k;l=l+1)
	begin
        assign weight [l][N-1:0] = weight1[N*l +: N]; 		
	end	
endgenerate
//----------------------------------------------------------------------------------------------------------------------------------
assign tmp[0] = 32'h0000000;
    
//The following generate loop enables us to lay out any number of MAC units specified during the synthesis, without having to commit to a //fixed size 
generate
genvar i;
  for(i = 0;i<k*k;i=i+1)
  begin: MAC
    if((i+1)%k ==0)                       //end of the row
    begin
      if(i==k*k-1)                        //end of convolver
      begin
      (* use_dsp = "yes" *)               //this line is optional depending on tool behaviour
      mac_manual #(.N(N),.Q(Q)) mac(      //implements a*b+c
        .clk(clk),                        // input clk
        .sclr(global_rst),                // input sclr
        .a(activation),                   // activation input [15 : 0] a
        .b(weight[i]),                    // weight input [15 : 0] b
        .c(tmp[i]),                       // previous mac sum input [32 : 0] c
        .p(conv_op)                       // output [32 : 0] p
        );
      end
      else
      begin
      wire [N-1:0] tmp2;
      //make a mac unit
      (* use_dsp = "yes" *)               //this line is optional depending on tool behaviour
      mac_manual #(.N(N),.Q(Q)) mac(                   
        .clk(clk), 
        .sclr(global_rst), 
        .a(activation), 
        .b(weight[i]), 
        .c(tmp[i]), 
        .p(tmp2) 
        );
      
      variable_shift_reg #(.WIDTH(10+N),.SIZE(n-k)) SR (
          .d(tmp2),                  // input [32 : 0] d
          .clk(clk),                 // input clk                   // input ce
          .rst(global_rst),          // input rst
          .out(tmp[i+1])             // output [32 : 0] q
          );
      end
    end
    else
    begin
    (* use_dsp = "yes" *)               //this line is optional depending on tool behaviour
   mac_manual #(.N(N),.Q(Q)) mac2(                    
      .clk(clk), 
      .sclr(global_rst),
      .a(activation),
      .b(weight[i]),
      .c(tmp[i]), 
      .p(tmp[i+1])
      );
    end 
  end 
endgenerate

always @(posedge clk or posedge global_rst) begin
  if(global_rst) begin
    state <= IDLE;
    row_idx <= 0;
    col_idx <= 0;
    wrapc <= 0;
    count <= 0;
  end else begin
    state <= next_state;
    row_idx <= nrow;
    col_idx <= ncol;
    wrapc <= nwrap;
    count <= ncount;
  end
end

always @(*) begin
  // default values
  next_state = state;
  nrow <= row_idx;
  ncol <= col_idx;
  nwrap <= wrapc;
  ncount <= count;
  case(state)
    IDLE: begin
      if (ce)
        next_state = PIPE_FILL;
    end

    PIPE_FILL: begin
      if (count > (k - 1) * n + k - 3 ) begin
        next_state = PROCESS_ROW;
        ncount <= 0;
      end else begin
        next_state = PIPE_FILL;
        ncount <= count + 1;
      end
    end

    PROCESS_ROW: begin
      if (col_idx == n-k) begin
        if (row_idx == n-k) begin    
            next_state = DONE;
            nrow <= 0;
            ncol <= 0;
        end else begin
            nrow <= row_idx + 1;
            next_state = ROW_WRAP;
            ncol <= 0;
        end
      end else begin
        next_state = PROCESS_ROW;
        ncol <= col_idx + 1;
      end
    end

    ROW_WRAP: begin
      if (wrapc == k-2) begin
        next_state = PROCESS_ROW;
        nwrap <= 0; 
      end else begin
        next_state = ROW_WRAP;
        nwrap <= wrapc + 1;
      end
    end

    DONE: begin
      next_state = IDLE; 
    end
  endcase
end

assign valid_conv = (state == PROCESS_ROW) && (row_idx % s == 0) && (col_idx % s == 0);
assign end_conv = (state == DONE);
endmodule
