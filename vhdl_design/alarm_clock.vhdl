ÒëÂëÆ÷
library ieee;
use ieee.std_logic_1164.all;
entity decoder is
port( keypad:in std_logic_vector(9 downto 0);
      value: out integer);
end decoder;
architecture rtl of decoder is
begin
  with keypad select
   value<=0 when"0000000001",
          1  when"0000000010",
           2                  when"0000000100",
            3                when "0000001000",
             4                when"0000010000",
              5               when"0000100000",
               6              when"0001000000",
                7             when"0010000000",
                 8           when "0100000000",
                  9          when "1000000000",     
                   0        when others;
end rtl;
ÒÆÎ»¼Ä´æÆ÷
library ieee;
use ieee.std_logic_1164.all;
package p_alarm is
subtype t_digital is integer range 0 to 9;
subtype t_short is integer range 0 to 65535;
type t_clock_time is array(3 downto 0) of t_digital;
type t_disply is array(3 downto 0) of std_logic_vector(6 downto 0);
type seg7 is array(0 to 9) of std_logic_vector(6 downto 0);
constant seven_seg:seg7:=("0111111","0000110","1011011","1001111","1100110","1101101","1111101","0000111","1111111","1110011");
type keypad9 is array (0 to 9) of std_logic_vector(9 downto 0);
constant keynumber:keypad9:=("0000000001",
                             "0000000010",
                             "0000000100",
                             "0000001000",
                             "0000010000",
                             "0000100000",
                             "0001000000",
                             "0010000000",
                             "0100000000",
                             "1000000000");
end p_alarm;
use work.p_alarm.all;
library ieee;
use ieee.std_logic_1164.all;
entity key_buffer is
port( key:in integer;
      clk,reset: in std_logic;
         new_time:out t_clock_time);
