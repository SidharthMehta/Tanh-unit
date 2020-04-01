module mux4_1(input [15:0] s1
            , input [15:0] s2
            , input [15:0] s3
            , input [15:0] s4
            , input c1
            , input c2
            , output reg [15:0] mux_out);

always@(*)
begin
    case({c1,c2})
    2'b00: mux_out = s1;
    2'b01: mux_out = s2;
    2'b10: mux_out = s3;
    2'b11: mux_out = s4;
    endcase
end
endmodule