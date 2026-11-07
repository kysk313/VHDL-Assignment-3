LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- RS latch made of two cross-coupled NOR gates
--   s r | q        nq
--   0 0 | hold     hold
--   1 0 | 1        0      (set)
--   0 1 | 0        1      (reset)
--   1 1 | 0        0      (forbidden)
ENTITY rs_latch IS
  PORT (
    s  : IN  std_logic;   -- Set input
    r  : IN  std_logic;   -- Reset input
    q  : OUT std_logic;   -- Output
    nq : OUT std_logic    -- Complement output
  );
END rs_latch;

ARCHITECTURE bhv OF rs_latch IS
  SIGNAL q_internal  : std_logic := '0';   -- Internal signal to represent output q
  SIGNAL nq_internal : std_logic := '1';   -- Internal signal to represent output nq
BEGIN
  q_internal  <= r NOR nq_internal;   -- NOR gate 1
  nq_internal <= s NOR q_internal;    -- NOR gate 2

  q  <= q_internal;
  nq <= nq_internal;
END bhv;
