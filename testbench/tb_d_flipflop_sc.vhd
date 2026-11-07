-- Testbench for d_flipflop_sc: asynchronous clear / set (clear has priority) and normal D operation
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_d_flipflop_sc IS
END tb_d_flipflop_sc;

ARCHITECTURE sim OF tb_d_flipflop_sc IS
  SIGNAL clk, d, clr, set : std_logic := '0';
  SIGNAL q, nq            : std_logic;

  PROCEDURE check(SIGNAL q, nq : IN std_logic; expect : std_logic; msg : string) IS
  BEGIN
    ASSERT q = expect AND nq = NOT expect REPORT "d_flipflop_sc error: " & msg SEVERITY error;
  END PROCEDURE;
BEGIN
  uut : ENTITY work.d_flipflop_sc PORT MAP (clk => clk, d => d, clr => clr, set => set, q => q, nq => nq);

  PROCESS
  BEGIN
    -- 1) normal D flip-flop: d = 1 captured on the rising edge
    d <= '1';            WAIT FOR 10 ns;  check(q, nq, '0', "no edge yet");
    clk <= '1';          WAIT FOR 10 ns;  check(q, nq, '1', "rising edge d=1");
    clk <= '0';          WAIT FOR 10 ns;
    -- 2) asynchronous clear without any clock edge
    clr <= '1';          WAIT FOR 5 ns;   check(q, nq, '0', "clr immediately 0");
    clk <= '1';          WAIT FOR 10 ns;  check(q, nq, '0', "clr holds 0 on edge");
    clk <= '0';          clr <= '0';      WAIT FOR 10 ns;  check(q, nq, '0', "after clr");
    -- 3) asynchronous set without any clock edge
    d <= '0';
    set <= '1';          WAIT FOR 5 ns;   check(q, nq, '1', "set immediately 1");
    clk <= '1';          WAIT FOR 10 ns;  check(q, nq, '1', "set holds 1 on edge (d=0)");
    clk <= '0';          WAIT FOR 5 ns;
    -- 4) clear and set together: clear wins
    clr <= '1';          WAIT FOR 10 ns;  check(q, nq, '0', "clr has priority over set");
    clr <= '0';          WAIT FOR 10 ns;  check(q, nq, '1', "set alone again");
    set <= '0';          WAIT FOR 5 ns;   check(q, nq, '1', "set released, holds 1");
    -- 5) back to normal D operation
    clk <= '1';          WAIT FOR 10 ns;  check(q, nq, '0', "rising edge d=0");
    clk <= '0';  d <= '1';  WAIT FOR 10 ns;  check(q, nq, '0', "d change without edge");
    clk <= '1';          WAIT FOR 10 ns;  check(q, nq, '1', "rising edge d=1");
    clk <= '0';          WAIT FOR 10 ns;
    REPORT "tb_d_flipflop_sc finished";
    WAIT;
  END PROCESS;
END sim;
