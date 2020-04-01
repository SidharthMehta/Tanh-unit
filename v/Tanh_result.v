module tanh_result(input clock
                 , input start_interpolation
                 , input [16:0] product
                 , output wire [15:0] tanh_result);

reg [16:0] interpolation;
reg [16:0] interpolation_internal;
reg [16:0] mux_out;

always@(posedge clock)
begin
    interpolation <= interpolation_internal;
end

always@(*)
begin
    case(start_interpolation)
    1'b0: mux_out = interpolation;
    1'b1: mux_out = 0;
    endcase
    interpolation_internal = product + mux_out;
end

assign tanh_result[15:0] = interpolation[16:1];

endmodule