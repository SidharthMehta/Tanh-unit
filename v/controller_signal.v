module signal(input enable
            , input [12:0] count
            , output wire write_enable
            , output wire [11:0] write_address
            , output wire [11:0] read_address
            , output wire [11:0] Wg_address
            , output wire start_accumulate
            , output wire start_tanh
            , output wire start_interpolation
            , output wire state_mux
            , output wire BUSY);

assign write_enable = (|count[12:4]) && (count[3:0] == 4'd9);
assign write_address = {2'h1, (count[11:4]- 1'h1), 1'h0};
assign read_address = {2'h0, count[11:8], count[3:0], 1'h0};
assign Wg_address = {7'h0, count[7:0], 1'h0};
assign start_accumulate = count[3:0] == 4'd3;
assign start_tanh = count[3:0] == 4'd4;
assign start_interpolation = count[3:0] == 4'd7;
assign state_mux = (count[12] == 1'd1) && (count[3:0] == 4'd10);
assign BUSY = enable;

endmodule