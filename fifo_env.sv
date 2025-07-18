class fifo_env extends uvm_env; 
  `uvm_component_utils(fifo_env)
  
  fifo_write_agent write_agent;
  fifo_read_agent  read_agent;
  fifo_scoreboard  sb; 
  
  function new(string name = "fifo_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase); 
    super.build_phase(phase);
    
    write_agent = fifo_write_agent::type_id::create("write_agent", this);
    read_agent  = fifo_read_agent ::type_id::create("read_agent", this); 
    sb          = fifo_scoreboard ::type_id::create("sb", this); 
    
  endfunction
  
  function void connect_phase(uvm_phase phase); 
    super.connect_phase(phase);
    
    // Connect analysis ports to scoreboard
    write_agent.mon.ap.connect(sb.write_ap);
    read_agent.mon.ap.connect(sb.read_ap); 
  endfunction
endclass
