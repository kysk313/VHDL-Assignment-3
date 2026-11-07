-- Testbench for d_latch: q follows d while en = '1' and holds while en = '0'
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_d_latch IS
END tb_d_latch;

ARCHITECTURE sim OF tb_d_latch IS
  SIGNAL en, d : std_logic := '0';
  SIGNAL q, nq : std_logic;

  TYPE step_t IS RECORD
    en, d, q : std_logic;
  END RECORD;
  TYPE steps_t IS ARRAY (natural RANGE <>) OF step_t;
  CONSTANT STEPS : steps_t := (
    ('0', '0', '0'),   -- disabled, initial 0
    ('0', '1', '0'),   -- disabled: d changes, q holds 0
    ('1', '1', '1'),   -- enabled: q follows d = 1
    ('1', '0', '0'),   -- enabled: q follows d = 0
    ('1', '1', '1'),   -- enabled: q follows d = 1
    ('0', '1', '1'),   -- disabled: q holds 1
    ('0', '0', '1'),   -- disabled: d changes, q still 1
    ('0', '1', '1'),   -- disabled: q still 1
    ('1', '0', '0'),   -- enabled: q follows d = 0
    ('0', '1', '0')    -- disabled: q holds 0
  );
BEGIN
  uut : ENTITY work.d_latch PORT MAP (en => en, d => d, q => q, nq => nq);

  PROCESS
  BEGIN
    FOR i IN STEPS'RANGE LOOP
      en <= STEPS(i).en;
      d  <= STEPS(i).d;
      WAIT FOR 20 ns;
      ASSERT q = STEPS(i).q AND nq = NOT STEPS(i).q
        REPORT "d_latch error at step " & integer'image(i) SEVERITY error;
    END LOOP;
    REPORT "tb_d_latch finished";
    WAIT;
  END PROCESS;
END sim;
