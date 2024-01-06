class sequence_item extends uvm_sequence_item  ;
/*Register To The Factory Using object utils */
`uvm_object_utils(sequence_item)

/* declaration of the input output signals */
// This is the base transaction object Container that will be used 
// in the environment to initiate new transactions and // capture transactions at DUT interface
rand  bit        rst_tb          ;
rand  bit        WrEn_tb         ;
rand  bit        RdEn_tb         ;
randc bit [3:0]  Address_tb      ; 
rand  bit [15:0] WrData_tb       ; 
bit       [15:0] RdData_tb       ; 


/* declaration of the Constraints for input output signals */

      constraint un { unique {WrEn_tb,RdEn_tb} ;  }

function  new(string name = "SEQUENCE_ITEM ");
    super.new(name) ; 
endfunction

/* Function to display the transaction at any time*/

function void display_Sequence_item(input string name = "SEQUENCE ITEM" ); 

    $display ("*************** This is the %0P **********************",name)      ;  
    $display (" rst_tb     = %0d WrEn_tb    =   %0d  ", rst_tb    , WrEn_tb     ) ; 
    $display (" RdEn_tb    = %0d Address_tb =   %0d  ", RdEn_tb   , Address_tb  ) ; 
    $display (" WrData_tb  = %0d RdData_tb  =   %0d  ", WrData_tb , RdData_tb   ) ; 
    $display ("**********************************************************")       ;
    
endfunction 

endclass
    

	  