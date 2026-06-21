`timescale 1ns / 1ps

module baude_rate_gen(
    input clk,
    input reset,
    output rx_enb,
    output tx_enb
);

reg [12:0] tx_counter;
reg [12:0] rx_counter;

// RX : 16x baud clock
always @(posedge clk)
begin
    if(reset)
        rx_counter <= 0;
    else if(rx_counter == 13'd325)
        rx_counter <= 0;
    else
        rx_counter <= rx_counter + 1'b1;
end

// TX : baud clock
always @(posedge clk)
begin
    if(reset)
        tx_counter <= 0;
    else if(tx_counter == 13'd5208)
        tx_counter <= 0;
    else
        tx_counter <= tx_counter + 1'b1;
end

assign rx_enb = (rx_counter == 0);
assign tx_enb = (tx_counter == 0);

endmodule