module controller_test;

parameter CLK_PHASE = 5;
reg clock = 0;
reg RUN;
reg reset_b;
wire write_enable;
wire [11:0] write_address;
wire [11:0] read_address;
wire [11:0] Wg_address;
wire BUSY;
wire restart_signal1;
wire restart_signal2;
wire restart_signal3;

initial
begin
#CLK_PHASE
    RUN = 0;
    reset_b = 0;

#CLK_PHASE
    reset_b = 1;

#CLK_PHASE
    RUN = 1;

    wait (BUSY == 1);
    RUN = 0;

    wait (BUSY == 0)
    $finish;
end

always
begin
    #CLK_PHASE clock = ~clock;
end

controller U1(clock, RUN, reset_b, write_enable, write_address, read_address, Wg_address, BUSY, restart_signal1, restart_signal2, restart_signal3);
endmodule