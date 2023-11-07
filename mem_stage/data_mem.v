module data_mem (
    input wire clk,                 // Clock signal
    input wire mem_write,           // Memory write enable signal
    input wire mem_read,            // Memory read enable signal
    input wire [31:0] addr,         // Memory address
    input wire [31:0] write_data,   // Data to write to memory
    output reg [31:0] read_data     // Data read from memory
);

    // Parameter for the size of the memory
    parameter MEM_DEPTH = 256;
    
    // Memory array
    reg [31:0] mem_array [0:MEM_DEPTH-1];

    // Synchronous write, asynchronous read
    always @(posedge clk) begin
        if (mem_write) begin
            // Write operation (word aligned)
            mem_array[addr[31:2]] <= write_data;
        end
    end

    // Asynchronous read
    always @(*) begin
        if (mem_read) begin
            // Read operation (word aligned)
            read_data <= mem_array[addr[31:2]];
        end else begin
            read_data <= 32'bz; // High impedance when not reading
        end
    end

endmodule
