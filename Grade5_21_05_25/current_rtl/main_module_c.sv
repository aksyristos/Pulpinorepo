module main_module_c(
    input  logic            CLK,
    input  logic            RESETn,
    input  logic     [7:0]  wa,wb,wc, wd,we,wf, wg,wh,wi, in1, in2, in3, in4,
    input  logic            W,
    input  logic            EN,
    input  logic            SEL,
    input  logic     [2:0]  rel_addr,
    input  logic            pwdt0,
    output logic            final_shift,
    output logic     [31:0] two_results
    );
    
    logic shift,WRITEn,ry,shift_out,wr_n,display,clc,addr_increment;
    logic  [4:0] counter;
    logic [15:0] outa,outb;
    logic [10:0] address;
    logic [31:0] WDATA;
    
    kernel
    first
    (
    .CLK      (CLK   ),
    .RESETn   (RESETn),
    .shift    (shift ),
    .wa       (wa    ),
    .wb       (wb    ),
    .wc       (wc    ),
    .wd       (wd    ),
    .we       (we    ),
    .wf       (wf    ),
    .wg       (wg    ),
    .wh       (wh    ),
    .wi       (wi    ),
    .in_a     (in1   ),
    .in_b     (in2   ),
    .in_c     (in3   ),
    .out_val  (outa  )
    );
    
    kernel
    second
    (
    .CLK      (CLK   ),
    .RESETn   (RESETn),
    .shift    (shift ),
    .wa       (wa    ),
    .wb       (wb    ),
    .wc       (wc    ),
    .wd       (wd    ),
    .we       (we    ),
    .wf       (wf    ),
    .wg       (wg    ),
    .wh       (wh    ),
    .wi       (wi    ),
    .in_a     (in2   ),
    .in_b     (in3   ),
    .in_c     (in4   ),
    .out_val  (outb  )
    );
    
    result_register
    before_sram
    (
    .CLK      (CLK   ),
    .RESETn   (RESETn),
    .shift_out(shift_out ),
    .res_a    (outa  ),
    .res_b    (outb  ),
    .to_sram  (WDATA )
    );
    
    wrapper_sram
    sram
    (
    .CLK      (CLK    ),
    .WRITEn   (WRITEn ),
    .WDATA    (WDATA  ),
    .ADDR     (address),
    .RDATA    (two_results),
    .READY       (ry)
    );
    
    control_signals
    gen_signals
    (
    .CLK      (CLK   ),
    .RESETn   (RESETn),
    .W        (W      ),
    .EN       (EN     ),
    .SEL      (SEL    ),
    .rel_addr (rel_addr),
    .pwdt0    (pwdt0  ),
    .counter  (counter),
    .shift    (shift  ),
    .shift_out(shift_out),
    .wr_n     (wr_n   ),
    .display  (display),
    .clc  (clc),
    .final_shift (final_shift),
    .addr_increment (addr_increment)
    );
    
    control_unit
    fsm
    (
    .CLK      (CLK   ),
    .RESETn   (RESETn),
    .wr_n     (wr_n   ),
    .display  (display),
    .clc  (clc),
    .shift    (shift  ),
    .shift_out(shift_out),
    .addr_increment (addr_increment),
    .WRITEn   (WRITEn ),
    .ADDR     (address),
    .counter   (counter)
    );
    
endmodule
