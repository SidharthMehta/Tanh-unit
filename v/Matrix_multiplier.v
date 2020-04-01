// synopsys translate_off
`include "/afs/eos.ncsu.edu/dist/synopsys_apps/syn_vP-2019.03-SP1/dw/sim_ver/DW02_mult_3_stage.v"
//synopsys translate_on

module multiplier(clock, a, b, product);

parameter awidth = 13;
parameter bwidth = 13;
parameter pwidth = 17;

input clock;
input [awidth-1:0] a;
input [bwidth-1:0] b;
output wire [pwidth-1:0] product;
wire [awidth+bwidth-1:0] internal_product;

assign product = internal_product[awidth+bwidth-1:awidth+bwidth-pwidth];

DW02_mult_3_stage #(awidth, bwidth) U1(.A(a), .B(b), .TC(1'b1), .CLK(clock), .PRODUCT(internal_product));

endmodule