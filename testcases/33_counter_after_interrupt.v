task run_test;
reg [63:0] reg_cnt;

begin 
	$display("=====================================================================================");
	$display("[                         Pat name: COUNTER AFTER INTERRUPT                          ]");
	$display("=====================================================================================");

	$display("==========[           COUNTER COMPARE VALUE & TURN ON INT_EN               ]=========");
	$display("=====================================================================================");  
	test_bench.apb_write(ADDR_TCMP0, 32'ha, 4'hf);
	test_bench.apb_write(ADDR_TCMP1, 32'h0, 4'hf);
	test_bench.apb_write(ADDR_TIER, 32'h1, 4'h1);
	test_bench.apb_read(ADDR_TCMP0, reg_cnt[31:0]);
	test_bench.apb_read(ADDR_TCMP1, reg_cnt[63:32]);
	$display(" DONE Write: cmp_64b = 64'h%h ",reg_cnt);

	
	$display("=======================================================================================");
	$display("==========[      RUN COUNTER WITH VALUE = 0 -> F  &  CHECK AFTER INTERRUPT   ]=========");
	$display("=======================================================================================");
	test_bench.run_timer(64'h0000_0000_0000_0000 , 4'h1 , 1'b0 , 15 , reg_cnt );
	if(test_bench.tim_int == 1) $display(" tim.int is ASSERT ");
	else  $display(" tim.int is NOT ASSERT ");

	test_bench.check_cnt64(reg_cnt , 64'h0000_0000_0000_000f );
	
	$display("===================================================");
	$display("==========[ CHECK COUNTER INTERRUPT HANG ]=========");
	$display("===================================================");


	if(reg_cnt == 64'h0000_0000_0000_000f) $display(" >>> PASS <<<< | COUNTER STILL RUNNING AFTER INTTERUPT ASSERT");
	else  $display(" >>> FAIL <<<< | COUNTER STILL NOT RUNNING AFTER INTTERUPT ASSERT");


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


