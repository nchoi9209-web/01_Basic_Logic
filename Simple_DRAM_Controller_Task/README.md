# Simple DRAM Controller Task

## 📌 개요
DRAM 레이아웃 설계(7.5년) 경험을 바탕으로, 메모리 셀의 동작을 논리적(Logical) 관점에서 처음으로 모델링하고 검증한 프로젝트입니다. Physical Design의 이해를 바탕으로 DV(Design Verification)로 전환하는 첫 단계입니다.

## 🎯 검증 목표
- **Single Port Read/Write:** 특정 어드레스에 데이터를 쓰고 다시 읽었을 때 데이터 무결성(Data Integrity) 확인.
- **Timing Check:** Reset 직후 동작과 Clock Edge에 따른 신호 전이 확인.

## 💻 사용 툴 및 환경
- **Simulator:** Cadence Xcelium 25.03 (EDA Playground 환경)
- **Language:** SystemVerilog

## 🔍 핵심 로직 설명
- **Memory Array:** `reg [7:0] mem_array [0:15]` (실제 Physical한 Cell Array의 논리적 추상화)
- **Control:** `write_en` 신호를 이용한 데이터 쓰기/읽기 제어 로직 구현.

## 📊 시뮬레이션 결과 (Console)
```text
[WRITE] Addr: 8, Data: ab
[READ]  Searching Addr: 8...
>>> SUCCESS: Data matched! (ab)
