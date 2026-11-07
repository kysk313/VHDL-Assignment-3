-- Testbench for rs_latch: Hold, Set, Reset and the forbidden input (s = r = 1)
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_rs_latch IS
END tb_rs_latch;

ARCHITECTURE sim OF tb_rs_latch IS
  SIGNAL s, r  : std_logic := '0';
  SIGNAL q, nq : std_logic;

  TYPE step_t IS RECORD
    s, r, q, nq : std_logic;
  END RECORD;
  TYPE steps_t IS ARRAY (natural RANGE <>) OF step_t;
  CONSTANT STEPS : steps_t := (
    ('0', '0', '0', '1'),   -- hold (initial state)
    ('1', '0', '1', '0'),   -- set
    ('0', '0', '1', '0'),   -- hold 1
    ('0', '1', '0', '1'),   -- reset
    ('0', '0', '0', '1'),   -- hold 0
    ('1', '1', '0', '0'),   -- forbidden: q = nq = 0
    ('1', '0', '1', '0'),   -- leave forbidden by releasing r first -> set
    ('0', '0', '1', '0')    -- hold 1
  );
BEGIN
  uut : ENTITY work.rs_latch PORT MAP (s => s, r => r, q => q, nq => nq);

  PROCESS
  BEGIN
    FOR i IN STEPS'RANGE LOOP
      s <= STEPS(i).s;
      r <= STEPS(i).r;
      WAIT FOR 20 ns;
      ASSERT q = STEPS(i).q AND nq = STEPS(i).nq
        REPORT "rs_latch error at step " & integer'image(i) SEVERITY error;
    END LOOP;
    REPORT "tb_rs_latch finished";
    WAIT;
  END PROCESS;
END sim;
