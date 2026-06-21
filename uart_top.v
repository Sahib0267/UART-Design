`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 14:50:29
// Design Name: 
// Module Name: uart_top
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
// c
//////////////////////////////////////////////////////////////////////////////////


module uart_top(
    input reset ,input [7:0]data_in, input wr_enb  , input clk , rdy_clr , output ready , busy , output[7:0]data_out
    );
    
    wire rx_clk_enb; // used to send the output signal of enb from baude rate to tx and rx
    wire tx_clk_enb;
    
    wire tx_temp; // to send output  data of tx 
    
    baude_rate_gen bg(clk , reset , rx_clk_enb , tx_clk_enb);
    transmiter tx(clk ,wr_enb , reset , tx_clk_enb , data_in ,tx_temp ,busy);
    receiver  rx(clk , reset , rdy_clr , rx_clk_enb,tx_temp ,ready , data_out);
    
endmodule
