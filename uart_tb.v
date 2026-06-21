`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 15:16:46
// Design Name: 
// Module Name: uart_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_tb(

    );
    
    //inputs 
    reg reset , clk , wr_enb , ready_clr;
    reg [7:0] data_in;
    
    
    //outputs   
    wire ready;
    wire [7:0]data_out;
    wire busy;
    
    uart_top dut(reset , data_in,  wr_enb , clk ,ready_clr,ready , busy ,data_out);
    
    initial
    {reset , clk , wr_enb , ready_clr,data_in} = 0;
    
    always #5 clk  =~clk;
    
    task send_byte(input [7:0] din);
    
    begin
        @(negedge clk)
        data_in = din;
        wr_enb =1'b1;
        @(negedge clk)
        wr_enb  = 0;
        
        end 
        endtask
        
     task clear_ready;
     begin
     @(negedge clk)
        ready_clr = 1'b1;
        @(negedge clk)
         ready_clr = 1'b0;
     end 
     endtask
     
     initial 
     begin
        @(negedge clk)
            reset = 1'b1;
        @(negedge clk)
            reset = 1'b0;
            
        send_byte(8'h41);
        wait(!busy);
        wait(ready);
        $display("recived data is %h", data_out);
        clear_ready;
        
        
        
        send_byte(8'h55);
        wait(!busy);
        wait(ready);
        $display("recived data is %h", data_out);
        clear_ready;
        
         send_byte(8'h78);
        wait(!busy);
        wait(ready);
        $display("recived data is %h", data_out);
        clear_ready;
        
        
               
        end 
endmodule
