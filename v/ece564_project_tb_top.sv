//----------------------------------------------------------------------------------------------------
// To run simulation
//
// vlog -sv ece564_project_tb_top.v
// vsim -c -do "run -all" tb_top
//




// synopsys translate_off
/*
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_cmp.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_cmp_DG.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_mult.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_mac.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_dp2.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_fp_ifp_conv.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_ifp_fp_conv.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_ifp_mult.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW_ifp_addsub.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW02_mult_5_stage.v"
`include "/afs/eos.ncsu.edu/dist/synopsys2013/syn/dw/sim_ver/DW01_addsub.v"
*/

//synopsys translate_on
//
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// Tesbench
// - instantiate the DUT and testbench
`include "ECE564MyDesign.v"
`include "sram.sv"
module tb_top();


  parameter CLK_PHASE=5  ;
  parameter ROUND=3 ;
  parameter VALID=8 ;//how many bits to be compared 
  parameter sf = 2.0**-15.0; //scaling factor 
  parameter error_tolerance = 0.0078; 
  //--------------------------------------------------------------------------
  //statistic data
  //
  time computeCycle[ROUND];
  event computeStart[ROUND];
  event computeEnd[ROUND];
  event checkFinish[ROUND];
  time startTime[ROUND];
  time endTime[ROUND];
  int correctGnumber[ROUND];
  int correctGnumber_abs[ROUND];
  int correctCnumber[ROUND];
  reg [15:0] gresult_array[int];

  reg [15:0] golden_gresult_array[256];

  int i;
  int j;
  int k;
  int q;
  int p;
 
  //---------------------------------------------------------------------------
  // General
  //
  reg                                   clk                  ;
  reg                                   reset_b              ;
  reg                                   xxx__dut__run        ;
  wire                                  dut__xxx__busy       ;


  //--------------------------------------------------------------------------
  //----------------------io_sram---------------------------------------------
  wire                                     dut__sram__write_enable  ;
  wire [11:0]                              dut__sram__write_address ;
  wire [15:0]                              dut__sram__write_data    ;
  wire [11:0]                              dut__sram__read_address  ;
  wire [15:0]                              sram__dut__read_data     ;
  //------------------weights and bias-----------------------------------------                                          
  wire [11:0]                              dut__gmem__read_address    ;
  wire [15:0]                              gmem__dut__read_data       ;  // read data
  //-----------------------Tanh LUT--------------------------------------------
  wire [11:0]                              dut__tanhmem__read_address ;
  wire [15:0]                              tanhmem__dut__read_data    ;   // read data


                                       



  //---------------------------------------------------------------------------
  //---------------------------------------------------------------------------
  //---------------------------------------------------------------------------
  //SRAM
  
  sram  #(.ADDR_WIDTH    (12),
          .DATA_WIDTH    (16),
          .MEM_INIT_FILE ("sram.dat"           ))
          xmem_mem  (
          .write_enable ( dut__sram__write_enable  ),
          .write_address( dut__sram__write_address ),
          .write_data   ( dut__sram__write_data    ), 
          .read_address ( dut__sram__read_address  ),
          .read_data    ( sram__dut__read_data     ), 
          .clock        ( clk                      )
         );

  //---------------------------------------------------------------------------
  //ROMs
         
  //sram for g weights and bias
  sram  #(.ADDR_WIDTH    (12),
          .DATA_WIDTH    (16),
          .MEM_INIT_FILE ("g.dat"           ))
          gmem_mem  (
          .write_enable ( 1'b0                     ),
          .write_address( 12'b0                    ),
          .write_data   ( 16'b0                    ), 
          .read_address ( dut__gmem__read_address  ),
          .read_data    ( gmem__dut__read_data     ), 
          .clock        ( clk                      )
         );

         
  //sram for tanh weights and bias
  sram  #(.ADDR_WIDTH    (12),
          .DATA_WIDTH    (16),
          .MEM_INIT_FILE ("tanh.dat"           ))
          tanhmem_mem  (
          .write_enable ( 1'b0                     ),
          .write_address( 12'b0                    ),
          .write_data   ( 16'b0                    ), 
          .read_address ( dut__tanhmem__read_address  ),
          .read_data    ( tanhmem__dut__read_data     ), 
          .clock        ( clk                      )
         );

//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// DUT 
  ECE564MyDesign dut(
//---------------------------------------------------------------------------
//Control signals
          .xxx__dut__run             ( xxx__dut__run               ), 
          .dut__xxx__busy            ( dut__xxx__busy              ),
          .reset_b                     ( reset_b                       ),  
          .clk                       ( clk                         ),
 
//---------------------------------------------------------------------------
//SRAM interface
          .dut__sram__write_address  ( dut__sram__write_address    ),
          .dut__sram__write_data     ( dut__sram__write_data       ),
          .dut__sram__write_enable   ( dut__sram__write_enable     ),
          .dut__sram__read_address   ( dut__sram__read_address     ),
          .sram__dut__read_data      ( sram__dut__read_data        ),

//---------------------------------------------------------------------------
//weights and biases interface                                                       

          .dut__gmem__read_address    ( dut__gmem__read_address    ),
          .gmem__dut__read_data       ( gmem__dut__read_data       ),

          .dut__tanhmem__read_address ( dut__tanhmem__read_address ),
          .tanhmem__dut__read_data    ( tanhmem__dut__read_data    )

         );
         
  //---------------------------------------------------------------------------
  //------------------------------
  // Testbench
  //

  //---------------------------------------------------------------------------
  //  clk
  initial 
    begin
        clk                     = 1'b0;
        forever # CLK_PHASE clk = ~clk;
    end
  



  //---------------------------------------------------------------------------
  //---------------------------------------------------------------------------
  // Stimulus
  initial begin
      for(p=0;p<ROUND;p=p+1) begin
        correctGnumber[p]=0;
        correctGnumber_abs[p]=0;
        correctCnumber[p]=0;
      end
      $display("-------------------------------start_simulation-------------------------------\n");
      tanhmem_mem.loadInitFile("tanh.dat");
      repeat(10) @(posedge clk); 
      reset_b=0;
      xxx__dut__run=0;
      repeat(10) @(posedge clk);
      reset_b=1;
      for(j=0;j<ROUND;j=j+1) begin
         if(j!=0) wait(checkFinish[j-1]);
         xmem_mem.loadInitFile($sformatf("input_and_output_%0d/sram.dat",j));
         gmem_mem.loadInitFile($sformatf("input_and_output_%0d/g.dat",j));

         repeat(5) @(posedge clk);
         wait(dut__xxx__busy==0);
         @(posedge clk);
         xxx__dut__run=1;
         ->computeStart[j];
         $display("-------------------------------Round %0d start-------------------------------\n",j);
 	wait(dut__xxx__busy==0);
         @(posedge clk);
         xxx__dut__run=1;
         ->computeStart[j];
         $display("-------------------------------Round %0d start-------------------------------\n",j);
         wait(dut__xxx__busy==1);
         @(posedge clk);
         xxx__dut__run=0;
         wait(dut__xxx__busy==0);
         ->computeEnd[j];
      end
  end
  //---------------------------------------------------------------------------

  //---------------------------------------------------------------------------
  //---------------------------------------------------------------------------
  // Timer
  //
  initial begin
    for(k=0;k<ROUND;k=k+1) begin 
       wait(computeStart[k]);
       startTime[k]=$time;
       wait(computeEnd[k]);
       endTime[k]=$time;
       computeCycle[k]=endTime[k]-startTime[k];
     end
  end
 
  //---------------------------------------------------------------------------
  //---------------------------------------------------------------------------
  // Result collector 
  // Collect your compute results 

  initial begin
    for(q=0;q<ROUND;q=q+1) begin
       wait(computeEnd[q]);
       repeat(10) @(posedge clk);
       $display("-------------------------------Round %0d check start-------------------------------\n",q);
       $display("-------------------------------store results to g_result.dat-------------------------------\n");
       $writememb($sformatf("input_and_output_%0d/g_result.dat",q),xmem_mem.mem,12'h100,12'h1ff);
       repeat(10) @(posedge clk);

  //---------------------------------------------------------------------------
  //---------------------------------------------------------------------------
  // Result comparator 
  // Compare your compute results with the results compute by MATLAB
       $display("-------------------------------load results to gresult_array-------------------------------\n");
       $readmemb($sformatf("input_and_output_%0d/g_result.dat",q),gresult_array);

       $display("-------------------------------load results to golden_gresult_array-------------------------------\n");
       $readmemb($sformatf("input_and_output_%0d/x16_g_result_ece564.dat",q),golden_gresult_array);

       $display("-------------------------------Round %0d start compare -------------------------------\n",q);
       for(i=0;i<256;i=i+1) begin

         if(gresult_array[i+256][15:16-VALID]==golden_gresult_array[i][15:16-VALID]) correctGnumber[q]=correctGnumber[q]+1;
         if(((($itor(gresult_array[i+256])*sf) - ($itor(golden_gresult_array[i])*sf)) <= error_tolerance) && ((($itor(gresult_array[i+256])*sf) - ($itor(golden_gresult_array[i])*sf)) >= -error_tolerance)) 			begin
		correctGnumber_abs[q]=correctGnumber_abs[q]+1;
		end

       end
       $display("-------------------------------Round %0d Your report-------------------------------\n",q);
       $display("Check 1 : Correct g results = %0d/256",correctGnumber[q]);
       $display("Check 2 : When absolute error tolerance is %f, Correct g results = %0d/256",error_tolerance, correctGnumber_abs[q]);

       $display("computeCycle=%0d",computeCycle[q]/(2*CLK_PHASE));
       $display("---------------------------------------------------------------------------------\n");
       @(posedge clk);
       ->checkFinish[q];
     end //for loop end
     $finish;
  end


    
endmodule

