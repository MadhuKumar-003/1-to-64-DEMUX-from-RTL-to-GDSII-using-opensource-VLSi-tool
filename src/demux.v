module demux_1_64 (
    input  wire        data_in,  // 1-bit input data signal
    input  wire [5:0]  sel,      // 6-bit select line (2^6 = 64 outputs)
    output reg  [63:0] data_out  // 64-bit output bus
);

    // Behavioral description for combinational logic
    always @(*) begin
        // Default assignment: All outputs are driven LOW
        data_out = 64'b0;
        
        // Route the input signal to the specifically selected output bit
        data_out[sel] = data_in;
    end

endmodule
