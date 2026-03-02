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

    integer r, c;
    integer pass_count = 0;

    initial begin
        // 1. 초기화 및 리셋
        clk = 0; rst_n = 0; write_en = 0; addr = 0; wdata = 0;
        #15 rst_n = 1;

        // 2. [Write Loop]
        for (r = 0; r < 16; r = r + 1) begin
            for (c = 0; c < 16; c = c + 1) begin
                @(posedge clk);
                #1; // ★ 클럭보다 1ns 늦게 주소를 줌 (타이밍 확보)
                write_en = 1;
                addr = {r[3:0], c[3:0]}; 
                wdata = r + c;           
            end
        end

        // 3. 읽기 모드 전환
        @(posedge clk);
        #1;
        write_en = 0;

        // 4. [Read & Verify Loop]
        for (r = 0; r < 16; r = r + 1) begin
            for (c = 0; c < 16; c = c + 1) begin
                @(posedge clk);          // 1) 주소를 줄 타이밍 시작
                #1;                      // 2) 클럭보다 1ns 늦게 주소 인가
                addr = {r[3:0], c[3:0]};
                
                @(posedge clk);          // 3) 한 클럭 대기 (DUT가 데이터를 내보낼 시간)
                #1;                      // 4) 데이터가 안정된 후 비교
                
                if (rdata === (r[7:0] + c[7:0])) begin
                    pass_count = pass_count + 1;
                end else begin
                    $display("[FAIL] Row:%d, Col:%d | Exp:%h, Got:%h", r, c, (r+c), rdata);
                end
            end
        end

        // 5. 결과 출력
        if (pass_count === 256)
            $display("--- SUCCESS: All 256 cells verified! ---");
        else
            $display("--- FAILURE: %d cells failed. ---", (256 - pass_count));

        $finish;
    end

    // EPWave용 파형 저장
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_row_col_dram);
    end
endmodule
