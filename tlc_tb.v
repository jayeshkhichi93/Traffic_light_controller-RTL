module tlc_tb;
reg clk,rst;
wire [2:0] ns_light,ew_light;

tlc uut(.clk(clk),.rst(rst),.ns_light(ns_light),.ew_light(ew_light));

always #1 clk=~clk;

initial begin
    clk=0;
    rst=1;
    #2; rst=0;
  #200;
    $finish;
end
initial begin
    $monitor("Time=%0t | ns_light=%b | ew_light=%b",$time,ns_light,ew_light);
    $dumpfile("tlc.vcd");
    $dumpvars(0,tlc_tb);
end
    
endmodule