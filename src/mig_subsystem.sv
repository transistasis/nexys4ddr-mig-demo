`timescale 1ps/1ps

module mig_subsystem (
  input  logic        clk_mem,
  input  logic        rst_n,

  inout  logic [15:0] ddr2_dq,
  inout  logic [ 1:0] ddr2_dqs_n,
  inout  logic [ 1:0] ddr2_dqs_p,
  output logic [12:0] ddr2_addr,
  output logic [ 2:0] ddr2_ba,
  output logic        ddr2_ras_n,
  output logic        ddr2_cas_n,
  output logic        ddr2_we_n,
  output logic [ 0:0] ddr2_ck_p,
  output logic [ 0:0] ddr2_ck_n,
  output logic [ 0:0] ddr2_cke,
  output logic [ 0:0] ddr2_cs_n,
  output logic [ 1:0] ddr2_dm,
  output logic [ 0:0] ddr2_odt,

  input  logic        cpu_clk,
  input  logic [27:0] addr,
  input  logic [ 1:0] width,
  input  logic [63:0] data_in,
  input  logic        rstrobe,
  output logic [63:0] data_out,
  input  logic        wstrobe,
  output logic        transaction_complete,
  output logic        ready );

  ddr_mig ddr_mig_i (
    .ddr2_addr           ( ddr2_addr         ),
    .ddr2_ba             ( ddr2_ba           ),
    .ddr2_cas_n          ( ddr2_cas_n        ),
    .ddr2_ck_n           ( ddr2_ck_n         ),
    .ddr2_ck_p           ( ddr2_ck_p         ),
    .ddr2_cke            ( ddr2_cke          ),
    .ddr2_ras_n          ( ddr2_ras_n        ),
    .ddr2_we_n           ( ddr2_we_n         ),
    .ddr2_dq             ( ddr2_dq           ),
    .ddr2_dqs_n          ( ddr2_dqs_n        ),
    .ddr2_dqs_p          ( ddr2_dqs_p        ),
    .init_calib_complete (                   ),

    .ddr2_cs_n           ( ddr2_cs_n         ),
    .ddr2_dm             ( ddr2_dm           ),
    .ddr2_odt            ( ddr2_odt          ),

    .app_addr            ( addr[27:1]        ),
    .app_cmd             ( mem_cmd           ),
    .app_en              ( mem_en            ),
    .app_wdf_data        ( mem_wdf_data      ),
    .app_wdf_end         ( mem_wdf_end       ),
    .app_wdf_wren        ( mem_wdf_wren      ),
    .app_rd_data         ( mem_rd_data       ),
    .app_rd_data_end     ( mem_rd_data_end   ),
    .app_rd_data_valid   ( mem_rd_data_valid ),
    .app_rdy             ( mem_rdy           ),
    .app_wdf_rdy         ( mem_wdf_rdy       ),
    .app_sr_req          ( 1'b0              ),
    .app_ref_req         ( 1'b0              ),
    .app_zq_req          ( 1'b0              ),
    .app_sr_active       (                   ),
    .app_ref_ack         (                   ),
    .app_zq_ack          (                   ),
    .ui_clk              ( ui_clk            ),
    .ui_clk_sync_rst     ( ui_clk_sync_rst   ),

    .app_wdf_mask        ( mem_wdf_mask      ),

    .sys_clk_i           ( clk_mem           ),
    .sys_rst             ( rst_n             ) );

endmodule : mig_subsystem
