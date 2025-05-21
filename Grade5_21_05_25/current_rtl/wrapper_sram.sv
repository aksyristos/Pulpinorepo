module wrapper_sram(
    input  logic                      CLK,
    input  logic                      WRITEn,
    input  logic               [31:0] WDATA,
    input  logic               [10:0] ADDR,
    output logic               [31:0] RDATA,
    output logic                      READY
    );
    
    ST_SPHS_2048x32m8_L
    DUT_ST_SPHS_2048x32m8_mem2015
    (
        .CK      (CLK   ),
        .CSN     (1'b0  ),
        .WEN     (WRITEn),
        .D       (WDATA ),
        .A       (ADDR  ),
        .TBYPASS (1'b0  ),
        .Q       (RDATA ),
        .RY      (READY )
    );
    
endmodule
