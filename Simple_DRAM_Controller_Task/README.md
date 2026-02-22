Simple DRAM Controller Task
📌 Project Overview
7.5년간의 DRAM/Flash Layout Design 및 DFM/DRC/LVS 경력을 바탕으로, 하드웨어의 물리적 구조를 논리적(Logical) 관점에서 모델링하고 검증하기 위한 첫 번째 단계입니다. 실제 메모리 셀 어레이의 데이터 저장 및 출력 메커니즘을 SystemVerilog로 구현하여 DV(Design Verification) 역량의 기초를 다졌습니다.

🎯 Verification Goals
Data Integrity: 특정 Address에 Write한 데이터가 유실 없이 Read되는지 확인.

Timing Synchronization: 클럭(Clock) 기반의 동기식 설계 및 리셋(Reset) 제어 검증.

Simulator Proficiency: 현업 표준 툴인 Cadence Xcelium 환경에서의 시뮬레이션 수행 및 로그 분석.

🛠️ Design & Environment
Language: SystemVerilog

Target Simulator: Cadence Xcelium 25.03 (via EDA Playground)

Memory Structure: 16 x 8-bit Register Array (Cell Array의 추상화 모델)

🔍 핵심 코드 설명
1. Design (design.sv)
레이아웃상의 Cell Array를 reg [7:0] mem_array [0:15]로 정의.

write_en 신호의 상태에 따라 메모리 쓰기와 읽기 동작이 전환되는 제어 로직 구현.

2. Testbench (testbench.sv)
100MHz 클럭 생성 및 비동기 리셋(Active-low) 시나리오 적용.

서로 다른 주소(4h, Ah)에 데이터를 기록하고, 이를 다시 읽어와 Expected 값과 비교하는 비교 로직(Self-checking) 구성.

📊 시뮬레이션 결과 (Xcelium Log)
Plaintext
TOOL:	xrun	25.03-s001: Started on Feb 22, 2026 at 02:37:56 EST
xcelium> run
[PASS] Addr 4: Expected A5, Got a5
[PASS] Addr A: Expected 5A, Got 5a
Simulation Finished!
Simulation complete via $finish(1) at time 56 NS + 0
모든 테스트 케이스가 PASS 되었으며, 데이터 무결성이 입증됨.

💡 Key Learning
실제 레이아웃에서 다루던 Wordline/Bitline의 물리적 선택 과정이 로직상에서는 Address Decoding으로 어떻게 추상화되는지 이해함.

신호의 안정화를 위해 #1 딜레이를 사용하는 등, 레이아웃의 Setup/Hold Time 개념이 시뮬레이션 환경에 어떻게 투영되는지 학습함.
