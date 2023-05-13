`timescale 1ps/1ps

module tb_nexys4ddr_mig_demo;

  parameter SYS_CLK_PERIOD = 10ns;

  logic clk = '0;
  logic reset_n;

  tri   [15:0] ddr2_dq;
  tri   [ 1:0] ddr2_dqs_n;
  tri   [ 1:0] ddr2_dqs_p;
  logic [12:0] ddr2_addr;
  logic [ 2:0] ddr2_ba;
  logic        ddr2_ras_n;
  logic        ddr2_cas_n;
  logic        ddr2_we_n;
  logic        ddr2_ck_p;
  logic        ddr2_ck_n;
  logic        ddr2_cke;
  logic        ddr2_cs_n;
  tri   [ 1:0] ddr2_dm;
  logic        ddr2_odt;

  always #(SYS_CLK_PERIOD/2) clk = ~clk;

  task reset_dut(int delay_ns);
    reset_n = '0;
    #(delay_ns);
    reset_n = '1;
  endtask : reset_dut

  initial begin
    $display("Starting the testbench for tb_nexys4ddr_mig_demo.sv...\n");
    reset_dut(50);

    // Insert test code here
    #100us
    $display("The test has completed.");
    $finish();
  end

  nexys4ddr_mig_demo nexys4ddr_mig_demo_i (
    .clk_i         ( clk        ),
    .reset_b_i     ( reset_n    ),
    .ddr2_dq_bi    ( ddr2_dq    ),
    .ddr2_dqs_n_bi ( ddr2_dqs_n ),
    .ddr2_dqs_p_bi ( ddr2_dqs_p ),
    .ddr2_addr_o   ( ddr2_addr  ),
    .ddr2_ba_o     ( ddr2_ba    ),
    .ddr2_ras_b_o  ( ddr2_ras_n ),
    .ddr2_cas_b_o  ( ddr2_cas_n ),
    .ddr2_we_b_o   ( ddr2_we_n  ),
    .ddr2_ck_p_o   ( ddr2_ck_p  ),
    .ddr2_ck_n_o   ( ddr2_ck_n  ),
    .ddr2_cke_o    ( ddr2_cke   ),
    .ddr2_cs_b_o   ( ddr2_cs_n  ),
    .ddr2_dm_o     ( ddr2_dm    ),
    .ddr2_odt_o    ( ddr2_odt   ) );

  ddr2_model ddr2_model_i (
    .ck            ( ddr2_ck_p  ),
    .ck_n          ( ddr2_ck_n  ),
    .cke           ( ddr2_cke   ),
    .cs_n          ( ddr2_cs_n  ),
    .ras_n         ( ddr2_ras_n ),
    .cas_n         ( ddr2_cas_n ),
    .we_n          ( ddr2_we_n  ),
    .dm_rdqs       ( ddr2_dm    ),
    .ba            ( ddr2_ba    ),
    .addr          ( ddr2_addr  ),
    .dq            ( ddr2_dq    ),
    .dqs           ( ddr2_dqs_p ),
    .dqs_n         ( ddr2_dqs_n ),
    .rdqs_n        (            ),
    .odt           ( ddr2_odt   ) );

endmodule : tb_nexys4ddr_mig_demo
