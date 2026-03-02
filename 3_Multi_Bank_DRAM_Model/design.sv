module multi_bank_dram (
    input        clk,
    input        rst_n,
    input [9:0]  addr,      // [9:8] Bank, [7:4] Row, [3:0] Col
    input [7:0]  wdata,
    input        write_en,
    output reg [7:0] rdata
);

    // 4 Banks x 16 Rows x 16 Cols (Total 1024 bytes)
    reg [7:0] mem [0:3][0:15][0:15];

    wire [1:0] bank_idx = addr[9:8];
    wire [3:0] row_idx  = addr[7:4];
    wire [3:0] col_idx  = addr[3:0];

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rdata <= 8'h00;
        end else begin
            if (write_en) begin
                mem[bank_idx][row_idx][col_idx] <= wdata;
            end else begin
                rdata <= mem[bank_idx][row_idx][col_idx];
            end
        end
    end

endmodule
