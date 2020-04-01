module complement_19bit(a, a_complement);

input [18:0] a;
output wire [18:0] a_complement;

assign a_complement = {1'b1, 19'b0} - a;

endmodule