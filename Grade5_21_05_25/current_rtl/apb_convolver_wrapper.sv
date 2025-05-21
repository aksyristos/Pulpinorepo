module apb_timer(
    input  logic                      HCLK,
    input  logic                      HRESETn,
    input  logic               [11:0] PADDR,
    input  logic               [31:0] PWDATA,
    input  logic                      PWRITE,
    input  logic                      PSEL,
    input  logic                      PENABLE,
    output logic               [31:0] PRDATA,
    output logic                      PREADY,
    output logic                      PSLVERR,
    output logic               [3:0]  irq_o 
    );
    logic final_shift;
    logic [2:0]   rel_addr;
    assign rel_addr = PADDR[4:2];
    
    assign PREADY  = 1'b1;
    assign PSLVERR = 1'b0;
    assign irq_o   = 4'b0;
    
    logic [31:0] dw1, qw1, dw2, qw2, dw3, qw3, d_inp, q_inp, d_out, q_out, two_results;
    
        always_ff @(posedge HCLK, negedge HRESETn)
    begin
        if(~HRESETn)
            begin
            qw1    <= 32'b0;
            qw2    <= 32'b0;
            qw3    <= 32'b0;
            q_inp  <= 32'b0;
            q_out  <= 32'b0;
            end
        else
            begin
            qw1    <= dw1  ;
            qw2    <= dw2  ;
            qw3    <= dw3  ;
            q_inp  <= d_inp;
            q_out  <= d_out;
            end
    end
    
    always_comb 
    begin
       PRDATA = 32'b0;
       if (PSEL && PENABLE && !PWRITE)
        begin
            case (rel_addr)
                3'b000:
                    PRDATA = qw1;

                3'b001:
                    PRDATA = qw2;

                3'b010:
                    PRDATA = qw3;
                    
                3'b011:
                    PRDATA = q_inp;
                
                3'b101:
                    PRDATA = q_out;
            endcase
        end
    end
    
    always_comb 
    begin
           dw1 = qw1;
           dw2 = qw2;
           dw3 = qw3;
           d_inp = q_inp;
       if (PSEL && PENABLE && PWRITE)
        begin
            case (rel_addr)
                3'b000:
                    dw1 = PWDATA;

                3'b001:
                    dw2 = PWDATA;

                3'b010:
                    dw3 = PWDATA;
                    
                3'b011:
                    d_inp = PWDATA;
            endcase
        end
    end
    
    always_comb 
    begin
       d_out = q_out;
           if(final_shift)begin
              d_out =  two_results;
           end
    end
    
    main_module_c
    convolver
    (
    .CLK      (HCLK   ),
    .RESETn   (HRESETn),
    .wa       (qw1[23:16]),
    .wb       (qw1[15:8] ),
    .wc       (qw1[7:0]  ),
    .wd       (qw2[23:16]),
    .we       (qw2[15:8] ),
    .wf       (qw2[7:0]  ),
    .wg       (qw3[23:16]),
    .wh       (qw3[15:8] ),
    .wi       (qw3[7:0]  ),
    .in1      (q_inp[31:24]),
    .in2      (q_inp[23:16]),
    .in3      (q_inp[15:8]),
    .in4      (q_inp[8:0]),
    .W        (PWRITE   ),
    .EN       (PENABLE  ),
    .SEL      (PSEL     ),
    .rel_addr (rel_addr ),
    .pwdt0    (PWDATA[0]),
    .final_shift (final_shift),
    .two_results(two_results)
    );
    
endmodule
