LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_d_flipflop_sc IS
END tb_d_flipflop_sc;

ARCHITECTURE sim OF tb_d_flipflop_sc IS
  SIGNAL clk, d, clr, set : std_logic := '0';
  SIGNAL q, nq            : std_logic;
BEGIN
  uut : ENTITY work.d_flipflop_sc PORT MAP (clk => clk, d => d, clr => clr, set => set, q => q, nq => nq);

  PROCESS
  BEGIN
    -- normal D flip-flop
    d <= '1'; WAIT FOR 10 ns;
    ASSERT q = '0' REPORT "error: no edge yet" SEVERITY error;
    clk <= '1'; WAIT FOR 10 ns;
    ASSERT q = '1' REPORT "error: edge, d = 1" SEVERITY error;
    clk <= '0'; WAIT FOR 10 ns;

    -- clr = 1 : q = 0 without clock
    clr <= '1'; WAIT FOR 5 ns;
    ASSERT q = '0' REPORT "error: clr" SEVERITY error;
    clk <= '1'; WAIT FOR 10 ns;
    ASSERT q = '0' REPORT "error: clr on edge" SEVERITY error;
    clk <= '0'; clr <= '0'; WAIT FOR 10 ns;
    ASSERT q = '0' REPORT "error: after clr" SEVERITY error;

    -- set = 1 : q = 1 without clock
    d <= '0';
    set <= '1'; WAIT FOR 5 ns;
    ASSERT q = '1' REPORT "error: set" SEVERITY error;
    clk <= '1'; WAIT FOR 10 ns;
    ASSERT q = '1' REPORT "error: set on edge (d = 0)" SEVERITY error;
    clk <= '0'; WAIT FOR 5 ns;

    -- clr and set together : clr first
    clr <= '1'; WAIT FOR 10 ns;
    ASSERT q = '0' REPORT "error: clr priority" SEVERITY error;
    clr <= '0'; WAIT FOR 10 ns;
    ASSERT q = '1' REPORT "error: set only" SEVERITY error;
    set <= '0'; WAIT FOR 5 ns;
    ASSERT q = '1' REPORT "error: hold after set" SEVERITY error;

    -- normal D flip-flop again
    clk <= '1'; WAIT FOR 10 ns;
    ASSERT q = '0' REPORT "error: edge, d = 0" SEVERITY error;
    clk <= '0'; d <= '1'; WAIT FOR 10 ns;
    ASSERT q = '0' REPORT "error: d change without edge" SEVERITY error;
    clk <= '1'; WAIT FOR 10 ns;
    ASSERT q = '1' AND nq = '0' REPORT "error: edge, d = 1" SEVERITY error;
    clk <= '0'; WAIT FOR 10 ns;
    REPORT "tb_d_flipflop_sc finished";
    WAIT;
  END PROCESS;
END sim;
