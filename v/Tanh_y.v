module Yunit(input [7:0] address
           , input start_tanh
           , output reg [11:0] y_address);

always@(*)
begin
    case(start_tanh)
    1'b0: y_address = {3'b0, address, 1'b0};
    1'b1: y_address = {3'b0, address + 1, 1'b0};
    endcase
end
endmodule