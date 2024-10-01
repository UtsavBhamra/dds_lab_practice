module test;

reg a,b,cin;
wire sum,cout;

full_adder uut(sum,cout,a,b,cin);

initial begin
    $dumpfile("visualize.vcd");
    $dumpvars(0,test);
end

initial begin
    $display("a b c | s c");
    $monitor("%b %b %b | %b %b",a,b,cin,sum,cout);
    for(integer i=0;i<8;i=i+1)begin
        {a,b,cin}=i;
        #10;
    end
    $finish;
end

endmodule