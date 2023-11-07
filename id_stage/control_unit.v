module control_unit(
    input wire [6:0] opcode,
    input wire [2:0] funct3,
    output reg alu_src,
    output reg mem_to_reg,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg branch,
    output reg [3:0] alu_op, // Extended to 4 bits for more operations
    output reg jump
);

    // Define the opcode constants for simplicity
    localparam OPCODE_RTYPE = 7'b0110011,
               OPCODE_ITYPE = 7'b0010011,
               OPCODE_LOAD  = 7'b0000011,
               OPCODE_STORE = 7'b0100011,
               OPCODE_BRANCH= 7'b1100011,
               OPCODE_LUI   = 7'b0110111,
               OPCODE_AUIPC = 7'b0010111,
               OPCODE_JAL   = 7'b1101111,
               OPCODE_JALR  = 7'b1100111;

    always @(*) begin
        // Default control signal values
        alu_src    = 1'b0;
        mem_to_reg = 1'b0;
        reg_write  = 1'b0;
        mem_read   = 1'b0;
        mem_write  = 1'b0;
        branch     = 1'b0;
        alu_op     = 4'b0000;
        jump       = 1'b0;

        case (opcode)
            OPCODE_RTYPE: begin
                alu_src    = 1'b0;
                reg_write  = 1'b1;
                alu_op     = {1'b0, funct3}; // Simple mapping for R-type instructions
            end
            OPCODE_ITYPE: begin
                alu_src    = 1'b1;
                reg_write  = 1'b1;
                alu_op     = {1'b1, funct3}; // Simple mapping for I-type instructions
            end
            OPCODE_LOAD: begin
                alu_src    = 1'b1;
                mem_to_reg = 1'b1;
                reg_write  = 1'b1;
                mem_read   = 1'b1;
                alu_op     = 4'b0000; // ADD operation for address calculation
            end
            OPCODE_STORE: begin
                alu_src    = 1'b1;
                mem_write  = 1'b1;
                alu_op     = 4'b0000; // ADD operation for address calculation
            end
            OPCODE_BRANCH: begin
                branch     = 1'b1;
                alu_op     = 4'b0010; // SUB operation for comparison
            end
            OPCODE_LUI: begin
                reg_write  = 1'b1;
                alu_op     = 4'b0011; // Operation to handle LUI
            end
            OPCODE_AUIPC: begin
                reg_write  = 1'b1;
                alu_op     = 4'b0100; // Operation to handle AUIPC
            end
            OPCODE_JAL: begin
                reg_write  = 1'b1;
                jump       = 1'b1;
                alu_op     = 4'b0101; // Operation to handle JAL
            end
            OPCODE_JALR: begin
                reg_write  = 1'b1;
                jump       = 1'b1;
                alu_op     = 4'b0110; // Operation to handle JALR
            end
            default: begin
                // Handle illegal opcode
            end
        endcase
    end

endmodule
