-- VHDL Data Type Examples

-- Standard Logic
signal sig_A : std_logic := '0';
signal sig_B : std_logic := '1';
sig_A <= '1';
sig_A <= '0';
sig_A <= sig_B;

-- Standard Logic Vector
signal sig_C : std_logic_vector(5 downto 0) := "000000";
signal sid_D : std_logic_vector(5 downto 0) := (others => '1');
sig_C <= sig_D;
sig_C(3) <= sig_D(1);

-- Unsigned
signal sig_E : unsigned(3 downto 0) := (others => '0');
signal sig_F : unsigned(3 downto 0) := "0010"; -- 2
sig_E <= (others => '0');
sig_E <= sig_F + 1;

-- Signed
signal sig_G : signed(3 downto 0) := (others => '0'); -- 0
signal sig_H : signed(3 downto 0) := "1011"; -- -5
sig_G <= (others => '0');
sig_H <= sig_G - 1;

-- Integer
signal sig_I : integer range 0 to 255 := 0;
signal sig_J : integer range 0 to 255 := 5;
sig_I <= 4
sig_I <= sig_J + 5; -- 10