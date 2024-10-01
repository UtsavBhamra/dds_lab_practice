module test;

reg [3:0] a;
reg [3:0] b;
wire g,e,l;

comparator2 uut(g,e,l,a,b);

initial begin
    $dumpfile("visualize.vcd");
    $dumpvars(0,test);
end

initial begin
    $monitor("%b %b | %b %b %b",a,b,g,e,l);
    for(integer i=0;i<8;i=i+1)begin
        a=i;b=i+2;
        #10;
    end
    $finish;
end

endmodule