// Gate-level model using T Flip-flops
module seq_detector_gate(
    input wire clk,
    input wire rst,
    input wire x,
    output wire z
);
    wire t1, t2, t3;  // T inputs for flip-flops
    wire q1, q2, q3;  // Outputs of flip-flops
    
    // T-FF implementations
    tff ff1(.clk(clk), .rst(rst), .t(t1), .q(q1));
    tff ff2(.clk(clk), .rst(rst), .t(t2), .q(q2));
    tff ff3(.clk(clk), .rst(rst), .t(t3), .q(q3));
    
    // Combinational logic for T inputs
    assign t1 = (x == 0) & (~q1 | (q2 & q3));
    assign t2 = (x == 0) & (q1 & ~q2);
    assign t3 = (x == 0) & (q1 & q2 & ~q3);
    
    // Output logic
    assign z = x & ((q1 & q2 & ~q3) | (q1 & ~q2 & ~q3));

endmodule

// T Flip-flop module
module tff(
    input wire clk,
    input wire rst,
    input wire t,
    output reg q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else if (t)
            q <= ~q;
    end
endmodule

// Behavioral model
module seq_detector_behavioral(
    input wire clk,
    input wire rst,
    input wire x,
    output reg z
);
    reg [2:0] state, next_state;
    
    // State encoding
    parameter S0 = 3'b000;  // Initial state
    parameter S1 = 3'b001;  // Seen 0
    parameter S2 = 3'b010;  // Seen 00
    parameter S3 = 3'b011;  // Seen 000
    
    // State register
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            S0: next_state = (x == 0) ? S1 : S0;
            S1: next_state = (x == 0) ? S2 : S0;
            S2: next_state = (x == 0) ? S3 : (x == 1) ? S0 : S2;
            S3: next_state = (x == 0) ? S3 : S0;
            default: next_state = S0;
        endcase
    end
    
    // Output logic
    always @(*) begin
        z = (x == 1) && ((state == S2) || (state == S3));
    end
endmodule

// Testbench
module seq_detector_tb;
    reg clk, rst, x;
    wire z_gate, z_behav;
    
    // Instantiate both models
    seq_detector_gate gate_model(
        .clk(clk),
        .rst(rst),
        .x(x),
        .z(z_gate)
    );
    
    seq_detector_behavioral behav_model(
        .clk(clk),
        .rst(rst),
        .x(x),
        .z(z_behav)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Test stimulus
    initial begin
        // Initialize
        rst = 1;
        x = 0;
        #10 rst = 0;
        
        // Test sequence: 1000100100001
        #10 x = 1;
        #10 x = 0;
        #10 x = 0;
        #10 x = 0;
        #10 x = 1;
        #10 x = 0;
        #10 x = 0;
        #10 x = 1;
        #10 x = 0;
        #10 x = 0;
        #10 x = 0;
        #10 x = 0;
        #10 x = 1;
        
        // Add some delay and finish
        #20 $finish;
    end
    
    // Monitor changes
    initial begin
        $monitor("Time=%0t rst=%b x=%b z_gate=%b z_behav=%b", 
                 $time, rst, x, z_gate, z_behav);
    end
endmodule
