`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.06.2026 15:33:39
// Design Name: 
// Module Name: transmiter
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


module transmiter(
input clk , wr_enb , reset,enb , input[7:0] data_in , output reg tx ,output busy
    );
    
    reg[7:0]data;
    reg[2:0] index;
    reg[1:0]state = 2'b00;
    
    parameter idle_state = 2'b00;
    parameter start_state = 2'b01;
    parameter data_state = 2'b10;
    parameter stop_state  = 2'b11;
    
    always@(posedge clk)
        begin
            if(reset)
                tx <= 1'b1;
        end
        
     always@(posedge clk)
        begin
            case(state)
                idle_state: begin
                                if(wr_enb)
                                begin
                                state<=start_state;
                                data<=data_in;
                                index<=3'h0;
                                end
                                
                                else
                                state<=idle_state;
                            end
                
                start_state:begin
                                if(enb)
                                begin
                                    tx<=1'b0;
                                    state<=data_state;
                                   
                                end
                                
                                else
                                    state<=start_state;
                             end
                data_state:begin
                            if(enb) 
                                begin
                                    tx<=data[index]; 
                                    if(index==3'h7)
                                        state<=stop_state;
                                    else
                                        begin
                                       
                                        index<=index+3'h1;
                                       
                                        
                                        end
                                end
                            
                            end
                         
                stop_state:begin
                            if(enb)
                                begin
                                tx<=1'b1;
                                state<=idle_state;
                                end                                                      
                            
                            end
                          
                default:begin
                        tx<=1'b1;
                        state<=idle_state;
                        end           
            
            endcase        
        
        end
        assign busy = (state!=idle_state);
endmodule
