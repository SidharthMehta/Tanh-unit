module complement_9bit(a, a_complement);

input [8:0] a;
output wire [9:0] a_complement;

assign a_complement = {1'b1, 9'b0} - {1'b0, a};

endmodule