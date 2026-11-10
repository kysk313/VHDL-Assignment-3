LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_d_flipflop IS
END tb_d_flipflop;

ARCHITECTURE sim OF tb_d_flipflop IS
  SIGNAL clk, d : std_logic := '0';
  SIGNAL q, nq  : std_logic;
BEGIN
  uut : ENTITY work.d_flipflop PORT MAP (clk => clk, d => d, q => q, nq => nq);

  -- one cycle = 30 ns : d changes while clk = 0, rising edge, d changes while clk = 1
  PROCESS
  BEGIN
    -- edge at 10 ns, d = 1
    d <= '1'; WAIT FOR 10 ns;
    ASSERT q = '0' REPORT "error: q changed before edge" SEVERITY error;
    clk <= '1'; WAIT FOR 5 ns;
    ASSERT q = '1' REPORT "error: edge 10 ns" SEVERITY error;
    d <= '0'; WAIT FOR 5 ns;
    clk <= '0'; WAIT FOR 10 ns;
    ASSERT q = '1' REPORT "error: q changed without edge" SEVERITY error;

    -- edge at 40 ns, d = 0
    d <= '0'; WAIT FOR 10 ns;
    clk <= '1'; WAIT FOR 5 ns;
    ASSERT q = '0' REPORT "error: edge 40 ns" SEVERITY error;
    d <= '1'; WAIT FOR 5 ns;
    clk <= '0'; WAIT FOR 10 ns;
    ASSERT q = '0' REPORT "error: q changed without edge" SEVERITY error;

    -- edge at 70 ns, d = 1
    d <= '1'; WAIT FOR 10 ns;
    clk <= '1'; WAIT FOR 5 ns;
    ASSERT q = '1' REPORT "error: edge 70 ns" SEVERITY error;
    d <= '1'; WAIT FOR 5 ns;
    clk <= '0'; WAIT FOR 10 ns;

    -- edge at 100 ns, d = 1
    d <= '1'; WAIT FOR 10 ns;
    clk <= '1'; WAIT FOR 5 ns;
    ASSERT q = '1' REPORT "error: edge 100 ns" SEVERITY error;
    d <= '0'; WAIT FOR 5 ns;
    clk <= '0'; WAIT FOR 10 ns;
    ASSERT q = '1' REPORT "error: q changed without edge" SEVERITY error;

    -- edge at 130 ns, d = 0
    d <= '0'; WAIT FOR 10 ns;
    clk <= '1'; WAIT FOR 5 ns;
    ASSERT q = '0' REPORT "error: edge 130 ns" SEVERITY error;
    d <= '0'; WAIT FOR 5 ns;
    clk <= '0'; WAIT FOR 10 ns;

    -- edge at 160 ns, d = 1
    d <= '1'; WAIT FOR 10 ns;
    clk <= '1'; WAIT FOR 5 ns;
    ASSERT q = '1' AND nq = '0' REPORT "error: edge 160 ns" SEVERITY error;
    d <= '0'; WAIT FOR 5 ns;
    clk <= '0'; WAIT FOR 10 ns;
    ASSERT q = '1' REPORT "error: q changed without edge" SEVERITY error;

    REPORT "tb_d_flipflop finished";
    WAIT;
  END PROCESS;
END sim;
