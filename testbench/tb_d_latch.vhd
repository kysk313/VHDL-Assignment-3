LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_d_latch IS
END tb_d_latch;

ARCHITECTURE sim OF tb_d_latch IS
  SIGNAL en, d : std_logic := '0';
  SIGNAL q, nq : std_logic;
BEGIN
  uut : ENTITY work.d_latch PORT MAP (en => en, d => d, q => q, nq => nq);

  PROCESS
  BEGIN
    en <= '0'; d <= '0'; WAIT FOR 20 ns;
    ASSERT q = '0' REPORT "error: initial" SEVERITY error;
    en <= '0'; d <= '1'; WAIT FOR 20 ns;   -- en = 0 : q holds
    ASSERT q = '0' REPORT "error: hold 0" SEVERITY error;
    en <= '1'; d <= '1'; WAIT FOR 20 ns;   -- en = 1 : q = d
    ASSERT q = '1' REPORT "error: q = d (1)" SEVERITY error;
    en <= '1'; d <= '0'; WAIT FOR 20 ns;
    ASSERT q = '0' REPORT "error: q = d (0)" SEVERITY error;
    en <= '1'; d <= '1'; WAIT FOR 20 ns;
    ASSERT q = '1' REPORT "error: q = d (1)" SEVERITY error;
    en <= '0'; d <= '1'; WAIT FOR 20 ns;   -- en = 0 : q holds 1
    ASSERT q = '1' REPORT "error: hold 1" SEVERITY error;
    en <= '0'; d <= '0'; WAIT FOR 20 ns;
    ASSERT q = '1' REPORT "error: hold 1" SEVERITY error;
    en <= '0'; d <= '1'; WAIT FOR 20 ns;
    ASSERT q = '1' REPORT "error: hold 1" SEVERITY error;
    en <= '1'; d <= '0'; WAIT FOR 20 ns;
    ASSERT q = '0' REPORT "error: q = d (0)" SEVERITY error;
    en <= '0'; d <= '1'; WAIT FOR 20 ns;   -- en = 0 : q holds 0
    ASSERT q = '0' AND nq = '1' REPORT "error: hold 0" SEVERITY error;
    REPORT "tb_d_latch finished";
    WAIT;
  END PROCESS;
END sim;
