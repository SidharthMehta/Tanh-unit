module mux2_1(input [18:0] s1
            , input [18:0] s2
            , input c
            , output reg [18:0] mux_out);

always@(*)
begin
    case(c)
    1'b0: mux_out = s1;
    1'b1: mux_out = s2;
    endcase
end
endmodule