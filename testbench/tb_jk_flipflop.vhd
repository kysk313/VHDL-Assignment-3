LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_jk_flipflop IS
END tb_jk_flipflop;

ARCHITECTURE sim OF tb_jk_flipflop IS
  SIGNAL clk, j, k : std_logic := '0';
  SIGNAL q, nq     : std_logic;
BEGIN
  uut : ENTITY work.jk_flipflop PORT MAP (clk => clk, j => j, k => k, q => q, nq => nq);

  -- j, k are set while clk = 0, then a rising edge every 20 ns (10, 30, 50, ...)
  PROCESS
  BEGIN
    j <= '0'; k <= '0'; WAIT FOR 10 ns; clk <= '1'; WAIT FOR 10 ns;   -- hold
    ASSERT q = '0' REPORT "error: hold 0" SEVERITY error;
    clk <= '0';
    j <= '1'; k <= '0'; WAIT FOR 10 ns; clk <= '1'; WAIT FOR 10 ns;   -- set
    ASSERT q = '1' REPORT "error: set" SEVERITY error;
    clk <= '0';
    j <= '0'; k <= '0'; WAIT FOR 10 ns; clk <= '1'; WAIT FOR 10 ns;   -- hold
    ASSERT q = '1' REPORT "error: hold 1" SEVERITY error;
    clk <= '0';
    j <= '0'; k <= '1'; WAIT FOR 10 ns; clk <= '1'; WAIT FOR 10 ns;   -- reset
    ASSERT q = '0' REPORT "error: reset" SEVERITY error;
    clk <= '0';
    j <= '1'; k <= '1'; WAIT FOR 10 ns; clk <= '1'; WAIT FOR 10 ns;   -- toggle
    ASSERT q = '1' REPORT "error: toggle 0 -> 1" SEVERITY error;
    clk <= '0';
    j <= '1'; k <= '1'; WAIT FOR 10 ns; clk <= '1'; WAIT FOR 10 ns;   -- toggle
    ASSERT q = '0' REPORT "error: toggle 1 -> 0" SEVERITY error;
    clk <= '0';
    j <= '1'; k <= '1'; WAIT FOR 10 ns; clk <= '1'; WAIT FOR 10 ns;   -- toggle
    ASSERT q = '1' REPORT "error: toggle 0 -> 1" SEVERITY error;
    clk <= '0';
    j <= '0'; k <= '1'; WAIT FOR 10 ns; clk <= '1'; WAIT FOR 10 ns;   -- reset
    ASSERT q = '0' REPORT "error: reset" SEVERITY error;
    clk <= '0';
    j <= '0'; k <= '0'; WAIT FOR 10 ns; clk <= '1'; WAIT FOR 10 ns;   -- hold
    ASSERT q = '0' AND nq = '1' REPORT "error: hold 0" SEVERITY error;
    clk <= '0';
    WAIT FOR 10 ns;
    REPORT "tb_jk_flipflop finished";
    WAIT;
  END PROCESS;
END sim;
