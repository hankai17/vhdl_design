library ieee;
use ieee.std_logic_1164.all;
entity contrla is
port( clock:in std_logic;
      reset:in std_logic;
instrReg:in std_logic_vector(15 downto 0);
compout:in std_logic;
progCntrWr: out std_logic;
progCntrRd: out std_logic;
addrRegWr:out std_logic;
addrRegRd:out std_logic;
outRegWr: out std_logic;
outRegRd: out std_logic;
shiftSel: out std_logic_vector(2 downto 0);
aluSel: out std_logic_vector(3 downto 0);
compSel:out std_logic_vector(2 downto 0);
opRegRd:out std_logic;
opRegWr:out std_logic;
instrWr:out std_logic;
regSel:out std_logic_vector(2 downto 0);
regRd:out std_logic;
regWr:out std_logic;
rw:out std_logic;
vma:out std_logic);
end contrla;
architecture rtl of contrala is
constant shftpass:std_logic_vector(2 downto 0):="000";
constant alupass:std_logic_vector(3 downto 0):="0000";
constant zero:std_logic_vector(3 downto 0):="1001";
constant inc:std_logic_vector(3 downto 0):="0111";
constant plus:std_logic_vector(3 downto 0):="0101";
type state is(reset1,reset2,reset3,execute,nop,load,store,load2,load3,load4,store2,store3,store4,incPc,incPc2,incPc3,loadI2,loadI3,loadI4,loadI5,loadI6,inc2,inc3,inc4,move1,move2,
add2,add3,add4);
signal current_state,next_state:state;
begin
process(current_state,instrReg,compout)
begin
progCntrWr<='0'; progCntrRd<='0';addrRegWr<='0';addrRegRd<='0';outRegWr<='0';outRegRd<='0';
shiftSel<=shftpass;aluSel<=alupass;opRegRd<='0';opRegWr<='0';instrWr<='0';regSel<='000';
regRd<='0';regWr<='0';rw<='0';vma<='0';
case current_state is
when reset1=> aluSel<=zero;shiftSel<=shftpass;outRegWr<='1';next_state<=reset2;
when reset2=> outRegRd<='1';progCntrWr<='1';addrRegWr<='1';next_state<=reset3;
when reset3=>vma<='1';rw<='0';instrWr<='1';next_state<=execute;
when execute=>
case instrReg(15 downto 11)is
when"00000"=>next_state<=incPc;
when"00001"=>next_state<=load2;
when"00010"=>next_state<=store2;
when"00100"=>progcntrRd<='1';alusel<inc;shiftsel<=shftpass;next_state<=loadI2;
when"00111"=>next_state<=inc2;
when"01101"=>next_state<=add2;
when"00011"=>next_state<=move1;
when others=>next_state<=incPc;
end case;
when load2=>regSel<=instrReg(5 downto 3);regRd<='1';addrregWr<='1';next_state<=load3;
when load3=>vma<='1';rw<='0';regSel<=instrReg(2 downto 0);regWr<='1';next_state<=incPc;
when add2=>regSel<=instrReg(5 downto 3);regRd<='1';next_state<=add3;opRegWr<='1';
when add3=>regSel<=instrReg(2 downto 0);regRd<='1';alusel<=plus;shiftsel<=shftpass;outRegWr<='1';next_state<=add4;
when add4=>regSel<="011";









































