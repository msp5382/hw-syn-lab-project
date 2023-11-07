module mux2to1 (
    input wire [31:0] in0,     // Input 0
    input wire [31:0] in1,     // Input 1
    input wire sel,            // Selector signal
    output wire [31:0] out     // Output
);

    // Output is in1 if sel is 1, else in0
    assign out = sel ? in1 : in0;

endmodule
