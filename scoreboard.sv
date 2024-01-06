class scoreboard extends uvm_scoreboard;
`uvm_component_utils(scoreboard)
uvm_analysis_imp #(sequence_item,scoreboard) score_mail ; 

int passed_test_cases = 0                ; 
int failed_test_cases = 0                ; 
static reg [15:0] golden_memory [15:0]   ; 
static int  golgen_output                ;

function  new(string name = "SCOREBOARD", uvm_component parent = null);
    super.new(name,parent) ; 
endfunction 

function void build_phase(uvm_phase phase);
    super.build_phase(phase) ;
    `uvm_info("SCOREBOARD","WE Are Compiling The Scoreboard",UVM_NONE);
    score_mail = new("score_mail",this) ; 
endfunction

function void connect_phase(uvm_phase phase);
    super.connect_phase(phase) ; 
endfunction

task run_phase (uvm_phase phase) ; 

    `uvm_info("SCOREBOARD","WE ARE RUNNING THE SCOREBOARD",UVM_NONE);

endtask 

task write (sequence_item t_score);
    t_score.display_Sequence_item("SCOREBOARD") ; 
    /************************  Reset Test Case ************************/
      if (t_score.rst_tb == 0) begin 
        for (int i=0 ; i < 16 ; i = i +1)
          begin
            golden_memory[i] = 0 ;
          end
        golgen_output = 0 ; 
        if (t_score.RdData_tb == golgen_output)
          begin 
           $display("Reset Test Case Passed At time : %0P",$realtime()) ; 
           passed_test_cases++  ; 
          end
          else  begin
            $display("Reset Test Case Failed At time : %0P",$realtime()) ; 
            failed_test_cases++ ; 
          end
      end  
      /*******************************************************************/
      /************************  Write Test Case *************************/
      else if (t_score.WrEn_tb == 1) begin 
        golden_memory[t_score.Address_tb] = t_score.WrData_tb   ; 
        if (t_score.RdData_tb == golgen_output)
          begin 
           $display("Write Test Case Passed At time : %0P",$realtime()) ; 
           passed_test_cases++  ; 
          end
          else  begin
            $display("Write Test Case Failed At time : %0P",$realtime()) ; 
            failed_test_cases++ ; 
          end
      end  
      /*******************************************************************/
      /************************  Read Test Case **************************/
      else if (t_score.RdEn_tb == 1) begin 
        golgen_output = golden_memory[t_score.Address_tb]   ; 
        if (t_score.RdData_tb == golgen_output)
          begin 
           $display("Read Test Case Passed At time : %0P",$realtime()) ; 
           passed_test_cases++  ; 
          end
          else  begin
            $display("Read Test Case Failed At time : %0P",$realtime()) ; 
            failed_test_cases++ ; 
          end
      end  
      /*******************************************************************/
endtask 

task display_test_cases_report () ;

    $display("The Number of Passed test cases is :%0P " , passed_test_cases ) ; 
    $display("The Number of Failed test cases is :%0P " , failed_test_cases ) ; 
  
endtask 

endclass