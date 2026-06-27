`timescale 1ns / 1ps

module demux_1_64_tb;

    // Inputs (driven as registers in testbench)
    reg data_in;
    reg [5:0] sel;

    // Outputs (monitored as wires)
    wire [63:0] data_out;

    // Instantiate the Unit Under Test (UUT)
    // Ensure the module name here matches the module name inside demux.v
    demux_1_64 uut (
        .data_in(data_in),
        .sel(sel),
        .data_out(data_out)
    );

    // Loop variable for simulation stimulus
    integer i;

    // --- Waveform Generation Block ---
    initial begin
        $dumpfile("demux_waveform.vcd"); // Creates the VCD file in the execution folder
        $dumpvars(0, demux_1_64_tb);     // Dumps all signals within this testbench module
    end

    // --- Main Simulation Stimulus ---
    initial begin
        // Initialize Inputs
        data_in = 1'b0;
        sel = 6'b000000;

        // Global reset emulation window
        #100;
        
        // --- Test Case 1: Drive Data HIGH across all 64 channels ---
        $display("Starting Test Case 1: Routing HIGH data signal...");
        data_in = 1'b1;
        
        for (i = 0; i < 64; i = i + 1) begin
            sel = i;
            #10; // Propagation delay padding
            
            // Self-checking assertion
            if (data_out[i] !== 1'b1) begin
                $display("ALERT: Verification mismatch detected at output channel %d", i);
            end
        end

        // --- Test Case 2: Drive Data LOW and verify channel updates ---
        $display("Starting Test Case 2: Routing LOW data signal...");
        data_in = 1'b0;
        sel = 6'd32; // Fully sized 6-bit literal index
        #10;
        
        if (data_out[32] !== 1'b0) begin
            $display("ALERT: Data failed to pull down on channel 32");
        end

        // End Simulation cleanly
        $display("Execution Matrix Completed: All checks processed.");
        $finish;
    end
      
endmodule
