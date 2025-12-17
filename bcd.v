module bcd (
    input clk,
    input reset,   // Synchronous active-high reset
    output [3:1] ena,
    output [15:0] q,
    output reg [3:0] digit0, digit1, digit2, digit3
);

    
    
    // Enable signals for higher digits
    assign ena[1] = (digit0 == 4'd9);
    assign ena[2] = (digit1 == 4'd9) && ena[1];
    assign ena[3] = (digit2 == 4'd9) && ena[2];
    
    always @(posedge clk) begin
        if (reset) begin
            digit0 <= 4'd0;
            digit1 <= 4'd0;
            digit2 <= 4'd0;
            digit3 <= 4'd0;
        end else begin
            if (digit0 == 4'd9) begin
                digit0 <= 4'd0;
                if (ena[1]) begin
                    if (digit1 == 4'd9) begin
                        digit1 <= 4'd0;
                        if (ena[2]) begin
                            if (digit2 == 4'd9) begin
                                digit2 <= 4'd0;
                                if (ena[3]) begin
                                    if (digit3 == 4'd9)
                                        digit3 <= 4'd0;
                                    else
                                        digit3 <= digit3 + 4'd1;
                                end
                            end else begin
                                digit2 <= digit2 + 4'd1;
                            end
                        end
                    end else begin
                        digit1 <= digit1 + 4'd1;
                    end
                end
            end else begin
                digit0 <= digit0 + 4'd1;
            end
        end
    end
    
    assign q = {digit3, digit2, digit1, digit0};
    
endmodule
