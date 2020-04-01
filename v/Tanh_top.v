module tanh(input clock
          , input [16:0] a_mod
          , input [15:0] y
          , output wire [11:0] y_address
          , input start_tanh
          , input start_interpolation
          , output wire [15:0] tanh_result);

wire [9:0] x1;
wire [9:0] x_difference;
wire [16:0] product;

Yunit U1(.address(a_mod[16:9]), .start_tanh(start_tanh), .y_address(y_address));

complement_9bit U2(.a(a_mod[8:0]), .a_complement(x1));
Xunit U3(.clock(clock), .x0({1'b0, a_mod[8:0]}), .x1(x1), .start_tanh(start_tanh), .x_difference(x_difference));

Tan_multiplier U4(.clock(clock), .a(x_difference[9:0]), .b(y[15:6]), .product(product));

tanh_result U5(.clock(clock), .start_interpolation(start_interpolation), .product(product), .tanh_result(tanh_result));

endmodule