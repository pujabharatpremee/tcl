// ==============================================================
// RTL generated by Vivado(TM) HLS - High-Level Synthesis from C, C++ and OpenCL
// Version: 2019.2
// Copyright (C) 1986-2019 Xilinx, Inc. All Rights Reserved.
// 
// ===========================================================

`timescale 1 ns / 1 ps 

module Block_proc13 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        ctrl_V_V_TDATA,
        ctrl_V_V_TVALID,
        ctrl_V_V_TREADY,
        din_words_V_V_TDATA,
        din_words_V_V_TVALID,
        din_words_V_V_TREADY,
        dout_words_V_V_TDATA,
        dout_words_V_V_TVALID,
        dout_words_V_V_TREADY
);

parameter    ap_ST_fsm_state1 = 2'd1;
parameter    ap_ST_fsm_state2 = 2'd2;
parameter    ap_const_lv32_0 = 32'd0;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
output  [31:0] ctrl_V_V_TDATA;
output   ctrl_V_V_TVALID;
input   ctrl_V_V_TREADY;
output  [7:0] din_words_V_V_TDATA;
output   din_words_V_V_TVALID;
input   din_words_V_V_TREADY;
output  [7:0] dout_words_V_V_TDATA;
output   dout_words_V_V_TVALID;
input   dout_words_V_V_TREADY;

reg ap_done;
reg ap_idle;
reg ap_ready;

reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    ctrl_V_V_TDATA_blk_n;
wire    ap_CS_fsm_state2;
reg    din_words_V_V_TDATA_blk_n;
reg    dout_words_V_V_TDATA_blk_n;
reg    ap_block_state1;
reg    ap_block_state1_io;
wire   [31:0] p_Result_s_fu_71_p5;
wire   [31:0] p_Result_1_fu_83_p5;
wire    regslice_both_ctrl_V_V_U_apdone_blk;
wire    regslice_both_din_words_V_V_U_apdone_blk;
wire    regslice_both_dout_words_V_V_U_apdone_blk;
reg    ap_block_state2;
reg    ap_block_state2_io;
reg   [1:0] ap_NS_fsm;
wire   [31:0] ctrl_V_V_TDATA_int;
reg    ctrl_V_V_TVALID_int;
wire    ctrl_V_V_TREADY_int;
wire    regslice_both_ctrl_V_V_U_vld_out;
reg    din_words_V_V_TVALID_int;
wire    din_words_V_V_TREADY_int;
wire    regslice_both_din_words_V_V_U_vld_out;
reg    dout_words_V_V_TVALID_int;
wire    dout_words_V_V_TREADY_int;
wire    regslice_both_dout_words_V_V_U_vld_out;

// power-on initialization
initial begin
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 2'd1;
end

regslice_both #(
    .DataWidth( 32 ))
regslice_both_ctrl_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(ctrl_V_V_TDATA_int),
    .vld_in(ctrl_V_V_TVALID_int),
    .ack_in(ctrl_V_V_TREADY_int),
    .data_out(ctrl_V_V_TDATA),
    .vld_out(regslice_both_ctrl_V_V_U_vld_out),
    .ack_out(ctrl_V_V_TREADY),
    .apdone_blk(regslice_both_ctrl_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_din_words_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(8'd16),
    .vld_in(din_words_V_V_TVALID_int),
    .ack_in(din_words_V_V_TREADY_int),
    .data_out(din_words_V_V_TDATA),
    .vld_out(regslice_both_din_words_V_V_U_vld_out),
    .ack_out(din_words_V_V_TREADY),
    .apdone_blk(regslice_both_din_words_V_V_U_apdone_blk)
);

regslice_both #(
    .DataWidth( 8 ))
regslice_both_dout_words_V_V_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .data_in(8'd16),
    .vld_in(dout_words_V_V_TVALID_int),
    .ack_in(dout_words_V_V_TREADY_int),
    .data_out(dout_words_V_V_TDATA),
    .vld_out(regslice_both_dout_words_V_V_U_vld_out),
    .ack_out(dout_words_V_V_TREADY),
    .apdone_blk(regslice_both_dout_words_V_V_U_apdone_blk)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if ((~((regslice_both_dout_words_V_V_U_apdone_blk == 1'b1) | (regslice_both_din_words_V_V_U_apdone_blk == 1'b1) | (regslice_both_ctrl_V_V_U_apdone_blk == 1'b1) | (1'b1 == ap_block_state2_io)) & (1'b1 == ap_CS_fsm_state2))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (*) begin
    if ((~((regslice_both_dout_words_V_V_U_apdone_blk == 1'b1) | (regslice_both_din_words_V_V_U_apdone_blk == 1'b1) | (regslice_both_ctrl_V_V_U_apdone_blk == 1'b1) | (1'b1 == ap_block_state2_io)) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if ((~((regslice_both_dout_words_V_V_U_apdone_blk == 1'b1) | (regslice_both_din_words_V_V_U_apdone_blk == 1'b1) | (regslice_both_ctrl_V_V_U_apdone_blk == 1'b1) | (1'b1 == ap_block_state2_io)) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_ready = 1'b1;
    end else begin
        ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) | (~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1)))) begin
        ctrl_V_V_TDATA_blk_n = ctrl_V_V_TREADY_int;
    end else begin
        ctrl_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (1'b1 == ap_block_state1_io) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        ctrl_V_V_TVALID_int = 1'b1;
    end else begin
        ctrl_V_V_TVALID_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) | (~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1)))) begin
        din_words_V_V_TDATA_blk_n = din_words_V_V_TREADY_int;
    end else begin
        din_words_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (1'b1 == ap_block_state1_io) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        din_words_V_V_TVALID_int = 1'b1;
    end else begin
        din_words_V_V_TVALID_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b1 == ap_CS_fsm_state2) | (~((ap_start == 1'b0) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1)))) begin
        dout_words_V_V_TDATA_blk_n = dout_words_V_V_TREADY_int;
    end else begin
        dout_words_V_V_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if ((~((ap_start == 1'b0) | (1'b1 == ap_block_state1_io) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
        dout_words_V_V_TVALID_int = 1'b1;
    end else begin
        dout_words_V_V_TVALID_int = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if ((~((ap_start == 1'b0) | (1'b1 == ap_block_state1_io) | (ap_done_reg == 1'b1)) & (1'b1 == ap_CS_fsm_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if ((~((regslice_both_dout_words_V_V_U_apdone_blk == 1'b1) | (regslice_both_din_words_V_V_U_apdone_blk == 1'b1) | (regslice_both_ctrl_V_V_U_apdone_blk == 1'b1) | (1'b1 == ap_block_state2_io)) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

always @ (*) begin
    ap_block_state1 = ((ap_start == 1'b0) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state1_io = ((dout_words_V_V_TREADY_int == 1'b0) | (din_words_V_V_TREADY_int == 1'b0) | (ctrl_V_V_TREADY_int == 1'b0));
end

always @ (*) begin
    ap_block_state2 = ((regslice_both_dout_words_V_V_U_apdone_blk == 1'b1) | (regslice_both_din_words_V_V_U_apdone_blk == 1'b1) | (regslice_both_ctrl_V_V_U_apdone_blk == 1'b1));
end

always @ (*) begin
    ap_block_state2_io = ((dout_words_V_V_TREADY_int == 1'b0) | (din_words_V_V_TREADY_int == 1'b0) | (ctrl_V_V_TREADY_int == 1'b0));
end

assign ctrl_V_V_TDATA_int = {{p_Result_1_fu_83_p5[31:7]}, {7'd0}};

assign ctrl_V_V_TVALID = regslice_both_ctrl_V_V_U_vld_out;

assign din_words_V_V_TVALID = regslice_both_din_words_V_V_U_vld_out;

assign dout_words_V_V_TVALID = regslice_both_dout_words_V_V_U_vld_out;

assign p_Result_1_fu_83_p5 = {{p_Result_s_fu_71_p5[31:24]}, {16'd0}, {p_Result_s_fu_71_p5[7:0]}};

assign p_Result_s_fu_71_p5 = {{8'd0}, {ap_const_lv32_0[23:0]}};

endmodule //Block_proc13
