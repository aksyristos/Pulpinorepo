// Copyright 2017 ETH Zurich and University of Bologna.
// Copyright and related rights are licensed under the Solderpad Hardware
// License, Version 0.51 (the “License”); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
// http://solderpad.org/licenses/SHL-0.51. Unless required by applicable law
// or agreed to in writing, software, hardware and materials distributed under
// this License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR
// CONDITIONS OF ANY KIND, either express or implied. See the License for the
// specific language governing permissions and limitations under the License.

`include "config.sv"

module sp_ram_wrap
  #(
    parameter RAM_SIZE   = 32768,              // in bytes
    parameter ADDR_WIDTH = $clog2(RAM_SIZE),
    parameter DATA_WIDTH = 32
  )(
    // Clock and Reset
    input  logic                    clk,
    input  logic                    rstn_i,
    input  logic                    en_i,
    input  logic [ADDR_WIDTH-1:0]   addr_i,
    input  logic [DATA_WIDTH-1:0]   wdata_i,
    output logic [DATA_WIDTH-1:0]   rdata_o,
    input  logic                    we_i,
    input  logic [DATA_WIDTH/8-1:0] be_i,
    input  logic                    bypass_en_i
  );

 // **4 addressable banks, each with depth 2048**
  localparam BANK_DEPTH = 2048;
  localparam NUM_BYTES = DATA_WIDTH / 8; // Number of 8-bit RAM instances = 4
  localparam BANK_COUNT = RAM_SIZE / BANK_DEPTH / NUM_BYTES; // 32768 / 2048 / 4 = 4

  localparam BYTE_OFFSET = $clog2(NUM_BYTES); // 2 bits for byte selection
  localparam BANK_ADDR_WIDTH = $clog2(BANK_DEPTH); // 11-bit bank addresses

  logic [BANK_ADDR_WIDTH-1:0] word_addr; // Address within a bank
  logic [7:0] rdata [BANK_COUNT-1:0][NUM_BYTES-1:0]; // Read data from each RAM
  logic [7:0] wdata [NUM_BYTES-1:0]; // Byte-wise write data
  logic ready [BANK_COUNT-1:0][NUM_BYTES-1:0]; // Ready signals

  logic [1:0] chip_select; // value inside indicates bank number

  assign word_addr = addr_i[BANK_ADDR_WIDTH+BYTE_OFFSET-1:BYTE_OFFSET]; // Extract bank word address

  // **Decode which bank to enable**
  always_ff@(posedge clk or rstn_i) begin
    if (~rstn_i)
    chip_select <= '1;
    else
    chip_select <= addr_i[ADDR_WIDTH-1:BANK_ADDR_WIDTH+BYTE_OFFSET];
  end
/*
  always_comb begin
    chip_select_next = '1; // Default all banks disabled
    chip_select_next[addr_i[ADDR_WIDTH-1:BANK_ADDR_WIDTH+BYTE_OFFSET]] = en_i; // Enable correct bank
  end



  always @(posedge clk)
  begin
    //if (en_i && we_i)
    //begin
      for (int w = 0; w < NUM_BYTES; w++) begin
        //if (be_i[w])
          wdata[w] = wdata_i[8*w+:8]; // wdata_i[8*w+8-1:w*8] Extract byte from wdata_i
      end
    //end
  end
*/
  // **Byte-wise Write Data Extraction**
  genvar i;
  generate
    for (i = 0; i < NUM_BYTES; i++) begin
      assign wdata[i] = wdata_i[(i+1)*8-1:i*8]; // Extract byte from wdata_i //rdata_o[j*8+8-1:j*8]
    end
  endgenerate


  genvar bank, bYte;
  generate
    for (bank = 0; bank < BANK_COUNT; bank++) begin : bank_loop
      for (bYte = 0; bYte < NUM_BYTES; bYte++) begin : ram_blocks
      ST_SPHDL_2048x8m8_L sp_ram_i (
        .CK        	(clk),
        .CSN  		(~((en_i & we_i & be_i[bYte] & (addr_i[ADDR_WIDTH-1:BANK_ADDR_WIDTH+BYTE_OFFSET] == bank))|((addr_i[ADDR_WIDTH-1:BANK_ADDR_WIDTH+BYTE_OFFSET] == bank) & ~we_i & en_i))), //WRITE condition OR READ condition
	//.CSN		(1'b0),
        .TBYPASS  	(bypass_en_i),        // Assume always 0
        .WEN 		(~(we_i & be_i[bYte] & en_i & (addr_i[ADDR_WIDTH-1:BANK_ADDR_WIDTH+BYTE_OFFSET] == bank))), // Convert active-high we_i to active-low
        .A      	(word_addr),   // Shared word address
        .D            	(wdata[bYte]),    // Individual byte from wdata_i
        .RY        	(ready[bank][bYte]),    // Ready signal (not used in sp_ram)
        .Q           	(rdata[bank][bYte])     // Read data output
      );

      //assign wdata[bYte] = wdata_i[(bYte+1)*8-1:bYte*8]; // Extract byte from wdata_i
      end
    end
  endgenerate

/*
  always_comb begin
    if (~we_i) begin
      for (int i = 0; i < NUM_BYTES; i++) begin
        wdata[i] = wdata_i[i*8+:8];
      end
    end
  end

  // Combine read data from all RAM instances into rdata_o with chip select so that not all ST instances drive at the same time 
always_comb begin
  rdata_o = '0; // Default to zero to avoid latches
  for (int b = 0; b < BANK_COUNT; b++) begin
    //if (~chip_select[addr_i[ADDR_WIDTH-1:BANK_ADDR_WIDTH+BYTE_OFFSET]]) begin
      for (int j = 0; j < NUM_BYTES; j++) begin
        //rdata_o[j*8+:8] = ~chip_select[addr_i[ADDR_WIDTH-1:BANK_ADDR_WIDTH+BYTE_OFFSET]]?rdata[b][j]:8'bz; // ✅ Only selected RAM drives rdata_o WITH CS[B] IT WAS ALWAYS Z NOW IT'S LATCHING AND ILLEGAL
	rdata_o[j*8+:8] = rdata[b][j]; //terminates if always_comb
      end
    //end
  end
end
*/
always_comb begin
  case (chip_select)		//we use chip_select here instead of the macro in ST because we need it for the duration of a period and not as a momentary condition
	2'd0: rdata_o = {rdata[0][3],rdata[0][2],rdata[0][1],rdata[0][0]};
	2'd1: rdata_o = {rdata[1][3],rdata[1][2],rdata[1][1],rdata[1][0]};
	2'd2: rdata_o = {rdata[2][3],rdata[2][2],rdata[2][1],rdata[2][0]};
	2'd3: rdata_o = {rdata[3][3],rdata[3][2],rdata[3][1],rdata[3][0]};
  endcase
end
endmodule

