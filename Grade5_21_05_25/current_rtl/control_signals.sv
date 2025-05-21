module control_signals(
    input  logic            CLK,
    input  logic            RESETn,
    input  logic            W,
    input  logic            EN,
    input  logic            SEL,
    input  logic     [2:0]  rel_addr,
    input  logic            pwdt0,
    input  logic     [4:0]  counter,
    output  logic           shift,
    output  logic           shift_out,
    output  logic           wr_n,
    output  logic           display,
    output  logic           clc,
    output  logic           final_shift,
    output  logic           addr_increment
    );
    
    logic wensel,shift_sig,shift_out_sig;
    logic d_0,q_0, d_1,q_1, d_2,q_2, d_3,q_3, d_4,q_4;
    assign wensel = W & EN & SEL;
    
    always_ff @(posedge CLK, negedge RESETn)
    begin
        if(~RESETn)
            begin
            q_0  <= 1'b0;
            q_1  <= 1'b0;
            q_2  <= 1'b0;
            q_3  <= 1'b0;
            q_4  <= 1'b0;
            end
        else
            begin
            q_0  <= d_0;
            q_1  <= d_1;
            q_2  <= d_2;
            q_3  <= d_3;
            q_4  <= d_4;
            end
    end
    
    always_comb begin
       display = 1'b0;
       clc = 1'b0;
       if (wensel && (rel_addr == 3'b100))
       begin
           if(pwdt0)begin
            display = 1'b1;
            end
        else begin
            clc = 1'b1;
            end
       end
    end
    
    always_comb begin
       d_3 = rel_addr[2];
       d_4 = q_3;
       d_0 = shift_sig;
       d_1 = q_0;
       d_2 = shift_out_sig;
       final_shift = q_4;
       shift = shift_sig;
       shift_out = shift_out_sig;
       wr_n = ~q_2;
    end
    
    always_comb begin
       shift_sig = 1'b0;
       if (wensel && (rel_addr == 3'b011)) begin
          shift_sig = 1'b1;
       end
    end
    
    always_comb begin
       shift_out_sig = 1'b0;
       if (q_1 && ((counter >= 5'b00011)&&(counter <= 5'b11100))) begin
          shift_out_sig = 1'b1;
       end
    end
    
    always_comb begin
       addr_increment = 1'b0;
       if ((!W) && EN && SEL && (rel_addr[2])) begin
          addr_increment = 1'b1;
       end
    end
    
endmodule
