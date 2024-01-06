module tb ()  ;

    import uvm_pkg::*   ;  
    import pack1::*     ;
    intf intf1()        ; 

    RegFile REG_TEST (
    .clk        (intf1.clk_intf)     ,
    .rst        (intf1.rst_intf)     , 
    .WrEn       (intf1.WrEn_intf)    ,
    .RdEn       (intf1.RdEn_intf)    ,
    .Address    (intf1.Address_intf) ,
    .WrData     (intf1.WrData_intf)  ,
    .RdData     (intf1.RdData_intf)
    ) ; 
    initial begin 
        intf1.clk_intf = 1 ; 
    end  

    always  begin
       #5 intf1.clk_intf = ~ intf1.clk_intf ; 
    end

    initial begin
        uvm_config_db #(virtual intf)::set(null,"*","my_vif",intf1) ; 
        run_test("test") ; 
    end 
endmodule