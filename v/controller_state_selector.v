module state_selector(input clock
                    , input reset_b
                    , input mux1
                    , input mux2
                    , output reg state);

reg mux1_out;
reg mux2_out;
reg mux3_out;

always@(*)
begin
    case(mux1)
        1'b0: mux1_out = 1'b0;
        1'b1: mux1_out = 1'b1;
    endcase
end

always@(*)
begin
    case(mux2)
        1'b0: mux2_out = 1'b1;
        1'b1: mux2_out = 1'b0;
    endcase
end

always@(*)
begin
    case(state)
        1'b0: mux3_out = mux1_out;
        1'b1: mux3_out = mux2_out;
    endcase
end

always@(posedge clock)
begin
    if(reset_b)
        state <= mux3_out;
    else
        state <= 1'b0;
end

endmodule