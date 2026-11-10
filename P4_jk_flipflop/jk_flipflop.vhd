LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Positive-edge-triggered JK flip-flop
--   j k | q(t+1)
--   0 0 | q(t)       Hold
--   0 1 | 0          Reset
--   1 0 | 1          Set
--   1 1 | not q(t)   Toggle
-- Characteristic equation: q(t+1) = j·q' + k'·q
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
  SIGNAL nq_internal : std_logic;         -- NOT q
  SIGNAL nk          : std_logic;         -- NOT k
  SIGNAL set_term    : std_logic;         -- j AND q'
  SIGNAL hold_term   : std_logic;         -- k' AND q
  SIGNAL d_next      : std_logic;         -- Next state
BEGIN
  -- Drive the output ports with the internal signal
  q  <= q_internal;
  nq <= nq_internal;

  -- Next-state logic: d_next = j·q' + k'·q
  nq_internal <= NOT q_internal;
  nk          <= NOT k;
  set_term    <= j AND nq_internal;
  hold_term   <= nk AND q_internal;
  d_next      <= set_term OR hold_term;

  -- State register (rising edge of clk)
  PROCESS(clk)
  BEGIN
    IF rising_edge(clk) THEN
      q_internal <= d_next;
    END IF;
  END PROCESS;
END bhv;
