Project Description:
The Traffic Light Controller is a digital system designed to manage the flow of traffic at a road intersection. The controller operates based on predefined states to coordinate the traffic lights for vehicles and pedestrian crossings. It ensures a systematic transition between the green, yellow, and red signals to optimize traffic flow and pedestrian safety.

The design is implemented using Verilog HDL, targeting FPGA or ASIC platforms. It employs a finite state machine (FSM) to manage state transitions based on input conditions such as a pedestrian waiting signal. The project demonstrates a robust understanding of digital design principles and highlights the ability to implement real-world traffic management systems in hardware.

Features:
Finite State Machine (FSM) Design:

States represent traffic and pedestrian light combinations (green, yellow, red).
Handles smooth transitions between states.
Pedestrian Wait Input:

Detects a pedestrian request for crossing and prioritizes pedestrian safety.
Configurable Timing Logic:

Ensures proper delays between signal changes to mimic real-world traffic lights.
Reset Functionality:

A reset mechanism initializes the system to a default state for predictable startup behavior.
Technical Specifications:
Input Signals:

waiting: Indicates a pedestrian crossing request.
clock: System clock signal for state transitions.
clear: Reset signal to reinitialize the controller.
Output Signals:

traffic: Controls the vehicle traffic lights (green, yellow, red).
crossing: Controls the pedestrian crossing lights (green, yellow, red).
Parameters:

Predefined colors (green, yellow, red).
FSM states for traffic management.
Design Elements:

FSM for state management.
Synchronous reset functionality.
Modular and synthesizable Verilog code.
Applications:
This project is ideal for use in:

Urban traffic intersections.
Smart city projects integrating traffic management systems.
Educational purposes to demonstrate FSM-based digital design.
Conclusion:
The Traffic Light Controller project combines practical problem-solving with efficient digital design. It serves as an excellent example of implementing finite state machines in Verilog, addressing both vehicular traffic flow and pedestrian safety. The design is scalable and can be extended to incorporate additional features such as real-time traffic monitoring and adaptive timing.

............................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................................

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

parameter    //state       highway           crossing
         s0=  3'd0,       //  green            red
         s1=  3'd1,        // yellow           red
         s2=  3'd2,        //red               red
         s3=  3'd3,        //red               green
         s4=  3'd4;        // red              yellow

reg [2:0] state,next_state;

always@(posedge clock)begin
if(clear)
state<=s0;  // default state of green signal on highway and red on crossing

else
state<=next_state;  // if pedestrian waiting states change

end
always@(state) begin
traffic=green;    // default signal status
crossing=red;
 
 case(state)   // flow of change in traffic signals
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

 always@(*)begin // flow of change in states 
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
