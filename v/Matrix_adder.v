module adder(input clock
           , input [16:0] product
           , input start_accumulate
           , output reg [19:0] sum);

reg [19:0] sum_internal;
reg [19:0] mux1_out;

always@(posedge clock)
begin
    sum <= sum_internal;
end

always@(*)
begin
    case(start_accumulate)
        1'b0: mux1_out = sum;
        1'b1: mux1_out = 0;
    endcase
    sum_internal = $signed(product) + $signed(mux1_out);
end

endmodule
