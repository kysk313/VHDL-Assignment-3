LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Positive-edge-triggered JK flip-flop
--   j k | q(t+1)
--   0 0 | q(t)       Hold
--   0 1 | 0          Reset
--   1 0 | 1          Set
--   1 1 | not q(t)   Toggle
ENTITY jk_flipflop IS
  PORT (
    clk : IN  std_logic;   -- Clock signal
    j   : IN  std_logic;   -- J input
    k   : IN  std_logic;   -- K input
    q   : OUT std_logic;   -- Output
    nq  : OUT std_logic    -- Complement output
  );
END jk_flipflop;

ARCHITECTURE bhv OF jk_flipflop IS
  SIGNAL q_internal : std_logic := '0';   -- Internal signal to represent output q
BEGIN
  -- Drive the output ports with the internal signal
  q  <= q_internal;
  nq <= NOT q_internal;

  PROCESS(clk)
  BEGIN
    IF rising_edge(clk) THEN
      IF (j = '1' AND k = '0') THEN
        q_internal <= '1';               -- Set
      ELSIF (j = '0' AND k = '1') THEN
        q_internal <= '0';               -- Reset
      ELSIF (j = '1' AND k = '1') THEN
        q_internal <= NOT q_internal;    -- Toggle
      END IF;                            -- j = k = '0' : Hold
    END IF;
  END PROCESS;
END bhv;
