
10进制计数器
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity counter10 is
	port(  fx,clr,en:in std_logic;
                        q:out std_logic_vector(3 downto 0);
                        co:out std_logic);
end counter10;
architecture behav of counter10 is
signal cnt0:std_logic_vector(3 downto 0);
signal cnt1:std_logic;
  begin
	process(fx,clr)
	begin
		if clr='1' then cnt0<="0000";cnt1<='0';
		elsif fx'event and fx='1' then 
			if en='1' then
               if cnt0="1001" then cnt1<='1';cnt0<="0000";
               else cnt0<=cnt0+1; cnt1<='0';end if;
            end if;
            end if;
            end process;
            q<=cnt0;co<=cnt1;
            end behav;   


8——10进制计数器
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity fcount is
	port(fx1,clr1,en1:in std_logic;
          q1,q2,q3,q4,q5,q6,q7,q8:out std_logic_vector(3 downto 0);
                co1:out std_logic);
end fcount;
architecture behav of fcount is
	component counter10
		port( fx,clr,en:in std_logic;
                        q:out std_logic_vector(3 downto 0);
                        co:out std_logic);
	end component;
        signal net1,net2,net3,net4,net5,net6,net7 : std_logic;
begin 
u1:counter10 port map(fx=>fx1,clr=>clr1,en=>en1,q=>q1,co=>net1);
u2:counter10 port map(fx=>net1,clr=>clr1,en=>en1,q=>q2,co=>net2);
u3:counter10 port map(fx=>net2,clr=>clr1,en=>en1,q=>q3,co=>net3);
u4:counter10 port map(fx=>net3,clr=>clr1,en=>en1,q=>q4,co=>net4);
u5:counter10 port map(fx=>net4,clr=>clr1,en=>en1,q=>q5,co=>net5);
u6:counter10 port map(fx=>net5,clr=>clr1,en=>en1,q=>q6,co=>net6);
u7:counter10 port map(fx=>net6,clr=>clr1,en=>en1,q=>q7,co=>net7);
u8:counter10 port map(fx=>net7,clr=>clr1,en=>en1,q=>q8,co=>co1);
end behav;

led灯电路
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity led is 
port( w1,w2,w3,w4,w5,w6,w7,w8:in std_logic_vector(3 downto 0);
      e1,e2,e3,e4,e5,e6,e7,e8:out std_logic_vector(3 downto 0);
      load:in std_logic);
