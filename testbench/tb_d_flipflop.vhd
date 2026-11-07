-- Testbench for d_flipflop: q changes only on the rising edge of clk
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_d_flipflop IS
END tb_d_flipflop;

ARCHITECTURE sim OF tb_d_flipflop IS
  SIGNAL clk, d : std_logic := '0';
  SIGNAL q, nq  : std_logic;

  -- d value applied while clk = '0', d value applied while clk = '1' (must be ignored)
  TYPE cyc_t IS RECORD
    d_low, d_high : std_logic;
  END RECORD;
  TYPE cycs_t IS ARRAY (natural RANGE <>) OF cyc_t;
  CONSTANT CYCLES : cycs_t := (('1', '0'), ('0', '1'), ('1', '1'), ('1', '0'), ('0', '0'), ('1', '0'));
BEGIN
  uut : ENTITY work.d_flipflop PORT MAP (clk => clk, d => d, q => q, nq => nq);

  PROCESS
    VARIABLE expect : std_logic := '0';
  BEGIN
    FOR i IN CYCLES'RANGE LOOP
      -- clk low: change d, q must not change
      d <= CYCLES(i).d_low;
      WAIT FOR 10 ns;
      ASSERT q = expect REPORT "q changed without a clock edge, cycle " & integer'image(i) SEVERITY error;
      -- rising edge: q takes d
      clk <= '1';
      expect := CYCLES(i).d_low;
      WAIT FOR 5 ns;
      ASSERT q = expect AND nq = NOT expect
        REPORT "q not updated on rising edge, cycle " & integer'image(i) SEVERITY error;
      -- clk high: change d, q must not change
      d <= CYCLES(i).d_high;
      WAIT FOR 5 ns;
      ASSERT q = expect REPORT "q changed while clk = 1, cycle " & integer'image(i) SEVERITY error;
      -- falling edge: q must not change
      clk <= '0';
      WAIT FOR 5 ns;
      ASSERT q = expect REPORT "q changed on falling edge, cycle " & integer'image(i) SEVERITY error;
      WAIT FOR 5 ns;
    END LOOP;
    REPORT "tb_d_flipflop finished";
    WAIT;
  END PROCESS;
END sim;
