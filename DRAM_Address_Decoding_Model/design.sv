// ----------------------------------------------------------------
// Project: DRAM Row & Column Addressing Model
// Description: 16x16 Memory Matrix with Address Decoding
// ----------------------------------------------------------------

module row_col_dram (
    input              clk,
    input              rst_n,
    input      [7:0]   addr,     // 8-bit Address (Row[7:4], Col[3:0])
    input      [7:0]   wdata,    // 8-bit Data Input
    input              write_en, // 1: Write, 0: Read
    output reg [7:0]   rdata     // Data Output
);

    // [Physical Mapping] 16x16 Memory Array (Total 256 Cells)
    reg [7:0] mem_matrix [0:15][0:15]; 

    // Address Decoding: Splitting 8-bit addr into Row and Col
    wire [3:0] row_addr = addr[7:4];
    wire [3:0] col_addr = addr[3:0];

    // Synchronous Memory Operation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rdata <= 8'b0;
        end else begin
            if (write_en) begin
                // Write Path
                mem_matrix[row_addr][col_addr] <= wdata;
            end else begin
                // Read Path (1-clock Latency)
                rdata <= mem_matrix[row_addr][col_addr];
            end
        end
    end

endmodule
