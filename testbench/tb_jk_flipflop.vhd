-- Testbench for jk_flipflop: Hold, Set, Reset and Toggle on rising clock edges
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY tb_jk_flipflop IS
END tb_jk_flipflop;

ARCHITECTURE sim OF tb_jk_flipflop IS
  SIGNAL clk, j, k : std_logic := '0';
  SIGNAL q, nq     : std_logic;

  TYPE cyc_t IS RECORD
    j, k, q : std_logic;   -- inputs before the edge, expected q after it
  END RECORD;
  TYPE cycs_t IS ARRAY (natural RANGE <>) OF cyc_t;
  CONSTANT CYCLES : cycs_t := (
    ('0', '0', '0'),   -- hold 0
    ('1', '0', '1'),   -- set
    ('0', '0', '1'),   -- hold 1
    ('0', '1', '0'),   -- reset
    ('1', '1', '1'),   -- toggle 0 -> 1
    ('1', '1', '0'),   -- toggle 1 -> 0
    ('1', '1', '1'),   -- toggle 0 -> 1
    ('0', '1', '0'),   -- reset
    ('0', '0', '0')    -- hold 0
  );
BEGIN
  uut : ENTITY work.jk_flipflop PORT MAP (clk => clk, j => j, k => k, q => q, nq => nq);

  PROCESS
    VARIABLE before : std_logic := '0';
  BEGIN
    FOR i IN CYCLES'RANGE LOOP
      j <= CYCLES(i).j;
      k <= CYCLES(i).k;
      WAIT FOR 10 ns;
      ASSERT q = before REPORT "q changed without a clock edge, cycle " & integer'image(i) SEVERITY error;
      clk <= '1';
      WAIT FOR 10 ns;
      ASSERT q = CYCLES(i).q AND nq = NOT CYCLES(i).q
        REPORT "jk error after edge, cycle " & integer'image(i) SEVERITY error;
      clk <= '0';
      before := CYCLES(i).q;
    END LOOP;
    WAIT FOR 10 ns;
    REPORT "tb_jk_flipflop finished";
    WAIT;
  END PROCESS;
END sim;
