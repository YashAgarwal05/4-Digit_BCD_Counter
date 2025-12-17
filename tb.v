`timescale 1ns/1ps

module tb;
    reg clk;
    reg reset;
    wire [3:1] ena;
    wire [15:0] q;
    wire [3:0] digit0, digit1, digit2, digit3;
    
    // Instantiate the top module
    bcd uut (
        .clk(clk),
        .reset(reset),
        .ena(ena),
        .q(q),
        .digit0(digit0),
        .digit1(digit1),
        .digit2(digit2),
        .digit3(digit3)
    );
    
    // Clock generation
    always #10 clk = ~clk; // 50MHz clock simulation (20ns period)
    
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;
        
        // Apply reset
        #50 reset = 0;
        
        // Run simulation for some time
        #100000;
        
        // Stop simulation
        $finish;
    end
    
    // Monitor outputs
    initial begin
        $monitor("Time = %0t | q = %b | ena = %b", $time, q, ena);
    end
endmodule
