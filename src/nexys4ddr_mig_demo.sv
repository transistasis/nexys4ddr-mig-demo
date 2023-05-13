`timescale 1ps/1ps

module nexys4ddr_mig_demo (
  input  logic        clk_i,
  input  logic        reset_b_i, 
  // DDR2 RAM Interface
  inout  tri   [15:0] ddr2_dq_bi,
  inout  tri   [ 1:0] ddr2_dqs_n_bi,
  inout  tri   [ 1:0] ddr2_dqs_p_bi,
  output logic [12:0] ddr2_addr_o,
  output logic [ 2:0] ddr2_ba_o,
  output logic        ddr2_ras_b_o,
  output logic        ddr2_cas_b_o,
  output logic        ddr2_we_b_o,
  output logic        ddr2_ck_p_o,
  output logic        ddr2_ck_n_o,
  output logic        ddr2_cke_o,
  output logic        ddr2_cs_b_o,
  output logic [ 1:0] ddr2_dm_o,
  output logic        ddr2_odt_o );

  logic pll_clk_out, pll_locked;

  pll pll_i (
    .pll_clk_in           ( clk_i                ),
    .pll_clk_out          ( pll_clk_out          ),
    .pll_locked           ( pll_locked           ) );

  mig_subsystem mig_subsystem_i (
    .clk_mem              ( clk_i                ), // TODO: CHANGE
    .rst_n                ( reset_b_i            ), // TODO: CHANGE
    .ddr2_dq              ( ddr2_dq_bi           ),
    .ddr2_dqs_n           ( ddr2_dqs_n_bi        ),
    .ddr2_dqs_p           ( ddr2_dqs_p_bi        ),
    .ddr2_addr            ( ddr2_addr_o          ),
    .ddr2_ba              ( ddr2_ba_o            ),
    .ddr2_ras_n           ( ddr2_ras_b_o         ),
    .ddr2_cas_n           ( ddr2_cas_b_o         ),
    .ddr2_we_n            ( ddr2_we_b_o          ),
    .ddr2_ck_p            ( ddr2_ck_p_o          ),
    .ddr2_ck_n            ( ddr2_ck_n_o          ),
    .ddr2_cke             ( ddr2_cke_o           ),
    .ddr2_cs_n            ( ddr2_cs_b_o          ),
    .ddr2_dm              ( ddr2_dm_o            ),
    .ddr2_odt             ( ddr2_odt_o           ),
    .cpu_clk              ( pll_clk_out          ), // TODO: CHANGE
    .addr                 (                  ),
    .width                (                 ),
    .data_in              (               ),
    .data_out             (              ),
    .rstrobe              (               ),
    .wstrobe              (               ),
    .transaction_complete (  ),
    .ready                (                 ) );

endmodule : nexys4ddr_mig_demo
