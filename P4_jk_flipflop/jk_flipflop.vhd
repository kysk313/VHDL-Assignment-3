LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- JK flip-flop (rising edge)
-- next state : q+ = j q' + k' q
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
  SIGNAL q_internal  : std_logic := '0';
  SIGNAL nq_internal : std_logic;
  SIGNAL nk          : std_logic;
  SIGNAL set_term    : std_logic;
  SIGNAL hold_term   : std_logic;
  SIGNAL d_next      : std_logic;
BEGIN
  q  <= q_internal;
  nq <= nq_internal;

  nq_internal <= NOT q_internal;
  nk          <= NOT k;
  set_term    <= j AND nq_internal;
  hold_term   <= nk AND q_internal;
  d_next      <= set_term OR hold_term;

  PROCESS(clk)
  BEGIN
    IF rising_edge(clk) THEN
      q_internal <= d_next;
    END IF;
  END PROCESS;
END bhv;
