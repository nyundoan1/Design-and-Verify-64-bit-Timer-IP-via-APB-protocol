task run_test;
reg [31:0] tb_rdata;
begin 
	$display("===============================================");
	$display("        Pat name: Check Register Reserved      ]");
	$display("===============================================");

	test_bench.apb_write(12'h100, DF, 4'hf);
	test_bench.apb_read(12'h100, tb_rdata);
	test_bench.compare_data(12'h100, D0, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(12'h595, DF, 4'hf);
	test_bench.apb_read(12'h595, tb_rdata);
	test_bench.compare_data(12'h595, D0, tb_rdata, 32'hffff_ffff); 

	test_bench.apb_write(12'h3FC, DF, 4'hf);
	test_bench.apb_read(12'h3FC, tb_rdata);
	test_bench.compare_data(12'h3FC, D0, tb_rdata, 32'hffff_ffff); 


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

