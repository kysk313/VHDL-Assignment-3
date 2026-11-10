LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- D flip-flop (rising edge)
ENTITY d_flipflop IS
  PORT (
    clk : IN  std_logic;   -- Clock signal
    d   : IN  std_logic;   -- Data input
    q   : OUT std_logic;   -- Output
    nq  : OUT std_logic    -- Complement output
  );
END d_flipflop;

ARCHITECTURE bhv OF d_flipflop IS
  SIGNAL q_internal : std_logic := '0';
BEGIN
  q  <= q_internal;
  nq <= NOT q_internal;

  PROCESS(clk)
  BEGIN
    IF rising_edge(clk) THEN
      q_internal <= d;
    END IF;
  END PROCESS;
END bhv;
