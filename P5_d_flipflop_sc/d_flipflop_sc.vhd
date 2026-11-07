LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Positive-edge-triggered D flip-flop with asynchronous Set and Clear
--   clr = '1'           -> q = '0' immediately (highest priority)
--   set = '1', clr = '0' -> q = '1' immediately
--   otherwise           -> normal D flip-flop
ENTITY d_flipflop_sc IS
  PORT (
    clk : IN  std_logic;   -- Clock signal
    d   : IN  std_logic;   -- Data input
    clr : IN  std_logic;   -- Asynchronous clear signal
    set : IN  std_logic;   -- Asynchronous set signal
    q   : OUT std_logic;   -- Output
    nq  : OUT std_logic    -- Complement output
  );
END d_flipflop_sc;

ARCHITECTURE bhv OF d_flipflop_sc IS
  SIGNAL q_internal : std_logic := '0';   -- Internal signal to represent output q
BEGIN
  q  <= q_internal;
  nq <= NOT q_internal;

  PROCESS(clk, clr, set)   -- Include clr and set for asynchronous handling
  BEGIN
    -- Asynchronous clear has the highest priority
    IF clr = '1' THEN
      q_internal <= '0';
    -- Asynchronous set has the second-highest priority
    ELSIF set = '1' THEN
      q_internal <= '1';
    -- Synchronous clock-based behavior
    ELSIF rising_edge(clk) THEN
      q_internal <= d;
    END IF;
  END PROCESS;
END bhv;
