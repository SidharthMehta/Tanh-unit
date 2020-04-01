module controller(input clock
                , input RUN
                , input reset_b
                , output wire write_enable
                , output wire [11:0] write_address
                , output wire [11:0] read_address
                , output wire [11:0] Wg_address
                , output wire BUSY
                , output wire start_accumulate
                , output wire start_tanh
                , output wire start_interpolation);

wire [12:0] count;
wire enable;
wire mux2;

state_selector U1(.clock(clock), .reset_b(reset_b), .mux1(RUN), .mux2(mux2), .state(enable));
counter U2(.clock(clock), .enable(enable), .count(count));
signal U3(.enable(enable), .count(count), .write_enable(write_enable), .write_address(write_address), .read_address(read_address), .Wg_address(Wg_address), .start_accumulate(start_accumulate), .start_tanh(start_tanh), .start_interpolation(start_interpolation), .state_mux(mux2), .BUSY(BUSY));

endmodule