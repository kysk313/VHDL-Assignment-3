# VHDL Assignment-3 · Latch & Flip-Flop

Digital Logic Circuit Design · 김우준 (2023092479)

각 문제를 **Logisim 게이트 수준 회로**(래치·플립플롭 내장 부품 미사용)와 **VHDL 코드** 두 가지로 구현했습니다.

| 문제 | 회로 | VHDL 소스 | Logisim 프로젝트 (게이트 구성) |
|---|---|---|---|
| 1 | RS Latch | [rs_latch.vhd](P1_rs_latch/rs_latch.vhd) | [rs_latch.circ](P1_rs_latch/rs_latch.circ) (NOR 2) |
| 2 | D Latch (enable) | [d_latch.vhd](P2_d_latch/d_latch.vhd) | [d_latch.circ](P2_d_latch/d_latch.circ) (NAND 4, NOT 1) |
| 3 | D Flip-Flop (rising edge) | [d_flipflop.vhd](P3_d_flipflop/d_flipflop.vhd) | [d_flipflop.circ](P3_d_flipflop/d_flipflop.circ) (Master-Slave: D Latch 2 + inverter) |
| 4 | JK Flip-Flop (rising edge) | [jk_flipflop.vhd](P4_jk_flipflop/jk_flipflop.vhd) | [jk_flipflop.circ](P4_jk_flipflop/jk_flipflop.circ) (NAND 11, NOT 4, feedback) |
| 5 | D Flip-Flop + async Set/Clear | [d_flipflop_sc.vhd](P5_d_flipflop_sc/d_flipflop_sc.vhd) | [d_flipflop_sc.circ](P5_d_flipflop_sc/d_flipflop_sc.circ) (3-input NAND latches, Clear priority) |

- 보고서 (회로도, 합성 회로도, 시뮬레이션 결과): [VHDL_Assignment_3_Report.pdf](VHDL_Assignment_3_Report.pdf)
- 테스트벤치 (Questa): [testbench/](testbench)

## Logisim에서 확인하는 방법

1. `.circ` 파일을 Logisim-evolution에서 엽니다.
2. 게이트로 만든 래치는 처음에 상태가 정해지지 않아 Q/NQ가 빨간색(E)으로 보입니다. Reset 입력(R, CLR 등)을 한 번 넣으면 정상 값이 됩니다.
3. Poke Tool(손 모양)로 입력 핀을 클릭해 값을 바꿉니다. 플립플롭은 CLK 핀을 0 → 1로 바꿀 때 동작합니다.