end key_buffer;
architecture rtl of key_buffer is
signal nt:t_clock_time;
begin
  process(reset,clk)
    begin
      if(reset='1') then nt<=(0,0,0,0);
      elsif(clk'event and clk='1') then
           for i in 3 downto 1 loop
           nt(i)<=nt(i-1);
           end loop;
           nt(0)<=key;
       end if;
end process;
new_time<=nt;
end rtl;
¼ÆÊıÆ÷
library ieee;
use ieee.std_logic_1164.all;
use work.p_alarm.all;
entity alarm_counter is
port(new_current_time:in t_clock_time;
     load_new_c,clk,reset:in std_logic;
     current_time:out t_clock_time);
end alarm_counter;
architecture rtl of alarm_counter is
signal i_current_time:t_clock_time;
begin 
  process(load_new_c,clk,reset)
    variable ct:t_clock_time;
       begin
          if reset='1' then i_current_time<=(0,0,0,0);
          elsif load_new_c='1' then i_current_time<=new_current_time;
          elsif rising_edge(clk) then ct:=i_current_time;
                 if ct(0)<9 then ct(0):=ct(0)+1; else ct(0):=0;
                     if ct(1)<5 then ct(1):=ct(1)+1; else ct(1):=0;
                         if ct(3)<2 then if ct(2)<9 then ct(2):=ct(2)+1;else ct(2):=0;ct(3):=ct(3)+1;end if; 
                         else if ct(2)<3 then ct(2):=ct(2)+1; else ct(2):=0;ct(3):=0;
                              end if;
                         end if;
                      end if;
                  end if;
                  i_current_time<=ct;
           end if;
   end process;
   current_time<=i_current_time;
end rtl;
´óÄÔ
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity alarm_controller is
port( key,alarm_button,time_button,clk,reset:in std_logic;
     load_new_a,load_new_c,show_new_time,show_a:out std_logic);
end alarm_controller;
architecture behav of alarm_controller is
type ts is(s0,s1,s2,s3,s4);
signal cs:ts;
signal ns:ts;
subtype t_int16 is integer range 0 to 65535;
constant key_timeout:t_int16:=500;
signal counter_k:t_int16;
signal enable_count_k:std_logic;
signal count_k_end:std_logic;
begin
  process(enable_count_k,clk)
           begin if(enable_count_k='0') then counter_k<=0;count_k_end<='0';
                 elsif(rising_edge(clk)) then 
                     if (counter_k>=key_timeout) then count_k_end<='1';
                     else counter_k<=counter_k+1;
                     end if;
                 end if;
           end process;
  process(clk,reset)
    begin
     if(reset='1') then cs<=s0;
     elsif(clk'event and clk='1') then cs<=ns;
     end if;
  end process;
 process(cs,alarm_button,time_button,key)
    begin 
  ns<=cs;load_new_a<='0';load_new_c<='0';show_new_time<='0';show_a<='0';
       case cs is
          when s0=>
                if(key='1') then ns<=s1;show_new_time<='1';
                elsif(alarm_button='1')then ns<=s4;show_a<='1';
                   else ns<=s0; 
                   end if;
           
           when s1=>
                if(key='1') then ns<=s1;
            
                elsif(alarm_button='1')then ns<=s2;load_new_a<='1';
                elsif(time_button='1')then  ns<=s3;load_new_c<='1';
                   else  if(count_k_end='1') then ns<=s0;
                         else show_new_time<='1';ns<=s1;
                         end if;
                         enable_count_k<='1';
                   end if;
           when s2=>
                if(alarm_button='1') then ns<=s2; load_new_a<='1';
                else ns<=s0;
           end if;
           when s3=>
                if(time_button='1') then ns<=s3;load_new_c<='1';
                else ns<=s0;
           end if;
           when s4=>
                if(alarm_button='1') then ns<=s4;
                else if(count_k_end='1') then ns<=s0;
                     else show_a<='1';ns<=s4;
                     end if;
                     enable_count_k<='1';
                end if;
           when others=>null;
           end case;
end process;
end behav;
ÄÖÖÓ¼Ä´æÆ÷
library ieee;
use ieee.std_logic_1164.all;
use work.p_alarm.all;
entity alarm_reg is
port(new_alarm_time:in t_clock_time;
     load_new_a,clk,reset: in std_logic;
     alarm_time:out t_clock_time );
end alarm_reg;
architecture rtl of alarm_reg  is
begin
 process(clk,reset)
  begin
   if reset='1' then alarm_time<=(0,0,0,0);
   else   if rising_edge(clk) then alarm_time<=new_alarm_time;
          elsif load_new_a/='0' then assert false report "ucertain load_new_alarm control!" 
          severity warning; 
          end if;
          end if;
 
 end process;
end rtl;
·ÖÆµÆ÷
library ieee;
use work.p_alarm.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity fp is
port(clk_in,reset:in std_logic;
     clk_out:out std_logic);
end fp;
architecture rtl of fp is
constant a:t_short:=6000;
begin 
process(clk_in,reset)
 variable cnt:t_short;
begin
 if(reset='1') then cnt:=0;
clk_out<='0';
 elsif rising_edge(clk_in)  then 
        if (cnt<(a/2)) then clk_out<='1'; cnt:=cnt+1;
        else cnt:=0;
        end if;
 end if;
end process;
end rtl;
ÏÔÊ¾Çı¶¯
library ieee;
use ieee.std_logic_1164.all;
use work.p_alarm.all;
entity display_driver is
port(alarm_time,current_time,new_time:in t_clock_time;
     show_new_time,show_a: in std_logic;
     sound_alarm:out std_logic;
     display:out t_disply);
end display_driver;
architecture rtl of display_driver is
 signal display_time:t_clock_time;
begin
process(alarm_time,current_time,new_time,show_new_time,show_a)
 begin
sound_lp:for i in alarm_time'range loop
if not(alarm_time(i)=current_time(i)) then sound_alarm<='0'; exit sound_lp;
else sound_alarm<='1';
end if;
end loop sound_lp;
if show_new_time='1' then display_time<=new_time;
elsif show_a='1' then display_time<=alarm_time;
elsif show_a='0' then display_time<=current_time;
else assert false report"uncertain display_driver control"
severity error;
end if;
end process;
process(display_time)
begin 
for i in display_time'range loop
display(i)<=seven_seg(display_time(i));
end loop;
end process;
end rtl;
Àı»¯
library ieee;
use work.p_alarm.all;
use ieee.std_logic_1164.all;
entity alarm_clock is
port(keypad:in std_logic_vector(9 downto 0);
     key_down,alarm_button,time_button,clk,reset:in std_logic;
     display:out t_disply;
      sound_alarm:out std_logic);
end alarm_clock;
architecture rtl of alarm_clock is
component decoder
port( keypad:in std_logic_vector(9 downto 0);
      value: out integer);
end component;
component key_buffer 
port( key:in integer;
      clk,reset: in std_logic;
         new_time:out t_clock_time);
end component;
component alarm_counter 
port(new_current_time:in t_clock_time;
     load_new_c,clk,reset:in std_logic;
     current_time:out t_clock_time);
end component;
component alarm_reg 
port(new_alarm_time:in t_clock_time;
     load_new_a,clk,reset: in std_logic;
     alarm_time:out t_clock_time );
end component;
component alarm_controller 
port( key,alarm_button,time_button,clk,reset:in std_logic;
     load_new_a,load_new_c,show_new_time,show_a:out std_logic);
end component;
component display_driver 
port(alarm_time,current_time,new_time:in t_clock_time;
     show_new_time,show_a: in std_logic;
     sound_alarm:out std_logic;
     display:out t_disply);
end component;
component fp 
port(clk_in,reset:in std_logic;
     clk_out:out std_logic);
end component;
signal inner_key :integer;
signal inner_time:t_clock_time;
signal inner_time_c:t_clock_time;
signal inner_time_a:t_clock_time;
signal inner_l_c:std_logic;
signal inner_l_a:std_logic;
signal inner_s_a:std_logic;
signal inner_s_n:std_logic;
signal inner_sec_clk:std_logic;
begin
u1:key_buffer port map(inner_key,key_down,reset,inner_time);
u2:alarm_controller port map(key_down,alarm_button,time_button,clk,reset,inner_l_a,inner_l_c,inner_s_n,inner_s_a);
u3:alarm_counter port map(inner_time,inner_l_c,inner_sec_clk,reset,inner_time_c);
u4:alarm_reg port map(inner_time,inner_l_c,clk,reset,inner_time_a);
u5:display_driver port map(inner_time_a,inner_time_c,inner_time,inner_s_n,inner_s_a,sound_alarm,display);
u6:fp port map(clk,reset,inner_sec_clk);
end rtl;



















































