LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- RS latch (NOR)
ENTITY rs_latch IS
  PORT (
    s  : IN  std_logic;   -- Set input
    r  : IN  std_logic;   -- Reset input
    q  : OUT std_logic;   -- Output
    nq : OUT std_logic    -- Complement output
  );
END rs_latch;

ARCHITECTURE bhv OF rs_latch IS
  SIGNAL q_internal  : std_logic := '0';
  SIGNAL nq_internal : std_logic := '1';
BEGIN
  q_internal  <= r NOR nq_internal;
  nq_internal <= s NOR q_internal;

  q  <= q_internal;
  nq <= nq_internal;
END bhv;
