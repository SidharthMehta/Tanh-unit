// synopsys translate_off
`include "/afs/eos.ncsu.edu/dist/synopsys_apps/syn_vP-2019.03-SP1/dw/sim_ver/DW02_mult_3_stage.v"
//synopsys translate_on

module Tan_multiplier(clock, a, b, product);

parameter awidth = 10;
parameter bwidth = 10;
parameter pwidth = 20;

input clock;
input [awidth-1:0] a;
input [bwidth-1:0] b;
output wire [16:0] product;
wire [pwidth-1:0] product_internal;

assign product = product_internal[18:2];

DW02_mult_3_stage #(awidth, bwidth) U1(.A(a), .B(b), .TC(1'b0), .CLK(clock), .PRODUCT(product_internal));

endmodule