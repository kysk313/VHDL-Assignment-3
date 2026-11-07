LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- D latch with enable: q follows d while en = '1', holds while en = '0'
ENTITY d_latch IS
  PORT (
    en : IN  std_logic;   -- Enable signal
    d  : IN  std_logic;   -- Data input
    q  : OUT std_logic;   -- Output
    nq : OUT std_logic    -- Complement output
  );
END d_latch;

ARCHITECTURE bhv OF d_latch IS
  SIGNAL q_internal : std_logic := '0';   -- Internal signal to represent output q
BEGIN
  q  <= q_internal;
  nq <= NOT q_internal;

  PROCESS(en, d)
  BEGIN
    IF (en = '1') THEN
      q_internal <= d;
    END IF;
  END PROCESS;
END bhv;
