LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- D flip-flop with asynchronous set / clear (clr first)
ENTITY d_flipflop_sc IS
  PORT (
    clk : IN  std_logic;   -- Clock signal
    d   : IN  std_logic;   -- Data input
    clr : IN  std_logic;   -- Asynchronous clear
    set : IN  std_logic;   -- Asynchronous set
    q   : OUT std_logic;   -- Output
    nq  : OUT std_logic    -- Complement output
  );
END d_flipflop_sc;

ARCHITECTURE bhv OF d_flipflop_sc IS
  SIGNAL q_internal : std_logic := '0';
BEGIN
  q  <= q_internal;
  nq <= NOT q_internal;

  PROCESS(clk, clr, set)
  BEGIN
    IF clr = '1' THEN
      q_internal <= '0';
    ELSIF set = '1' THEN
      q_internal <= '1';
    ELSIF rising_edge(clk) THEN
      q_internal <= d;
    END IF;
  END PROCESS;
END bhv;
