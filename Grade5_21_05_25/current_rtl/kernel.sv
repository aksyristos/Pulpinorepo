module kernel(
    input  logic            CLK,
    input  logic            RESETn,
    input  logic            shift,
    input  logic     [7:0]  wa,wb,wc, wd,we,wf, wg,wh,wi, in_a, in_b, in_c,
    output logic     [15:0] out_val        
    );
    
    logic [7:0] d_0,q_0, d_1,q_1, d_2,q_2, d_3,q_3, d_4,q_4, d_5,q_5;
    logic [17:0] n0,n1,n2;
    logic [18:0] n3;
    logic [19:0] n4;
    
    always_ff @(posedge CLK, negedge RESETn)
    begin
        if(~RESETn)
            begin
            q_0  <= 8'b0;
            q_1  <= 8'b0;
            q_2  <= 8'b0;
            q_3  <= 8'b0;
            q_4  <= 8'b0;
            q_5  <= 8'b0;
            end
        else
            begin
            q_0  <= d_0;
            q_1  <= d_1;
            q_2  <= d_2;
            q_3  <= d_3;
            q_4  <= d_4;
            q_5  <= d_5;
            end
    end
    
    always_comb begin
       d_0 = q_0;
       d_1 = q_1;
       d_2 = q_2;
       d_3 = q_3;
       d_4 = q_4;
       d_5 = q_5;
       if (shift == 1'b1)
       begin
           d_0 = in_a;
           d_1 = q_0;
           d_2 = in_b;
           d_3 = q_2;
           d_4 = in_c;
           d_5 = q_4;
       end
    end
    
    always_comb begin
       n0 = wc*in_a + wb*q_0 + wa*q_1;
       n1 = wf*in_b + we*q_2 + wd*q_3;
       n2 = wi*in_c + wh*q_4 + wg*q_5;
    end
    
    assign n3 = n0 +n1;
    assign n4 = n3 +n2;
    
    assign out_val = n4[19:4];
    
endmodule
