module sigdelay #(
    parameter ADDRESS_WIDTH = 9,
              DATA_WIDTH = 8
)(
    input logic  clk,
    input logic  rst,
    input logic  count_incr,
    input logic  count_en,
    input logic  wr,
    input logic  rd,
    input logic  [ADDRESS_WIDTH - 1 : 0] offset,
    input logic  [DATA_WIDTH - 1    : 0] mic_signal,
    output logic [DATA_WIDTH - 1    : 0] delayed_signal
);

logic [ADDRESS_WIDTH - 1 : 0] wr_addr;
logic [ADDRESS_WIDTH - 1 : 0] rd_addr;
assign rd_addr = wr_addr - offset;

counter #(
    .WIDTH(ADDRESS_WIDTH)
) counter512 (
    .incr (count_incr),
    .clk (clk),
    .rst (rst),
    .en (count_en),
    .count (wr_addr)
);

dualport_ram #(
    .ADDRESS_WIDTH(ADDRESS_WIDTH),
    .DATA_WIDTH(DATA_WIDTH)
) ram512x8 (
    .clk (clk),
    .wr_en (wr),
    .rd_en (rd),
    .wr_addr (wr_addr),
    .rd_addr (rd_addr),
    .din (mic_signal),
    .dout (delayed_signal)
);

endmodule
