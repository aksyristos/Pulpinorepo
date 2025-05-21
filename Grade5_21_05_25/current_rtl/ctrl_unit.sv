module control_unit(
    input  logic            CLK,
    input  logic            RESETn,
    input  logic            wr_n,
    input  logic            display,
    input  logic            clc,
    input  logic            shift,
    input  logic            shift_out,
    input  logic            addr_increment,
    output logic            WRITEn,
    output logic      [4:0] counter,
    output logic     [10:0] ADDR
    );
    
    enum {RESET,CALC,DISPLAY} next_state,curr_state;
    logic [10:0] next_address,curr_address;
    logic [4:0] next_counter,curr_counter;
    
    always_ff @(posedge CLK, negedge RESETn)
    begin
        if(~RESETn)
            begin
            curr_state   <= RESET;
            curr_address <= 11'b0;
            curr_counter <= 5'b0;
            end
        else
            begin
            curr_state   <= next_state;
            curr_address <= next_address;
            curr_counter <= next_counter;
            end
    end
    
    always_comb begin
       WRITEn = 1'b1;
       next_address = curr_address;
       next_counter = curr_counter;
       next_state =curr_state;
       case (curr_state)          
           RESET:begin
                 WRITEn = 1'b0;
                 next_address = curr_address + 1;
                    if (curr_address == 392)begin
                        next_state = CALC;
                        next_address = 11'b0;
                    end
                 end      
           CALC:begin
                   WRITEn = wr_n;
                      if(~wr_n)begin
                         next_address = curr_address + 1;
                      end
                      else if(shift)begin
                         next_counter = curr_counter + 1;
                         if(curr_address == 5'b11100)begin
                         next_counter = 5'b00001;
                         end
                      end 
                      else if(display)begin
                         next_address = 11'b0;
                         next_state = DISPLAY;
                         next_counter = 5'b0;
                      end
                   end      // named value specified 
           DISPLAY:begin
                      WRITEn = 1'b1;
                      if(addr_increment)begin
                         next_address = curr_address + 1;
                      end
                      else if(clc)begin
                         next_address = 11'b0;
                         next_state = CALC;
                      end
                   end     
       endcase
    end
    
    assign counter = curr_counter;
    assign ADDR    = curr_address;
    
endmodule
