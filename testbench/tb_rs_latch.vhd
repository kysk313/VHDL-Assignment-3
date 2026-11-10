LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_rs_latch IS
END tb_rs_latch;

ARCHITECTURE sim OF tb_rs_latch IS
  SIGNAL s, r  : std_logic := '0';
  SIGNAL q, nq : std_logic;
BEGIN
  uut : ENTITY work.rs_latch PORT MAP (s => s, r => r, q => q, nq => nq);

  PROCESS
  BEGIN
    s <= '0'; r <= '0'; WAIT FOR 20 ns;   -- hold
    ASSERT q = '0' AND nq = '1' REPORT "error: hold" SEVERITY error;
    s <= '1'; r <= '0'; WAIT FOR 20 ns;   -- set
    ASSERT q = '1' AND nq = '0' REPORT "error: set" SEVERITY error;
    s <= '0'; r <= '0'; WAIT FOR 20 ns;   -- hold
    ASSERT q = '1' AND nq = '0' REPORT "error: hold 1" SEVERITY error;
    s <= '0'; r <= '1'; WAIT FOR 20 ns;   -- reset
    ASSERT q = '0' AND nq = '1' REPORT "error: reset" SEVERITY error;
    s <= '0'; r <= '0'; WAIT FOR 20 ns;   -- hold
    ASSERT q = '0' AND nq = '1' REPORT "error: hold 0" SEVERITY error;
    s <= '1'; r <= '1'; WAIT FOR 20 ns;   -- forbidden (q = nq = 0)
    ASSERT q = '0' AND nq = '0' REPORT "error: s = r = 1" SEVERITY error;
    s <= '1'; r <= '0'; WAIT FOR 20 ns;   -- r goes low first -> set
    ASSERT q = '1' AND nq = '0' REPORT "error: set after forbidden" SEVERITY error;
    s <= '0'; r <= '0'; WAIT FOR 20 ns;   -- hold
    ASSERT q = '1' AND nq = '0' REPORT "error: hold 1" SEVERITY error;
    REPORT "tb_rs_latch finished";
    WAIT;
  END PROCESS;
END sim;
