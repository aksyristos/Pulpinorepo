module result_register(
    input  logic            CLK,
    input  logic            RESETn,
    input  logic            shift_out,
    input  logic     [15:0] res_a,res_b,
    output logic     [31:0] to_sram   
    );
    
    logic [31:0] d_res,q_res;
    
    always_ff @(posedge CLK, negedge RESETn)
    begin
        if(~RESETn)
            begin
            q_res <= 32'b0;
            end
        else
            begin
            q_res <= d_res;
            end
    end
    
    always_comb begin
       d_res <= q_res;
       if (shift_out == 1'b1)
       begin
          d_res <= {res_a ,res_b};
       end
    end
    
    assign to_sram = q_res;
    
endmodule
