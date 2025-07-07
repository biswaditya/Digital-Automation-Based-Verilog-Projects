`timescale 1ns / 1ps

module Parking_Management_System_tb;

    // Inputs
    reg CLK;
    reg RESET;
    reg ENTRY_sensor;
    reg EXIT_sensor;

    // Outputs
    wire [3:0] Parking_count;
    wire [3:0] Available_spots;
    wire FULL;
    wire EMPTY;

  
    Parking_Management_System dut (
        .CLK(CLK),
        .RESET(RESET),
        .ENTRY_sensor(ENTRY_sensor),
        .EXIT_sensor(EXIT_sensor),
        .Parking_count(Parking_count),
        .Available_spots(Available_spots),
        .FULL(FULL),
        .EMPTY(EMPTY)
    );

    // Clock generation: 10 ns period
    always #5 CLK = ~CLK;

    initial begin
        // Initialize
        CLK = 0;
        RESET = 1;
        ENTRY_sensor = 0;
        EXIT_sensor = 0;

        // Apply reset
        #10 RESET = 0;

        // Simulate 5 cars entering
        repeat (5) begin
            #10 ENTRY_sensor = 1;
            EXIT_sensor = 0;
            #10 ENTRY_sensor = 0;
        end

        // Simulate 2 cars exiting
        repeat (2) begin
            #10 EXIT_sensor = 1;
            ENTRY_sensor = 0;
            #10 EXIT_sensor = 0;
        end

        // Try to fill up to full
        repeat (5) begin
            #10 ENTRY_sensor = 1;
            EXIT_sensor = 0;
            #10 ENTRY_sensor = 0;
        end

        // Try to exit all
        repeat (8) begin
            #10 EXIT_sensor = 1;
            ENTRY_sensor = 0;
            #10 EXIT_sensor = 0;
        end

        #50 $finish;
    end

endmodule
