module alu (
    input wire [31:0] a,              // First operand
    input wire [31:0] b,              // Second operand
    input wire [3:0] alu_control,     // Control signal determining the operation
    output reg [31:0] result,         // Result of the ALU operation
    output wire zero                  // Zero flag, high if result is zero
);

    // Define operation codes
    localparam ALU_ADD  = 4'b0000;
    localparam ALU_SUB  = 4'b0001;
    localparam ALU_AND  = 4'b0010;
    localparam ALU_OR   = 4'b0011;
    localparam ALU_XOR  = 4'b0100;
    localparam ALU_SLT  = 4'b0101;
    localparam ALU_SLTU = 4'b0110;
    localparam ALU_LUI  = 4'b0111;
    // ... Add more operation codes as needed

    // ALU operations
    always @(*) begin
        case (alu_control)
            ALU_ADD:  result = a + b;                       // Addition
            ALU_SUB:  result = a - b;                       // Subtraction
            ALU_AND:  result = a & b;                       // Bitwise AND
            ALU_OR:   result = a | b;                       // Bitwise OR
            ALU_XOR:  result = a ^ b;                       // Bitwise XOR
            ALU_SLT:  result = ($signed(a) < $signed(b)) ? 32'b1 : 32'b0; // Set on less than (signed)
            ALU_SLTU: result = (a < b) ? 32'b1 : 32'b0;    // Set on less than (unsigned)
            ALU_LUI:  result = b << 16;                     // Load upper immediate
            // ... Add more operations as needed
            default:  result = 32'b0;                       // Default to 0 on undefined operation
        endcase
    end

    // Set the zero flag if the result is 0
    assign zero = (result == 32'b0);

endmodule
