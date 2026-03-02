`timescale 1ns/1ps // 시간 단위를 1ns, 정밀도를 1ps로 설정

module tb_multi_bank;
    // DUT 제어를 위한 레지스터 및 와이어 선언
    reg clk, rst_n, write_en;
    reg [9:0] addr;
    reg [7:0] wdata;
    wire [7:0] rdata;

    // DUT 인스턴스화 및 신호 연결
    multi_bank_dram dut (.*); 

    // 100MHz 클럭 생성 (5ns마다 반전)
    always #5 clk = ~clk; 

    integer b, r;           // 반복문을 위한 정수형 변수 (Bank, Row)
    integer pass_count = 0; // 성공 횟수 카운트

    initial begin
        // 초기 신호 설정
        clk = 0; rst_n = 0; write_en = 0; addr = 0; wdata = 0; 
        #15 rst_n = 1;      // 15ns 후 리셋 해제

        // [WRITE 섹션] 4개 뱅크의 일부 영역에 데이터 쓰기
        for (b = 0; b < 4; b++) begin      // 뱅크 0부터 3까지 반복
            for (r = 0; r < 4; r++) begin  // 행 0부터 3까지 반복
                @(posedge clk); #1;        // 클럭 상승 후 1ns 대기 (Race Condition 방지)
                write_en = 1;              // 쓰기 활성화
                addr = {b[1:0], r[3:0], 4'hA}; // 주소 조합 (뱅크, 행, 10번 열)
                wdata = b + r;             // 데이터 생성 (뱅크 번호 + 행 번호)
            end
        end

        @(posedge clk); #1; write_en = 0;  // 쓰기 종료 및 읽기 모드 준비

        // [READ 섹션] 쓴 데이터가 각 뱅크에 잘 들어갔는지 확인
        for (b = 0; b < 4; b++) begin
            for (r = 0; r < 4; r++) begin
                @(posedge clk); #1;        // 클럭 상승 후 1ns 뒤 주소 인가
                addr = {b[1:0], r[3:0], 4'hA}; 
                
                @(posedge clk); #1;        // 다음 클럭 상승 후 데이터 샘플링 (1-Clock Latency)
                if (rdata === (b[7:0] + r[7:0])) begin // 읽은 값이 예상값과 같으면
                    pass_count++;          // 성공 카운트 증가
                end else begin             // 다르면 에러 메시지 출력
                    $display("Fail! Bank:%d Row:%d | Exp:%h Got:%h", b, r, (b+r), rdata);
                end
            end
        end

        // 최종 결과 보고 및 시뮬레이션 종료
        $display("Verification Done: %d / 16 cases passed", pass_count);
        $finish; 
    end

    // EPWave 파형 기록 설정
    initial begin
        $dumpfile("dump.vcd");        // 파형 저장 파일명
        $dumpvars(0, tb_multi_bank);  // 모든 하위 신호 기록
    end
endmodule
