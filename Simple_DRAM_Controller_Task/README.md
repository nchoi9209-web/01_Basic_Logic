# Simple DRAM Controller Task

[English](#english-version) | [한국어](#한국어-버전)

---

<a name="english-version"></a>
## 1. Project Overview (English)
Leveraging **7.5 years of experience in DRAM/Flash Layout Design (DFM/DRC/LVS)**, this project is the first step in modeling and verifying hardware physical structures from a logical perspective. I implemented basic memory cell array data storage and output mechanisms using **SystemVerilog** to build a foundation for **Design Verification (DV)**.

## 2. Verification Goals
* **Data Integrity:** Verify that data written to a specific address is read back without loss.
* **Timing Synchronization:** Validate synchronous design based on Clock and Reset control.
* **Simulator Proficiency:** Execute simulations and analyze logs using the industry-standard **Cadence Xcelium**.

## 3. Design & Environment
* **Language:** SystemVerilog
* **Target Simulator:** Cadence Xcelium 25.03
* **Memory Structure:** 16 x 8-bit Register Array (Abstraction of Cell Array)

## 4. Simulation Result (Xcelium Log)
TOOL: xrun 25.03-s001: Started on Feb 22, 2026  
xcelium> run  
[PASS] Addr 4: Expected A5, Got a5  
[PASS] Addr A: Expected 5A, Got 5a  
Simulation Finished!  
> **Result:** All test cases PASSED, proving data integrity.

## 5. Key Learning: Layout to DV Insights
* **Abstraction:** Learned to model complex physical cell arrays into logical 'reg arrays', understanding the core DV principle of balancing simulation speed and verification integrity.
* **Decoding Logic:** Conceived how Wordline/Bitline selection in layouts translates into **Address Decoding** in logic.
* **Timing Extension:** Bridged the gap between physical **Setup/Hold Time** and logical timing control using #1 delays and clock edge management.

---

<a name="한국어-버전"></a>
## 1. 프로젝트 개요 (한국어)
7.5년간의 **DRAM/Flash Layout Design 및 DFM/DRC/LVS** 경력을 바탕으로, 하드웨어의 물리적 구조를 논리적(Logical) 관점에서 모델링하고 검증하기 위한 첫 번째 프로젝트입니다. Cell Array의 데이터 저장 메커니즘을 **SystemVerilog**로 구현하여 DV 역량의 기초를 다졌습니다.

## 2. 검증 목표
* **데이터 무결성:** 특정 주소에 기록한 데이터가 읽기 시 유실 없이 출력되는지 확인.
* **동기화 검증:** 클럭 및 리셋 기반의 동기식 설계 동작 검증.
* **툴 숙련도:** 현업 표준인 **Cadence Xcelium** 환경 시뮬레이션 및 로그 분석.

## 3. 시뮬레이션 결과 (Xcelium Log)
[PASS] Addr 4: Expected A5, Got a5  
[PASS] Addr A: Expected 5A, Got 5a  
Simulation Finished!  
> **결과:** 모든 테스트 케이스 PASS, 설계 데이터 무결성 입증.

## 4. 주요 학습 포인트 (Key Learning)
* **구조의 추상화:** 물리적 Cell Array를 논리적 배열로 모델링하며 시뮬레이션 효율과 검증 정확도의 균형을 이해함.
* **디코딩 로직:** 레이아웃 패턴으로 보던 WL/BL 선택 과정이 논리 주소 디코딩으로 구현되는 과정을 학습함.
* **타이밍 개념 확장:** 물리 설계의 **Setup/Hold Time** 개념을 시뮬레이션 환경의 타이밍 제어로 연결하여 이해함.
