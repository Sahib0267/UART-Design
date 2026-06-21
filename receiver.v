`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.06.2026 14:13:35
// Design Name: 
// Module Name: receiver
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


module receiver(
input clk , reset , rdy_clr , clk_enb , rx , output reg ready , output reg[7:0] data_out
    );
    
    parameter start_state  = 2'b00;
    parameter data_out_state = 2'b01;
    parameter stop_state = 2'b10;
    
    reg[3:0] sample=0;
    reg[7:0] temp=0;
    reg[3:0]index=0;
    reg[1:0]state = start_state;
    
    always@(posedge clk)
    begin
        if(reset)
            begin
                data_out<=0;
                ready<=0;
            end
     end
     
     
     always@(posedge clk)
        begin
            if(rdy_clr)
                ready<=0;
            if(clk_enb)
                begin
                case(state)
                    start_state:begin
                                    if(rx==0 || sample!=0)  //(rx==0 && sample!=0)
                                    sample<=sample+4'b1;
                                    
                                    if(sample==4'b1111)
                                    begin
                                    state<=data_out_state;
                                    sample<=0;
                                    index<=0;
                                    temp<=0;
                                    end
                                end
                      
                     data_out_state:begin
                                    sample<=sample+4'b1;
                                    if(sample==4'b1000)
                                        begin
                                        temp[index] <= rx;
                                        index<=index+4'b1;
                                        end
                                    if(index==8 && sample == 15)
                                        begin
                                        state<=stop_state;
                                        end
                                    
                                    end
                                   
                    stop_state:begin 
                                if(sample ==15)
                                    begin
                                    state<=start_state;
                                    data_out <= temp;
                                    ready<=1'b1;
                                    sample<=0;
                                    end
                                 else
                                 sample<=sample+4'b1;
                                end
                                
                     default:begin
                             state<=start_state;
                             end
                             
                endcase
                end
                
        end
endmodule
