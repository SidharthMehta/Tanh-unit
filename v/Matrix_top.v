module matrix(input clock
            , input start_accumulate
            , input [15:0] Weightg
            , input [15:0] Xt
            , output wire [19:0] ai);

wire [16:0] product;
wire [19:0] sum;

multiplier U1(.clock(clock), .a(Weightg[15:3]), .b(Xt[15:3]), .product(product));
adder U2(.clock(clock), .product(product), .start_accumulate(start_accumulate), .sum(sum));
result U3(.clock(clock), .sum(sum), .start_accumulate(start_accumulate), .ai(ai));

endmodule