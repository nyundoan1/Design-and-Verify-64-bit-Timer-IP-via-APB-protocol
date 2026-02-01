task run_test;
reg [31:0] tb_rdata;
begin 
	$display("===============================================");
	$display("        Pat name: One Hot Check Register      ]");
	$display("===============================================");

	test_bench.apb_write(ADDR_TCR, 32'h1111_1112, 4'hf);
	test_bench.apb_write(ADDR_TDR0, D2, 4'hf);
	test_bench.apb_write(ADDR_TDR1, D3, 4'hf);
	test_bench.apb_write(ADDR_TCMP0, D4, 4'hf);
	test_bench.apb_write(ADDR_TCMP1, D5, 4'hf);
	test_bench.apb_write(ADDR_TIER, D9, 4'hf);
	test_bench.apb_write(ADDR_TISR, DA, 4'hf);
	test_bench.apb_write(ADDR_THCSR, DF, 4'hf);



	test_bench.apb_read(ADDR_TCR, tb_rdata);
	test_bench.compare_data(ADDR_TCR, 32'h0000_0102, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_read(ADDR_TDR0, tb_rdata);
	test_bench.compare_data(ADDR_TDR0, 32'h2222_2222, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_read(ADDR_TDR1, tb_rdata);
	test_bench.compare_data(ADDR_TDR1, 32'h3333_3333, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_read(ADDR_TCMP0, tb_rdata);
	test_bench.compare_data(ADDR_TCMP0, 32'h4444_4444, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_read(ADDR_TCMP1, tb_rdata);
	test_bench.compare_data(ADDR_TCMP1, 32'h5555_5555, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_read(ADDR_TIER, tb_rdata);
	test_bench.compare_data(ADDR_TIER, 32'h0000_0001, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_read(ADDR_TISR, tb_rdata);
	test_bench.compare_data(ADDR_TISR, 32'h0000_0000, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_read(ADDR_THCSR, tb_rdata);
	test_bench.compare_data(ADDR_THCSR, 32'h0000_0001, tb_rdata, 32'hffff_ffff); 


	if(test_bench.err_num == 0 ) begin
		$display("=====================================================================================");
		$display("=========[                        TEST : PASS ALL                       ]============");
		$display("=====================================================================================");
	end else begin 
		$display("=====================================================================================");
		$display("=========[                         TEST : FAIL****                      ]============");
		$display("=====================================================================================");
	end
end
endtask

