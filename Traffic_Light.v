`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.12.2024 00:38:57
// Design Name: 
// Module Name: Traffic_Light
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
`define true 1'b1;
`define false 1'b0;



module Traffic_Light( traffic,crossing,waiting,clock,clear );

output[1:0] traffic,crossing;
reg[1:0] traffic,crossing;
input waiting;
input clock,clear;

parameter
green=2'd2,
yellow=2'd1,
red=2'd0;

parameter 
s0=3'd0,
s1=3'd1,
s2=3'd2,
s3=3'd3,
s4=3'd4;

reg [2:0] state,next_state;

always@(posedge clock)begin
if(clear)
state<=s0;

else
state<=next_state;

end
always@(state) begin
traffic=green;
crossing=red;
 
 case(state)
     s0: ;
     s1:traffic=yellow;
     s2:traffic=red;
     s3: begin
       traffic=red;
       crossing=green;
       end
     s4: begin
        traffic=red;
        crossing=yellow;
        end
 endcase 
end

 always@(*)begin
    case(state)
    s0:if(waiting) next_state=s1;
       else next_state=s0;
    s1:begin
     
     next_state=s2;
     end
    s2:begin 
       
       next_state=s3;
       end
    s3: begin
       if(waiting) next_state=s3;
       else 
          next_state=s4;  
        end
    s4:begin
        
        next_state=s0;
       end
     default: next_state=s0;
    endcase
   end
endmodule
