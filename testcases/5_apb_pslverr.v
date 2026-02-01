task run_test;
reg [31:0] tb_rdata;
reg [3:0] div_val;
integer i;
begin 
	i = 0;
	div_val = 4'h0;
	$display("=====================================================================================");
	$display("[                            Pat name: Check APB  SLAVE ERROR                       ]");
	$display("=====================================================================================");

	$display("=====================================================================================");
	$display("=========[                      SET PROHIBITED DIV VAL                  ]============");
	$display("=====================================================================================");

	for(i = 9;  i<16; i = i +1) begin
		div_val = i;
		$display("------------------------------------------ "); 
		test_bench.apb_write(ADDR_TCR, {20'h0,div_val,8'h0} , 4'b0010); #1;
		if(test_bench.pslverr_high == 1) begin
			$display(">>> PASS <<<< | PSLVERR is assert when Write %h (Prohitbited Value) to TCR Register", i );
		end else begin
			$display(">>> FAIL <<<< | PSLVERR is NOT assert when Write %h (Prohitbited Value) to TCR Register", i );
		end
		test_bench.apb_read(ADDR_TCR, tb_rdata);
		test_bench.compare_data(ADDR_TCR, 32'h0000_0100, tb_rdata, 32'hffff_ffff); 
	end

	$display("=====================================================================================");
	$display("=========[              Change div_val when timer_en = 1                ]============");
	$display("=====================================================================================");

	$display("===== Set Timer Enable =====");
	test_bench.apb_write(ADDR_TCR, 32'h1 , 4'h1);
	$display("===== Timer Enable = 1 now =====");
	test_bench.apb_write(ADDR_TCR, 32'h0000_0300 , 4'b0010);


	if(test_bench.pslverr_high == 1) begin
		$display(">>> PASS <<<< | PSLVERR is assert when Change div_val while timer_en = 1", i );
		end else begin
		$display(">>> FAIL <<<< | PSLVERR is NOT assert when Change div_val while timer_en = 1", i );
	end

	test_bench.apb_read(ADDR_TCR, tb_rdata);
	test_bench.compare_data(ADDR_TCR, 32'h0000_0101, tb_rdata, 32'hffff_ffff); 

	$display("=====================================================================================");
	$display("=========[                 Change div_en when timer_en = 1             ]============");
	$display("=====================================================================================");

	$display("===== Set Timer Enable =====");
	test_bench.apb_write(ADDR_TCR, 32'h1 , 4'h1);
	$display("===== Timer Enable = 1 now =====");
	test_bench.apb_write(ADDR_TCR, 32'h0000_0003 , 4'b0001);

	if(test_bench.pslverr_high == 1) begin
		$display(">>> PASS <<<< | PSLVERR is assert when Change div_en while timer_en = 1", i );
		end else begin
		$display(">>> FAIL <<<< | PSLVERR is NOT assert when Change div_en while timer_en = 1", i );
	end

	test_bench.apb_read(ADDR_TCR, tb_rdata);
	test_bench.compare_data(ADDR_TCR, 32'h0000_0101, tb_rdata, 32'hffff_ffff); 


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
