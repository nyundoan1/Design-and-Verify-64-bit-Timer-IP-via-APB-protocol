coverage exclude -src ../rtl/apb_reg_cnt.v -code e -line 54 -comment {wr en never get 1 when psel=0} 
coverage exclude -src ../rtl/apb_reg_cnt.v -code e -line 62 -comment {rd en never get 1 when psel = 0} 
coverage exclude -src ../rtl/apb_reg_cnt.v -code e -line 94 -comment {pwdata[11:8] >= 9 is blocked by TCR validation logic, making this condition unreachable} 
coverage exclude -src ../rtl/cnt_ctrl.v -code e -line 45 -comment {div_val is restricted by design and this condition cannot occur in any operational mode} 
