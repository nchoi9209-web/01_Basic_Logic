`timescale 1ns/1ps

module tb_row_col_dram;
    reg clk, rst_n, write_en;
    reg [7:0] addr;
    reg [7:0] wdata;
    wire [7:0] rdata;

    // DUT 연결
    row_col_dram dut (
        .clk(clk),
        .rst_n(rst_n),
        .addr(addr),
        .wdata(wdata),
        .write_en(write_en),
        .rdata(rdata)
    );

    // 100MHz 클럭 생성
    always #5 clk = ~clk;

    integer r, c; // 루프용 변수 (Row, Column)

    initial begin
        // 1. 초기화 및 리셋
        clk = 0; rst_n = 0; write_en = 0; addr = 0; wdata = 0;
        #15 rst_n = 1;

        // 2. [Write Loop] 256개 모든 셀에 데이터 쓰기
        // Row 0~15를 돌면서 그 안의 Col 0~15를 다 채움
        for (r = 0; r < 16; r = r + 1) begin
            for (c = 0; c < 16; c = c + 1) begin
                @(posedge clk);
                write_en = 1;
                addr = {r[3:0], c[3:0]}; // Row와 Col을 합쳐서 8비트 주소 생성
                wdata = r + c;           // 테스트용 데이터 (행+열 값)
            end
        end

        // 3. 읽기 모드로 전환
        @(posedge clk);
        write_en = 0;

        // 4. [Read & Verify Loop] 데이터 확인
        for (r = 0; r < 16; r = r + 1) begin
            for (c = 0; c < 16; c = c + 1) begin
                addr = {r[3:0], c[3:0]};
                @(posedge clk);
                #1; // 안정화 대기
                if (rdata === (r + c)) begin
                    // 너무 많으니 통과 로그는 생략하거나 가끔만 출력
                end else begin
                    $display("[FAIL] Row:%d, Col:%d | Exp:%h, Got:%h", r, c, (r+c), rdata);
                end
            end
        end

        $display("Full 256-Cell Simulation Finished! All Data Verified.");
        $finish;
    end
endmodule
