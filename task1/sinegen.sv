module sinegen #(
    parameter ADDRESS_WIDTH = 8,
              DATA_WIDTH = 8
)(
    // interface signals
    input  logic [ADDRESS_WIDTH - 1 : 0] incr,    // increment for counter
    input  logic clk,      // clock
    input  logic rst,      // reset
    input  logic en,       // enable
    output logic [DATA_WIDTH - 1 : 0] dout    // sine output
);

    logic [ADDRESS_WIDTH - 1 : 0] address;    // interconnect wire

counter myCounter (
    .incr (incr),
    .clk (clk),
    .rst (rst),
    .en (en),
    .count (address)
);

rom myROM (
    .clk (clk),
    .addr (address),
    .dout (dout)
);

endmodule
