----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/18/2020 06:32:30 PM
-- Design Name: 
-- Module Name: modPrin - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity modPrin is
  Port ( clk: in std_logic;
         RxS: in std_logic;
         TxS: out std_logic;
         sw : in  std_logic_vector(15 downto 0);
         led: out std_logic_vector(15 downto 0));
end modPrin;

architecture Behavioral of modPrin is

component tx is
  generic (
    g_CLKS_PER_BIT : integer := 868     -- Needs to be set correctly
    );
  port (
    i_Clk       : in  std_logic;
    i_TX_DV     : in  std_logic;
    i_TX_Byte   : in  std_logic_vector(7 downto 0);
    o_TX_Active : out std_logic;
    o_TX_Serial : out std_logic;
    o_TX_Done   : out std_logic
    );
end component;
component rx is
  generic (
    g_CLKS_PER_BIT : integer := 868     -- Needs to be set correctly
    );
  port (
    i_Clk       : in  std_logic;
    i_RX_Serial : in  std_logic;
    o_RX_DV     : out std_logic;
    o_RX_Byte   : out std_logic_vector(7 downto 0)
    );
end component;
--signal serial: std_logic;
signal tx_active, tx_serial, tx_done:std_logic;
signal rx_dv: std_logic;
signal byte: std_logic_vector(7 downto 0);
begin
portMap: rx 
generic map(g_CLKS_PER_BIT => 868)
port map(clk, RxS, rx_dv, byte);
--led(7 downto 0) <= byte;
--led(15) <= rx_dv;
portMap1: tx
generic map(g_CLKS_PER_BIT => 868)
port map(clk,rx_dv,byte ,tx_active, tx_serial,open);
TxS <= tx_serial when tx_active ='1' else '1';

led(7 downto 0) <= byte;

end Behavioral;
