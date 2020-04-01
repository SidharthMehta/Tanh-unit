/*********************************************************************************************

    File name   : sram.v
    Author      : Lee Baker, Yuejiang Wen (Revise)
    Affiliation : North Carolina State University, Raleigh, NC
    Date        : 09/09/2019
    email       : wyuejia@ncsu.edu

    Description : Generic SRAM 


*********************************************************************************************/
    
//`timescale 1ns/10ps

module sram     #(parameter  ADDR_WIDTH      = 32  , 
                  parameter  DATA_WIDTH      = 16  ,
                  parameter  MEM_INIT_FILE   = ""  )
                (
                //---------------------------------------------------------------
                // 
                input  wire [ADDR_WIDTH-1:0  ]  write_address ,
                input  wire [DATA_WIDTH-1:0  ]  write_data    ,
                input  wire [ADDR_WIDTH-1:0  ]  read_address  ,
                output reg  [DATA_WIDTH-1:0  ]  read_data     ,
                input  wire                     write_enable ,

                input  clock
                );


    //--------------------------------------------------------
    // Associative memory

    bit  [DATA_WIDTH-1 :0  ]     mem     [int] = '{default: 'X};
    
    //--------------------------------------------------------
    // RAW and X condition
    
    reg  [ADDR_WIDTH-1:0   ]     last_write_addr;
    reg                          last_write_en;
    //--------------------------------------------------------
    // Read
    always @(posedge clock)
      begin
        if ( ^read_address === 1'bx || ( (last_write_addr>>1) == (read_address>>1) && last_write_en == 1'b1) )
          read_data <= 16'bx;
        else
          read_data <= mem [read_address>>1];
      end

    //--------------------------------------------------------
    // Write

    always @(posedge clock)
      begin
        last_write_addr <= write_address;
        last_write_en <= write_enable;
        if (write_enable) begin
          mem [write_address>>1] = write_data;
        end
      end
    //--------------------------------------------------------


    //--------------------------------------------------------
    // Need to accomodate loading during simulation
    // e.g. pe_cntl.v creates event
    
    //string memFile;
    string entry  ;
    int fileDesc ;
    bit [ADDR_WIDTH-1 :0 ]  memory_address ;
    bit [DATA_WIDTH-1 :0 ]  memory_data    ;

    /*event loadMemory ;
    always
      begin
        @(loadMemory)
          loadInitFile;
      end

    // load at trailing edge of reset
    initial
      begin
        memFile = MEM_INIT_FILE ;
        -> loadMemory ;
      end*/

    task  loadInitFile(input string memFile);
      if (memFile != "")
        begin
          fileDesc = $fopen (memFile, "r");
          if (fileDesc == 0)
            begin
              $display("ERROR::readmem file error : %s ", memFile);
              $finish;
            end
          $display("INFO::readmem : %s ", memFile);
          while (!$feof(fileDesc)) 
            begin 
              void'($fgets(entry, fileDesc)); 
              void'($sscanf(entry, "@%x %b", memory_address, memory_data));
              //$display("INFO::readmem file contents : %s  : Addr:%h, Data:%h", memFile, memory_address, memory_data);
              mem[memory_address] = memory_data ;
            end
          $fclose(fileDesc);
        end
     endtask

endmodule


