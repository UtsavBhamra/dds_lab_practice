module test;

reg a,b;
wire sum,cout;

half_adder uut(sum,cout,a,b);

initial begin
    $dumpfile("visualize.vcd");
    $dumpvars(0,test);
end

initial begin
    $display("a | b | s | c");
    $monitor("%b | %b | %b | %b",a,b,sum,cout);
    for(integer i=0;i<4;i=i+1)begin
        {a,b}=i;
        #10;
    end
    $finish;
end

endmodule