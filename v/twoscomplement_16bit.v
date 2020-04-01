module complement_16bit(a, a_complement);

input [15:0] a;
output wire [15:0] a_complement;

assign a_complement = {1'b1, 16'b0} - a;

endmodule