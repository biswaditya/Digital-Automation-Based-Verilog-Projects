`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.07.2025 13:45:39
// Design Name: 
// Module Name: Parking_Management_System
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


module Parking_Management_System(
    input CLK,
    input RESET,
    input ENTRY_sensor,
    input EXIT_sensor,
    output reg [3:0] Parking_count,// No of Spots Occupied 
    output reg [3:0] Available_spots,// No of Available_spots
    output reg FULL, // O/P High when Parking_count == 8
    output reg EMPTY  // O/P High when Parking_count == 0
    );
    
    parameter MAX_PARKING = 8;// Assume max Parking Spots to be 8
    
   always@(posedge CLK or posedge RESET)
   begin  if(RESET)begin Parking_count <= 0;
                         Available_spots <= MAX_PARKING;
                         FULL<=0;
                         EMPTY<=1;
                   end  
          else begin
                      case({ENTRY_sensor,EXIT_sensor})
                      2'b10 : begin // Vehicle entering
                              if (Parking_count < MAX_PARKING) begin
                                  Parking_count <= Parking_count + 1;
                              end
                              end
                      2'b01 : begin // Vehicle exiting
                              if (Parking_count > 0) begin
                               Parking_count <= Parking_count - 1;
                              end
                              end 
                      // for 2'b11 & 2'b00 NO CHANGE Parking_count <= Parking_count           
                      endcase 
               end            
   end
   
   always @(*)
    begin
       Available_spots = MAX_PARKING - Parking_count;
       FULL  = (Parking_count == MAX_PARKING) ? 1'b1 : 1'b0;
       EMPTY = (Parking_count == 0)           ? 1'b1 : 1'b0;
    end
    
endmodule
