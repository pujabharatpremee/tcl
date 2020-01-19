-- ==============================================================
-- RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
-- Version: 2019.2
-- Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
-- 
-- ===========================================================

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity config_encoder is
port (
    din_words_V_V_TDATA : OUT STD_LOGIC_VECTOR (7 downto 0);
    dout_words_V_V_TDATA : OUT STD_LOGIC_VECTOR (7 downto 0);
    ctrl_V_V_TDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
    ap_clk : IN STD_LOGIC;
    ap_rst_n : IN STD_LOGIC;
    ctrl_V_V_TVALID : OUT STD_LOGIC;
    ctrl_V_V_TREADY : IN STD_LOGIC;
    din_words_V_V_TVALID : OUT STD_LOGIC;
    din_words_V_V_TREADY : IN STD_LOGIC;
    dout_words_V_V_TVALID : OUT STD_LOGIC;
    dout_words_V_V_TREADY : IN STD_LOGIC;
    ap_start : IN STD_LOGIC;
    ap_done : OUT STD_LOGIC;
    ap_ready : OUT STD_LOGIC;
    ap_idle : OUT STD_LOGIC );
end;


architecture behav of config_encoder is 
    attribute CORE_GENERATION_INFO : STRING;
    attribute CORE_GENERATION_INFO of behav : architecture is
    "config_encoder,hls_ip_2019_2,{HLS_INPUT_TYPE=cxx,HLS_INPUT_FLOAT=0,HLS_INPUT_FIXED=1,HLS_INPUT_PART=xczu28dr-ffvg1517-2-e,HLS_INPUT_CLOCK=10.000000,HLS_INPUT_ARCH=dataflow,HLS_SYN_CLOCK=0.000000,HLS_SYN_LAT=1,HLS_SYN_TPT=2,HLS_SYN_MEM=0,HLS_SYN_DSP=0,HLS_SYN_FF=3,HLS_SYN_LUT=57,HLS_VERSION=2019_2}";
    constant ap_const_lv8_0 : STD_LOGIC_VECTOR (7 downto 0) := "00000000";
    constant ap_const_lv32_0 : STD_LOGIC_VECTOR (31 downto 0) := "00000000000000000000000000000000";
    constant ap_const_logic_1 : STD_LOGIC := '1';
    constant ap_const_logic_0 : STD_LOGIC := '0';

    signal ap_rst_n_inv : STD_LOGIC;
    signal Block_proc13_U0_ap_start : STD_LOGIC;
    signal Block_proc13_U0_ap_done : STD_LOGIC;
    signal Block_proc13_U0_ap_continue : STD_LOGIC;
    signal Block_proc13_U0_ap_idle : STD_LOGIC;
    signal Block_proc13_U0_ap_ready : STD_LOGIC;
    signal Block_proc13_U0_ctrl_V_V_TDATA : STD_LOGIC_VECTOR (31 downto 0);
    signal Block_proc13_U0_ctrl_V_V_TVALID : STD_LOGIC;
    signal Block_proc13_U0_din_words_V_V_TDATA : STD_LOGIC_VECTOR (7 downto 0);
    signal Block_proc13_U0_din_words_V_V_TVALID : STD_LOGIC;
    signal Block_proc13_U0_dout_words_V_V_TDATA : STD_LOGIC_VECTOR (7 downto 0);
    signal Block_proc13_U0_dout_words_V_V_TVALID : STD_LOGIC;
    signal ap_sync_continue : STD_LOGIC;
    signal ap_sync_done : STD_LOGIC;
    signal ap_sync_ready : STD_LOGIC;
    signal Block_proc13_U0_start_full_n : STD_LOGIC;
    signal Block_proc13_U0_start_write : STD_LOGIC;

    component Block_proc13 IS
    port (
        ap_clk : IN STD_LOGIC;
        ap_rst : IN STD_LOGIC;
        ap_start : IN STD_LOGIC;
        ap_done : OUT STD_LOGIC;
        ap_continue : IN STD_LOGIC;
        ap_idle : OUT STD_LOGIC;
        ap_ready : OUT STD_LOGIC;
        ctrl_V_V_TDATA : OUT STD_LOGIC_VECTOR (31 downto 0);
        ctrl_V_V_TVALID : OUT STD_LOGIC;
        ctrl_V_V_TREADY : IN STD_LOGIC;
        din_words_V_V_TDATA : OUT STD_LOGIC_VECTOR (7 downto 0);
        din_words_V_V_TVALID : OUT STD_LOGIC;
        din_words_V_V_TREADY : IN STD_LOGIC;
        dout_words_V_V_TDATA : OUT STD_LOGIC_VECTOR (7 downto 0);
        dout_words_V_V_TVALID : OUT STD_LOGIC;
        dout_words_V_V_TREADY : IN STD_LOGIC );
    end component;



begin
    Block_proc13_U0 : component Block_proc13
    port map (
        ap_clk => ap_clk,
        ap_rst => ap_rst_n_inv,
        ap_start => Block_proc13_U0_ap_start,
        ap_done => Block_proc13_U0_ap_done,
        ap_continue => Block_proc13_U0_ap_continue,
        ap_idle => Block_proc13_U0_ap_idle,
        ap_ready => Block_proc13_U0_ap_ready,
        ctrl_V_V_TDATA => Block_proc13_U0_ctrl_V_V_TDATA,
        ctrl_V_V_TVALID => Block_proc13_U0_ctrl_V_V_TVALID,
        ctrl_V_V_TREADY => ctrl_V_V_TREADY,
        din_words_V_V_TDATA => Block_proc13_U0_din_words_V_V_TDATA,
        din_words_V_V_TVALID => Block_proc13_U0_din_words_V_V_TVALID,
        din_words_V_V_TREADY => din_words_V_V_TREADY,
        dout_words_V_V_TDATA => Block_proc13_U0_dout_words_V_V_TDATA,
        dout_words_V_V_TVALID => Block_proc13_U0_dout_words_V_V_TVALID,
        dout_words_V_V_TREADY => dout_words_V_V_TREADY);




    Block_proc13_U0_ap_continue <= ap_const_logic_1;
    Block_proc13_U0_ap_start <= ap_start;
    Block_proc13_U0_start_full_n <= ap_const_logic_1;
    Block_proc13_U0_start_write <= ap_const_logic_0;
    ap_done <= Block_proc13_U0_ap_done;
    ap_idle <= Block_proc13_U0_ap_idle;
    ap_ready <= Block_proc13_U0_ap_ready;

    ap_rst_n_inv_assign_proc : process(ap_rst_n)
    begin
                ap_rst_n_inv <= not(ap_rst_n);
    end process;

    ap_sync_continue <= ap_const_logic_1;
    ap_sync_done <= Block_proc13_U0_ap_done;
    ap_sync_ready <= Block_proc13_U0_ap_ready;
    ctrl_V_V_TDATA <= Block_proc13_U0_ctrl_V_V_TDATA;
    ctrl_V_V_TVALID <= Block_proc13_U0_ctrl_V_V_TVALID;
    din_words_V_V_TDATA <= Block_proc13_U0_din_words_V_V_TDATA;
    din_words_V_V_TVALID <= Block_proc13_U0_din_words_V_V_TVALID;
    dout_words_V_V_TDATA <= Block_proc13_U0_dout_words_V_V_TDATA;
    dout_words_V_V_TVALID <= Block_proc13_U0_dout_words_V_V_TVALID;
end behav;
