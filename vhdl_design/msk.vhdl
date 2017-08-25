 --本程序利用状态机完成MSK信号附加相位的产生
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity msk_phase is
  port(s,clk,clr_bar: in std_logic;
       s_out1:out std_logic_vector(1 downto 0));
end msk_phase;
architecture moore_fsm of msk_phase is
   type state is (state_000,state_090,state_180,state_270);
   signal present_state,next_state:state; 
begin
state_reg: process(clk,clr_bar)             --状态寄存器
begin
 if clr_bar='0' then
    present_state <=state_000;
   elsif rising_edge(clk) then 
    present_state <= next_state;
 end if;
end process;
 outputs:process(present_state)             --描述四个状态对应的附加相位
 begin
   case present_state is
      when state_000 => s_out1 <="00";
      when state_090 => s_out1 <="01";
      when state_180 => s_out1 <="10";
      when state_270 => s_out1 <="11";       
    end case;
 end process;
 nxt_state:process(present_state,s)
 begin
   case present_state is                    --当输入为0时，相位减少90度；当输入为1时，相位增加90度。 
     when state_000 =>  if s='0' then  next_state <=state_270;  else  next_state <=state_090;    end if;
     when state_090 =>  if s='0' then  next_state <=state_000;  else  next_state <=state_180;    end if;
     when state_180 =>  if s='0' then  next_state <=state_090;  else  next_state <=state_270;    end if;      
     when state_270 =>  if s='0' then  next_state <=state_180;  else  next_state <=state_000;    end if;
   end case;
  end process;
end moore_fsm;          

--本程序为一加法器，由得到的首地址及输入的0、1判断以得到顺序（逆序）得出40个地址
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity counter is
port(address_first:in std_logic_vector(7 downto 0);
     ins,clk_counter:in std_logic;
     address_out:out std_logic_vector(7 downto 0));
end counter;
architecture behave of counter is
begin
p1:process(address_first,ins,clk_counter)
variable ad_int:integer;
variable ad_vec:std_logic_vector(7 downto 0);
  begin
ad_int:=conv_integer(address_first);
if ins='0' and clk_counter='1' and clk_counter'event then
  ad_int :=ad_int -1;
elsif ins='1' and clk_counter='1' and clk_counter'event then 
  ad_int :=ad_int +1;
end if;
ad_vec :=conv_std_logic_vector(ad_int,8);
address_out <=ad_vec;
end process p1;
end behave;
 
 
 --本程序为采用查找法输出MSK调制信号
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity msk_modulation is
 port(in_msk,clr_barmsk :in std_logic;
      out_msk:out std_logic_vector(17 downto 0));   
end msk_modulation;  
architecture connection of msk_modulation is
component rom_cos                            --调用rom_phase
   port (address:in std_logic_vector(7 downto 0);
         clock: in std_logic;
         q:out std_logic_vector(17 downto 0));
end component;
component counter
port(address_first:in std_logic_vector(7 downto 0);
     ins,clk_counter:in std_logic;
     address_out:out std_logic_vector(7 downto 0));
end component;
component msk_phase                            --调用msk_phase
   port(s,clk,clr_bar: in std_logic;
        s_out1:out std_logic_vector(1 downto 0));
end component;
procedure clock_gen(signal clk:out std_logic; constant period:in time) is                  --生成系统时钟函数
begin
  clk <='0';
  wait for period/2;
  loop clk <='1','0' after period/2;
  wait for period;
  end loop;
end clock_gen;                                
signal s1:std_logic_vector(1 downto 0);
signal address_msk,address_tmp :std_logic_vector(7 downto 0);
signal clock_msk,clock_counter:std_logic;
begin
clock_gen(clock_msk,40ns);
clock_gen(clock_counter,1ns);
u1:msk_phase port map(clk =>clock_msk,clr_bar =>clr_barmsk,s =>in_msk,s_out1 =>s1);
ad_msk:process(s1) begin                       --根据附加相位的情况确定rom中的首地址
  case s1 is
     when "00"  =>  address_msk <="00000000";
     when "01"  =>  address_msk <="00101000";
     when "10"  =>  address_msk <="01010000";
     when "11"  =>  address_msk <="01111000";
     when others => address_msk <="00000000";
  end case;
end process;
u2:counter port map (address_first =>address_msk,ins =>in_msk,clk_counter =>clock_counter,address_out =>address_tmp);
u3:rom_cos port map (address => address_tmp,clock => clock_counter,q => out_msk);
end connection;


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity counter is
port(address_first:in std_logic_vector(7 downto 0);
     ins,clk_counter:in std_logic;
     address_out:out std_logic_vector(7 downto 0));
end counter;
architecture behave of counter is

begin
p1:process(address_first,ins,clk_counter)

variable x:integer;
variable y:integer;

  begin
 
  
if(clk_counter='1' and clk_counter'event) then 
         if (ins='0')  then  
                         if (x<40) then y:=conv_integer(address_first);x:=x+1;y:=y-x;
                         else x:=0; y:=0;end if;
         else  if (x<40) then y:=conv_integer(address_first);  x:=x+1; y:=y+x;  else x:=0;y:=0;end if;
end if;
end if;
 address_out<=conv_std_logic_vector(y,8);
end process p1;
end behave;
