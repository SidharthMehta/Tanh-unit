module counter(input clock
             , input enable
             , output reg [12:0] count);

always@(posedge clock)
begin
    case(enable)
        1'b0: count <= 0;
        1'b1: count <= count+1;
    endcase
end

endmodule