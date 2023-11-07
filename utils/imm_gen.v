module imm_gen (
    input wire [31:0] instr,   // The instruction
    output wire [31:0] imm     // The sign-extended immediate value
);

    // Extracts the immediate from bits [31:20] and sign-extends it
    assign imm = {{20{instr[31]}}, instr[31:20]};

endmodule
