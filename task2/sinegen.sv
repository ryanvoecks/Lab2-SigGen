module sinegen #(
    parameter ADDRESS_WIDTH = 8,
              DATA_WIDTH = 8
)(
    // interface signals
    input  logic [ADDRESS_WIDTH - 1 : 0] incr,    // increment for counter
    input  logic clk,      // clock
    input  logic rst,      // reset
    input  logic en,       // enable
    input  logic [ADDRESS_WIDTH - 1 : 0] offset,  // offset of address 2 from address 1
    output logic [DATA_WIDTH - 1 : 0] dout1,   // sine wave 1
    output logic [DATA_WIDTH - 1 : 0] dout2    // sine wave 2
);

    logic [ADDRESS_WIDTH - 1 : 0] addr1;    // address 1 wire
    logic [ADDRESS_WIDTH - 1 : 0] addr2;    // address 2 wire

    assign addr2 = addr1 + offset;

counter myCounter (
    .incr (incr),
    .clk (clk),
    .rst (rst),
    .en (en),
    .count (addr1)
);

dualport_rom #(
    .ADDRESS_WIDTH (ADDRESS_WIDTH), .DATA_WIDTH (DATA_WIDTH)
) myROM (
    .clk (clk),
    .addr1 (addr1),
    .addr2 (addr2),
    .dout1 (dout1),
    .dout2 (dout2)
);

endmodule
