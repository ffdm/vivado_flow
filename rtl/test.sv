module test (
  input wire sys_clk_p,
  input wire sys_clk_n,
  output wire led
);

wire sys_clk;
IBUFGDS osc_clk(.O(sys_clk), .I(sys_clk_p), .IB(sys_clk_n));

reg [28:0] counter = 0;

always_ff @(posedge sys_clk) begin
  counter <= counter + 1;
end

assign led = counter[28];

endmodule
