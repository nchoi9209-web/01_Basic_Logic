# Simple DRAM Controller Task 📌

## 1. Project Overview
7.5년간의 **DRAM/Flash Layout Design 및 DFM/DRC/LVS** 경력을 바탕으로, 하드웨어의 물리적 구조를 논리적(Logical) 관점에서 모델링하고 검증하기 위한 첫 번째 프로젝트입니다. 실제 메모리 셀 어레이의 데이터 저장 및 출력 메커니즘을 SystemVerilog로 구현하여 DV(Design Verification) 역량의 기초를 다졌습니다.

## 2. Verification Goals
* **Data Integrity:** 특정 Address에 Write한 데이터가 유실 없이 Read되는지 확인.
* **Timing Synchronization:** 클럭(Clock) 기반의 동기식 설계 및 리셋(Reset) 제어 검증.
* **Simulator Proficiency:** 현업 표준 툴인 **Cadence Xcelium** 환경에서의 시뮬레이션 수행 및 로그 분석.

---

## 3. Design & Environment
* **Language:** SystemVerilog
* **Target Simulator:** Cadence Xcelium 25.03 (via EDA Playground)
* **Memory Structure:** 16 x 8-bit Register Array (Cell Array의 추상화 모델)

## 4. 핵심 코드 설명
### 1) Design (`design.sv`)
* 레이아웃상의 Cell Array를 `reg [7:0] mem_array [0:15]`로 정의.
* `write_en` 신호의 상태에 따라 메모리 쓰기와 읽기 동작이 전환되는 제어 로직 구현.

### 2) Testbench (`testbench.sv`)
* 100MHz 클럭 생성 및 비동기 리셋(Active-low) 시나리오 적용.
* 서로 다른 주소(4h, Ah)에 데이터를 기록하고, 이를 다시 읽어와 Expected 값과 비교하는 **Self-checking** 로직 구성.

---

## 5. 시뮬레이션 결과 (Xcelium Log)
```text
TOOL:	xrun	25.03-s001: Started on Feb 22, 2026 at 02:37:56 EST
xrun: 25.03-s001: (c) Copyright 1995-2025 Cadence Design Systems, Inc.

xcelium> run
[PASS] Addr 4: Expected A5, Got a5
[PASS] Addr A: Expected 5A, Got 5a
Simulation Finished!
Simulation complete via $finish(1) at time 56 NS + 0

## 6. Key Learning: Layout to DV Insights

7.5년의 레이아웃 설계 경험을 바탕으로 본 프로젝트를 수행하며 얻은 핵심 인사이트입니다.

* **물리적 구조의 추상화 (Abstraction):** 실제 Tr과 Capacitor로 구성된 복잡한 Cell Array를 SystemVerilog의 `reg array`로 추상화하여 모델링하는 법을 익혔습니다. 이는 시뮬레이션 속도를 높이면서도 논리적 무결성을 검증하는 DV의 핵심 원리를 이해하는 계기가 되었습니다.
* **디코딩 로직의 이해:** 레이아웃에서 패턴으로만 보던 Wordline/Bitline의 선택 과정이 로직상에서는 Address Decoding을 통해 어떻게 구현되는지 코드로 직접 확인했습니다.
* **타이밍 개념의 확장:** Physical 설계에서 중요하게 다뤘던 **Setup/Hold Time**과 신호 지연(Delay)이 시뮬레이션 환경에서는 `#1` 딜레이나 클럭 에지(Clock Edge) 제어를 통해 어떻게 보장되는지 학습했습니다.
* **Self-Checking Testbench:** 사람이 직접 파형을 눈으로 확인하는 것이 아니라, 코드가 스스로 결과를 비교하고 `[PASS]/[FAIL]`을 출력하게 만드는 '자동화 검증'의 기초를 다졌습니다.
