module functionG(input clock
               , input [19:0] ai
               , input [15:0] y
               , input start_tanh
               , input start_interpolation
               , output wire [11:0] y_address
               , output wire [15:0] write_data_in);

parameter tanh_max = 16'sd32767;
parameter tanh_min = -16'sd32768;
wire [18:0] a_mod;
wire [18:0] ai_internal;
wire [15:0] tanh_result;
wire [15:0] tanh_result_mod;
wire c1;

complement_19bit U1(.a(ai[18:0]),.a_complement(ai_internal));
mux2_1 U2(.s1(ai[18:0]), .s2(ai_internal), .c(ai[19]), .mux_out(a_mod));
tanh U3(.clock(clock), .a_mod(a_mod[16:0]), .y(y), .y_address(y_address), .start_tanh(start_tanh), .start_interpolation(start_interpolation), .tanh_result(tanh_result));
complement_16bit U4(.a(tanh_result[15:0]),.a_complement(tanh_result_mod));
c1_logic U5(.a(a_mod[18]), .b(a_mod[17]), .c(a_mod[16:9]), .c1(c1));
mux4_1 U6(.s1(tanh_result), .s2(tanh_result_mod), .s3(tanh_max), .s4(tanh_min), .c1(c1), .c2(ai[19]), .mux_out(write_data_in));

endmodule