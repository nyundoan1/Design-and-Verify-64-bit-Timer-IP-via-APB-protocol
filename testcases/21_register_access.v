task run_test;
reg [31:0] tb_rdata;
begin 
	$display("===============================================");
	$display("        Pat name: Check Register Access       ]");
	$display("===============================================");

	$display("=====================================================================================");
	$display("=========[                             TCR Register                     ]============");
	$display("=====================================================================================");

	test_bench.apb_write(ADDR_TCR, D0, 4'hf);
	test_bench.apb_read(ADDR_TCR, tb_rdata);
	test_bench.compare_data(ADDR_TCR, D0, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TCR, 32'hFFFF_F8FF, 4'hf);
	test_bench.apb_read(ADDR_TCR, tb_rdata);
	test_bench.compare_data(ADDR_TCR, 32'h0000_0803, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TCR, DF, 4'hf);
	test_bench.apb_read(ADDR_TCR, tb_rdata);
	test_bench.compare_data(ADDR_TCR, 32'h0000_0803, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TCR, DA, 4'hf);
	test_bench.apb_read(ADDR_TCR, tb_rdata);
	test_bench.compare_data(ADDR_TCR, 32'h0000_0803, tb_rdata, 32'hffff_ffff); 


	$display("=====================================================================================");
	$display("=========[                            TDR0 Register                     ]============");
	$display("=====================================================================================");

	test_bench.apb_write(ADDR_TDR0, D0, 4'hf);
	test_bench.apb_read(ADDR_TDR0, tb_rdata);
	test_bench.compare_data(ADDR_TDR0, D0, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TDR0, D5, 4'hf);
	test_bench.apb_read(ADDR_TDR0, tb_rdata);
	test_bench.compare_data(ADDR_TDR0, D5, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TDR0, DA, 4'hf);
	test_bench.apb_read(ADDR_TDR0, tb_rdata);
	test_bench.compare_data(ADDR_TDR0, DA, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TDR0, DF, 4'hf);
	test_bench.apb_read(ADDR_TDR0, tb_rdata);
	test_bench.compare_data(ADDR_TDR0, DF, tb_rdata, 32'hffff_ffff); 



	test_bench.apb_write(ADDR_TDR0, 32'ha555_555a, 4'hf);
	test_bench.apb_read(ADDR_TDR0, tb_rdata);
	test_bench.compare_data(ADDR_TDR0,32'ha555_555a, tb_rdata, 32'hffff_ffff);

	test_bench.apb_write(ADDR_TDR0, 32'haa5a_a5aa, 4'hf);
	test_bench.apb_read(ADDR_TDR0, tb_rdata);
	test_bench.compare_data(ADDR_TDR0, 32'haa5a_a5aa, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TDR0, 32'ha55a_a55a, 4'hf);
	test_bench.apb_read(ADDR_TDR0, tb_rdata);
	test_bench.compare_data(ADDR_TDR0, 32'ha55a_a55a, tb_rdata, 32'hffff_ffff); 


	$display("=====================================================================================");
	$display("=========[                            TDR1 Register                     ]============");
	$display("=====================================================================================");

	test_bench.apb_write(ADDR_TDR1, D0, 4'hf);
	test_bench.apb_read(ADDR_TDR1, tb_rdata);
	test_bench.compare_data(ADDR_TDR1, D0, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TDR1, D5, 4'hf);
	test_bench.apb_read(ADDR_TDR1, tb_rdata);
	test_bench.compare_data(ADDR_TDR1, D5, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TDR1, DA, 4'hf);
	test_bench.apb_read(ADDR_TDR1, tb_rdata);
	test_bench.compare_data(ADDR_TDR1, DA, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TDR1, DF, 4'hf);
	test_bench.apb_read(ADDR_TDR1, tb_rdata);
	test_bench.compare_data(ADDR_TDR1, DF, tb_rdata, 32'hffff_ffff);

	test_bench.apb_write(ADDR_TDR1, D0, 4'hf);
	test_bench.apb_read(ADDR_TDR1, tb_rdata);
	test_bench.compare_data(ADDR_TDR1, D0, tb_rdata, 32'hffff_ffff); 


	test_bench.apb_write(ADDR_TDR1, 32'ha555_555a, 4'hf);
	test_bench.apb_read(ADDR_TDR1, tb_rdata);
	test_bench.compare_data(ADDR_TDR1, 32'ha555_555a, tb_rdata, 32'hffff_ffff);

	test_bench.apb_write(ADDR_TDR1, 32'haa5a_a5aa, 4'hf);
	test_bench.apb_read(ADDR_TDR1, tb_rdata);
	test_bench.compare_data(ADDR_TDR1, 32'haa5a_a5aa, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TDR1, 32'h5555_aaaa, 4'hf);
	test_bench.apb_read(ADDR_TDR1, tb_rdata);
	test_bench.compare_data(ADDR_TDR1, 32'h5555_aaaa, tb_rdata, 32'hffff_ffff); 

	$display("=====================================================================================");
	$display("=========[                           TCMP0 Register                     ]============");
	$display("=====================================================================================");

	test_bench.apb_write(ADDR_TCMP0, D0, 4'hf);
	test_bench.apb_read(ADDR_TCMP0, tb_rdata);
	test_bench.compare_data(ADDR_TCMP0, D0, tb_rdata, 32'hffff_ffff);

	test_bench.apb_write(ADDR_TCMP0, D5, 4'hf);
	test_bench.apb_read(ADDR_TCMP0, tb_rdata);
	test_bench.compare_data(ADDR_TCMP0, D5, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TCMP0, DA, 4'hf);
	test_bench.apb_read(ADDR_TCMP0, tb_rdata);
	test_bench.compare_data(ADDR_TCMP0, DA, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TCMP0, DF, 4'hf);
	test_bench.apb_read(ADDR_TCMP0, tb_rdata);
	test_bench.compare_data(ADDR_TCMP0, DF, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TCMP0, 32'ha555_555a, 4'hf);
	test_bench.apb_read(ADDR_TCMP0, tb_rdata);
	test_bench.compare_data(ADDR_TCMP0, 32'ha555_555a, tb_rdata, 32'hffff_ffff);

	test_bench.apb_write(ADDR_TCMP0, 32'haa5a_a5aa, 4'hf);
	test_bench.apb_read(ADDR_TCMP0, tb_rdata);
	test_bench.compare_data(ADDR_TCMP0, 32'haa5a_a5aa, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TCMP0, 32'ha55a_a55a, 4'hf);
	test_bench.apb_read(ADDR_TCMP0, tb_rdata);
	test_bench.compare_data(ADDR_TCMP0, 32'ha55a_a55a, tb_rdata, 32'hffff_ffff); 	


	$display("=====================================================================================");
	$display("=========[                           TCMP1 Register                     ]============");
	$display("=====================================================================================");

	test_bench.apb_write(ADDR_TCMP1, D0, 4'hf);
	test_bench.apb_read(ADDR_TCMP1, tb_rdata);
	test_bench.compare_data(ADDR_TCMP1, D0, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TCMP1, D5, 4'hf);
	test_bench.apb_read(ADDR_TCMP1, tb_rdata);
	test_bench.compare_data(ADDR_TCMP1, D5, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TCMP1, DA, 4'hf);
	test_bench.apb_read(ADDR_TCMP1, tb_rdata);
	test_bench.compare_data(ADDR_TCMP1, DA, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TCMP1, DF, 4'hf);
	test_bench.apb_read(ADDR_TCMP1, tb_rdata);
	test_bench.compare_data(ADDR_TCMP1, DF, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TCMP1, 32'ha555_555a, 4'hf);
	test_bench.apb_read(ADDR_TCMP1, tb_rdata);
	test_bench.compare_data(ADDR_TCMP1, 32'ha555_555a, tb_rdata, 32'hffff_ffff);

	test_bench.apb_write(ADDR_TCMP1, 32'haa5a_a5aa, 4'hf);
	test_bench.apb_read(ADDR_TCMP1, tb_rdata);
	test_bench.compare_data(ADDR_TCMP1, 32'haa5a_a5aa, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TCMP1, 32'ha55a_a55a, 4'hf);
	test_bench.apb_read(ADDR_TCMP1, tb_rdata);
	test_bench.compare_data(ADDR_TCMP1, 32'ha55a_a55a, tb_rdata, 32'hffff_ffff); 




	$display("=====================================================================================");
	$display("=========[                           TIER Register                      ]============");
	$display("=====================================================================================");

	test_bench.apb_write(ADDR_TIER, D0, 4'hf);
	test_bench.apb_read(ADDR_TIER, tb_rdata);
	test_bench.compare_data(ADDR_TIER, D0, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TIER, D5, 4'hf);
	test_bench.apb_read(ADDR_TIER, tb_rdata);
	test_bench.compare_data(ADDR_TIER, 32'h0000_0001, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TIER, DA, 4'hf);
	test_bench.apb_read(ADDR_TIER, tb_rdata);
	test_bench.compare_data(ADDR_TIER, D0, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TIER, DF, 4'hf);
	test_bench.apb_read(ADDR_TIER, tb_rdata);
	test_bench.compare_data(ADDR_TIER, 32'h0000_0001, tb_rdata, 32'hffff_ffff); 

	$display("=====================================================================================");
	$display("=========[                           TISR Register                      ]============");
	$display("=====================================================================================");

	test_bench.apb_write(ADDR_TISR, D0, 4'hf);
	test_bench.apb_read(ADDR_TISR, tb_rdata);
	test_bench.compare_data(ADDR_TISR, D0, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TISR, D5, 4'hf);
	test_bench.apb_read(ADDR_TISR, tb_rdata);
	test_bench.compare_data(ADDR_TISR, D0, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(ADDR_TISR, DA, 4'hf);
	test_bench.apb_read(ADDR_TISR, tb_rdata);
	test_bench.compare_data(ADDR_TISR, D0, tb_rdata, 32'hffff_ffff);

	test_bench.apb_write(ADDR_TISR, DF, 4'hf);
	test_bench.apb_read(ADDR_TISR, tb_rdata);
	test_bench.compare_data(ADDR_TISR, D0, tb_rdata, 32'hffff_ffff);

	$display("=====================================================================================");
	$display("=========[                           THCSR Register                     ]============");
	$display("=====================================================================================");
	test_bench.apb_write(ADDR_THCSR, D0, 4'hf);
	test_bench.apb_read(ADDR_THCSR, tb_rdata);
	test_bench.compare_data(ADDR_THCSR, D0, tb_rdata, 32'hffff_ffff);

	test_bench.apb_write(ADDR_THCSR, DA, 4'hf);
	test_bench.apb_read(ADDR_THCSR, tb_rdata);
	test_bench.compare_data(ADDR_THCSR, D0, tb_rdata, 32'hffff_ffff);

	test_bench.apb_write(ADDR_THCSR, DF, 4'hf);
	test_bench.apb_read(ADDR_THCSR, tb_rdata);
	test_bench.compare_data(ADDR_THCSR, 32'h0000_0001, tb_rdata, 32'hffff_ffff);

	if(test_bench.err_num == 0 ) begin
		$display("=====================================================================================");
		$display("=========[                        TEST : PASS ALL                   ]============");
		$display("=====================================================================================");
	end else begin 
		$display("=====================================================================================");
		$display("=========[                         TEST : FAIL****                      ]============");
		$display("=====================================================================================");
	end
end
endtask

