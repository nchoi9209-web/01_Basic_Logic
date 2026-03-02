`timescale 1ns/1ps

module tb_simple_dram;
    // 신호 정의
    reg clk, rst_n, write_en;
    reg [3:0] addr;
    reg [7:0] wdata;
    wire [7:0] rdata;

    // 1. DUT (Device Under Test) 인스턴스화
    simple_dram dut (
        .clk(clk),
        .rst_n(rst_n),
        .addr(addr),
        .wdata(wdata),
        .write_en(write_en),
        .rdata(rdata)
    );

    // 2. 100MHz 클럭 생성 (10ns 주기)
    always #5 clk = ~clk;

    // 3. 검증 시나리오 (Stimulus)
    initial begin
        // 초기화
        clk = 0; rst_n = 0; write_en = 0; addr = 0; wdata = 0;
        
        // Reset 동작 (레이아웃 상의 전하 방전과 유사한 논리 초기화)
        #15 rst_n = 1; 

        // [Test Case 1] Address 4번에 0xA5 쓰기
        repeat(1) @(posedge clk);
        addr = 4'h4; wdata = 8'hA5; write_en = 1;
        
        // [Test Case 2] Address 10번에 0x5A 쓰기
        @(posedge clk);
        addr = 4'hA; wdata = 8'h5A; write_en = 1;
        
        // [Test Case 3] Read 동작으로 전환
        @(posedge clk);
        write_en = 0; 
        
        // [Test Case 4] 4번 주소 읽기 및 검증
        addr = 4'h4;
        @(posedge clk);
        #1; // 신호 안정화 후 체크
        if (rdata === 8'hA5) 
            $display("[PASS] Addr 4: Expected A5, Got %h", rdata);
        else 
            $display("[FAIL] Addr 4: Expected A5, Got %h", rdata);

        // [Test Case 5] 10번 주소 읽기 및 검증
        addr = 4'hA;
        @(posedge clk);
        #1;
        if (rdata === 8'h5A) 
            $display("[PASS] Addr A: Expected 5A, Got %h", rdata);
        else 
            $display("[FAIL] Addr A: Expected 5A, Got %h", rdata);

        $display("Simulation Finished!");
        $finish;
    end

    // 파형 저장 (Xcelium/EPWave용)
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars(0, tb_simple_dram);
    end

endmodule
