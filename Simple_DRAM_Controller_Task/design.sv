// ----------------------------------------------------------------지
// Project: Simple DRAM Controller Task
// Description: Basic Memory Write/Read Logic
// ----------------------------------------------------------------

module simple_dram (
    input              clk,
    input              rst_n,
    input      [3:0]   addr,      // 16개의 Address (Row/Col 통합)
    input      [7:0]   wdata,     // 8-bit Data Input
    input              write_en,  // 1: Write, 0: Read
    output reg [7:0]   rdata      // Data Output
);

    // [Physical to Logical] 
    // 레이아웃의 Cell Array를 16x8 비트 배열로 모델링합니다.
    reg [7:0] mem_array [0:15]; 

    // Synchronous Logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rdata <= 8'b0;
        end else begin
            if (write_en) begin
                // Write Path: 데이터가 셀에 저장되는 단계
                mem_array[addr] <= wdata;
            end else begin
                // Read Path: 셀의 데이터를 센스앰프를 거쳐 내보내는 단계(추상화)
                rdata <= mem_array[addr];
            end
        end
    end

endmodule
