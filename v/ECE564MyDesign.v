//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// DUT




module ECE564MyDesign
	    (

            //---------------------------------------------------------------------------
            // Control
            //
            input  wire               xxx__dut__run            ,             
            output wire               dut__xxx__busy           , // high when computing
            input  wire               clk                      ,
            input  wire               reset_b                  ,

            //--------------------------------------------------------------------------- 
            //---------------------------------------------------------------------------
            // SRAM interface
            //
            output wire [11:0]        dut__sram__write_address  ,
            output wire [15:0]        dut__sram__write_data     ,
            output wire               dut__sram__write_enable   ,
            output wire [11:0]        dut__sram__read_address   ,
            input  wire [15:0]        sram__dut__read_data      ,
            
            //---------------------------------------------------------------------------
            // g memory interface
            //
            output wire [11:0]        dut__gmem__read_address   ,
            input  wire [15:0]        gmem__dut__read_data      ,  // read data

            //---------------------------------------------------------------------------
            // Tanh look up table tanhmem 
            //
            output wire [11:0]        dut__tanhmem__read_address     ,
            input  wire [15:0]        tanhmem__dut__read_data           // read data

            );

  //---------------------------------------------------------------------------
  //
  //<<<<----  YOUR CODE HERE    ---->>>>

  wire start_accumulate;
  wire start_tanh;
  wire start_interpolation;
  wire [19:0] ai;

  controller U1(.clock(clk), .RUN(xxx__dut__run), .reset_b(reset_b), .write_enable(dut__sram__write_enable), .write_address(dut__sram__write_address), .read_address(dut__sram__read_address), .Wg_address(dut__gmem__read_address), .BUSY(dut__xxx__busy), .start_accumulate(start_accumulate), .start_tanh(start_tanh), .start_interpolation(start_interpolation));
  matrix U2(.clock(clk), .start_accumulate(start_accumulate), .Weightg(gmem__dut__read_data), .Xt(sram__dut__read_data), .ai(ai));
  functionG U3(.clock(clk), .ai(ai), .y(tanhmem__dut__read_data), .start_tanh(start_tanh), .start_interpolation(start_interpolation), .y_address(dut__tanhmem__read_address), .write_data_in(dut__sram__write_data));
endmodule

