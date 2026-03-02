# Multi_Bank_DRAM_Model

[English](#english-version) | [한국어](#한국어-버전)

---

<a name="english-version"></a>
## 1. Project Overview (English)
This project extends the 2D memory matrix into a **Multi-Bank DRAM architecture**. By implementing a **3D memory hierarchy (Bank-Row-Column)**, I modeled how a 10-bit address bus is decoded to manage multiple independent memory banks.

## 2. Key Features
* **3D Memory Array:** 1,024-byte capacity using a `[4][16][16]` array structure.
* **Extended Decoding:** 10-bit address split into Bank[9:8], Row[7:4], and Column[3:0].
* **Bank Isolation:** Verified independent data access and stability across 4 discrete banks.

## 3. Design & Mapping
* **Bank (2-bit):** Selects one of four independent memory banks.
* **Row/Col (8-bit):** Defines the specific cell location within the selected bank.
* **Total Size:** 4 Banks × 16 Rows × 16 Columns × 8-bit = 1,024 Bytes.



## 4. Key Learning
* **Scalability:** Understood how physical memory is partitioned into banks to support larger capacities and future parallelism.
* **Address Mapping:** Mastered the logic of slicing a high-bit address bus into multi-dimensional indexes.
* **Timing Precision:** Applied the `#1` step-delay from Step 2 to ensure reliable synchronous sampling during bank switching.

## 5. Verification
* **Result:** Successfully passed all test cases covering all 4 banks with a consistent 1-clock read latency.
![Bank Verification Waveform](./bank_wave.png)

---

<a name="한국어-버전"></a>
## 1. 프로젝트 개요 (한국어)
기존의 2D 매트릭스 모델을 확장하여 **Multi-Bank DRAM 구조**를 구현했습니다. **3차원 메모리 계층(Bank-Row-Column)** 설계를 통해 10비트 주소 버스가 여러 개의 독립된 뱅크를 관리하기 위해 어떻게 디코딩되는지 모델링했습니다.

## 2. 주요 기능
* **3차원 메모리 어레이:** `[4][16][16]` 구조를 사용하여 총 1,024바이트 용량 구현.
* **확장된 디코딩:** 10비트 주소를 Bank[9:8], Row[7:4], Column[3:0]으로 분리 처리.
* **뱅크 독립성:** 4개의 개별 뱅크 간 데이터 간섭 없는 독립적 액세스 검증.

## 3. 설계 및 매핑
* **Bank (2비트):** 4개의 독립된 메모리 뱅크 중 하나를 선택.
* **Row/Col (8비트):** 선택된 뱅크 내의 세부 셀 위치를 결정.
* **전체 규모:** 4 뱅크 × 16 행 × 16 열 × 8비트 = 1,024 바이트.



## 4. 주요 학습 포인트
* **확장성:** 대용량 메모리 설계를 위해 물리적 구역을 '뱅크'로 나누는 구조적 이점을 이해함.
* **주소 매핑:** 고비트 주소 버스를 다차원 인덱스로 슬라이싱하는 로직을 숙달함.
* **타이밍 정밀도:** 2단계에서 배운 `#1` 지연 기법을 적용하여 뱅크 전환 시에도 안정적인 동기식 샘플링 확보.

## 5. 검증 결과
* **결과:** 4개 전체 뱅크에 대한 쓰기/읽기 테스트를 수행하여, 정확한 1-Clock Latency로 모든 케이스 통과(`PASS`).
![뱅크 검증 파형](./bank_wave.png)