end led;
architecture behav of led is
begin
   process(load)
      begin
      if load'event and load='1' then
      case w1 is
            when"0000"=>e1<="0000";
            when"0001"=>e1<="0001";
            when"0010"=>e1<="0010";
            when"0011"=>e1<="0011";
            when"0100"=>e1<="0100";
            when"0101"=>e1<="0101";
            when"0110"=>e1<="0110";
            when"0111"=>e1<="0111";
            when"1000"=>e1<="1000";
            when"1001"=>e1<="1001";
            when"1010"=>e1<="1010";
            when"1011"=>e1<="1011";
            when"1100"=>e1<="1100";
            when"1101"=>e1<="1101";
            when"1110"=>e1<="1110";
            when"1111"=>e1<="1111";
            when others=>e1<="0000";
      end case;
      case w2 is
            when"0000"=>e2<="0000";
            when"0001"=>e2<="0001";
            when"0010"=>e2<="0010";
            when"0011"=>e2<="0011";
            when"0100"=>e2<="0100";
            when"0101"=>e2<="0101";
            when"0110"=>e2<="0110";
            when"0111"=>e2<="0111";
            when"1000"=>e2<="1000";
            when"1001"=>e2<="1001";
            when"1010"=>e2<="1010";
            when"1011"=>e2<="1011";
            when"1100"=>e2<="1100";
            when"1101"=>e2<="1101";
            when"1110"=>e2<="1110";
            when"1111"=>e2<="1111";
            when others=>e2<="0000";
      end case;
      case w3 is
           when"0000"=>e3<="0000";
            when"0001"=>e3<="0001";
            when"0010"=>e3<="0010";
            when"0011"=>e3<="0011";
            when"0100"=>e3<="0100";
            when"0101"=>e3<="0101";
            when"0110"=>e3<="0110";
            when"0111"=>e3<="0111";
            when"1000"=>e3<="1000";
            when"1001"=>e3<="1001";
            when"1010"=>e3<="1010";
            when"1011"=>e3<="1011";
            when"1100"=>e3<="1100";
            when"1101"=>e3<="1101";
            when"1110"=>e3<="1110";
            when"1111"=>e3<="1111";
            when others=>e3<="0000";
      end case;
      case w4 is
            when"0000"=>e4<="0000";
            when"0001"=>e4<="0001";
            when"0010"=>e4<="0010";
            when"0011"=>e4<="0011";
            when"0100"=>e4<="0100";
            when"0101"=>e4<="0101";
            when"0110"=>e4<="0110";
            when"0111"=>e4<="0111";
            when"1000"=>e4<="1000";
            when"1001"=>e4<="1001";
            when"1010"=>e4<="1010";
            when"1011"=>e4<="1011";
            when"1100"=>e4<="1100";
            when"1101"=>e4<="1101";
            when"1110"=>e4<="1110";
            when"1111"=>e4<="1111";
            when others=>e4<="0000";
      end case;
      case w5 is
            when"0000"=>e5<="0000";
            when"0001"=>e5<="0001";
            when"0010"=>e5<="0010";
            when"0011"=>e5<="0011";
            when"0100"=>e5<="0100";
            when"0101"=>e5<="0101";
            when"0110"=>e5<="0110";
            when"0111"=>e5<="0111";
            when"1000"=>e5<="1000";
            when"1001"=>e5<="1001";
            when"1010"=>e5<="1010";
            when"1011"=>e5<="1011";
            when"1100"=>e5<="1100";
            when"1101"=>e5<="1101";
            when"1110"=>e5<="1110";
            when"1111"=>e5<="1111";
            when others=>e5<="0000";
      end case;
      case w6 is
            when"0000"=>e6<="0000";
            when"0001"=>e6<="0001";
            when"0010"=>e6<="0010";
            when"0011"=>e6<="0011";
            when"0100"=>e6<="0100";
            when"0101"=>e6<="0101";
            when"0110"=>e6<="0110";
            when"0111"=>e6<="0111";
            when"1000"=>e6<="1000";
            when"1001"=>e6<="1001";
            when"1010"=>e6<="1010";
            when"1011"=>e6<="1011";
            when"1100"=>e6<="1100";
            when"1101"=>e6<="1101";
            when"1110"=>e6<="1110";
            when"1111"=>e6<="1111";
            when others=>e6<="0000";
      end case;
      case w7 is
            when"0000"=>e7<="0000";
            when"0001"=>e7<="0001";
            when"0010"=>e7<="0010";
            when"0011"=>e7<="0011";
            when"0100"=>e7<="0100";
            when"0101"=>e7<="0101";
            when"0110"=>e7<="0110";
            when"0111"=>e7<="0111";
            when"1000"=>e7<="1000";
            when"1001"=>e7<="1001";
            when"1010"=>e7<="1010";
            when"1011"=>e7<="1011";
            when"1100"=>e7<="1100";
            when"1101"=>e7<="1101";
            when"1110"=>e7<="1110";
            when"1111"=>e7<="1111";
            when others=>e7<="0000";
      end case;
      case w8 is
            when"0000"=>e8<="0000";
            when"0001"=>e8<="0001";
            when"0010"=>e8<="0010";
            when"0011"=>e8<="0011";
            when"0100"=>e8<="0100";
            when"0101"=>e8<="0101";
            when"0110"=>e8<="0110";
            when"0111"=>e8<="0111";
            when"1000"=>e8<="1000";
            when"1001"=>e8<="1001";
            when"1010"=>e8<="1010";
            when"1011"=>e8<="1011";
            when"1100"=>e8<="1100";
            when"1101"=>e8<="1101";
            when"1110"=>e8<="1110";
            when"1111"=>e8<="1111";
            when others=>e8<="0000";
      end case;
      end if;
      end process;
      end behav;

控制模块
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity ftest is
port(clk2:in std_logic;
     clr2,en2,load2:out std_logic);
end ftest;
architecture behav of ftest is

   signal cnt1,x:std_logic;
   signal cnt0:std_logic_vector(3 downto 0);
   
begin 
process(clk2)
begin
   if clk2'event and clk2='1' then  x<=not(x);
   if cnt0="0001" then cnt1<='1';cnt0<="0000";
   else cnt0<=cnt0+1;cnt1<='0';
   end if;
   end if;
   en2<=x;
   load2<=not(x);
   clr2<=(cnt1 and not(clk2));
   end process;
   end behav;

   
 顶层文件
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity pinlv is
port( clk3,fx3:in std_logic;
r1,r2,r3,r4,r5,r6,r7,r8:out std_logic_vector(3 downto 0));
end pinlv;
architecture behav of pinlv is
component ftest 
     port(clk2:in std_logic;
     clr2,en2,load2:out std_logic);
end component;
component fcount
port(fx1,clr1,en1:in std_logic;
          q1,q2,q3,q4,q5,q6,q7,q8:out std_logic_vector(3 downto 0);
                co1:out std_logic);
end component;
component led
port( w1,w2,w3,w4,w5,w6,w7,w8:in std_logic_vector(3 downto 0);
      e1,e2,e3,e4,e5,e6,e7,e8:out std_logic_vector(3 downto 0);
      load:in std_logic);
end component;
signal net1,net2,net3,net19:std_logic;
signal net11,net12,net13,net14,net15,net16,net17,net18:std_logic_vector(3 downto 0);
begin
u1:ftest port map(clk2=>clk3,clr2=>net1,en2=>net2,load2=>net3);
u2:fcount port map(fx3,net1,net2,net11,net12,net13,net14,net15,net16,net17,net18,net19);
u3:led port map(net11,net12,net13,net14,net15,net16,net17,net18,r1,r2,r3,r4,r5,r6,r7,r8,net3);
end behav;