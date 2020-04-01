module result(input clock
            , input [19:0] sum
            , input start_accumulate
            , output reg [19:0] ai);

reg [19:0] mux_out;
 
always@(posedge clock)
begin
    ai <= mux_out;
end

always@(*)
begin
    case(start_accumulate)
        1'b0: mux_out = ai;
        1'b1: mux_out = sum;
    endcase
end

endmodule