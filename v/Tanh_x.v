module Xunit(input clock
           , input [9:0] x0
           , input [9:0] x1
           , input start_tanh
           , output reg [9:0] x_difference);

always@(posedge clock)
begin
    case(start_tanh)
    1'b0: x_difference <= x1;
    1'b1: x_difference <= x0;
    endcase
end

endmodule