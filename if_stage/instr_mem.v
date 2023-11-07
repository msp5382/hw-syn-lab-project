module instr_mem (
    input wire clk,              // Clock signal
    input wire [31:0] addr,      // Address input, typically from the PC
    output reg [31:0] instr      // Instruction output at the given address
);

    // Parameter for the size of the memory
    parameter MEM_DEPTH = 256;
    
    // The memory array
    reg [31:0] mem_array [0:MEM_DEPTH-1];

    // Asynchronous read from the memory
    always @(posedge clk) begin
        // Assuming word-aligned addresses, the lower 2 bits of the address are ignored
        instr <= mem_array[addr[31:2]];
    end

    // Initialize memory with a program (optional)
    // This is just an example and would be replaced with the actual machine code
    initial begin
        // Reset all memory to zero
        integer i;
        for (i = 0; i < MEM_DEPTH; i = i + 1) begin
            mem_array[i] = 32'd0;
        end

        // Example: Load some instructions into memory
        // These would be replaced with the actual instructions of your program
        // mem_array[0] = 32'hXXXXXXXX; // Replace XXXXXXXX with actual instruction code
        // mem_array[1] = 32'hXXXXXXXX;
        // ...
        
        // Simple adding instruction code with rv32
        mem_array[0] = 32'h00400093; // addi x1, x0, 4
        mem_array[1] = 32'h00800113; // addi x2, x0, 8
        mem_array[2] = 32'h002081b3; // add x3, x1, x2
    end

endmodule
