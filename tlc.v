module tlc (
        input clk,rst,
        output reg [2:0] ns_light,ew_light
    
);
   
    parameter s0 = 2'b00, s1=2'b01, s2=2'b10, s3=2'b11;
    reg [1:0] current_state,next_state;
    reg [3:0] timer_count;

    always @(posedge clk,posedge rst)
     begin
        if (rst)
        begin
        current_state<=s0;
        timer_count<=4'b0000;
        end
        else
        begin
            current_state<=next_state;
            if (current_state!=next_state)
            timer_count<=4'b0000;
            else
            timer_count<=timer_count+1;
        
        end
    end

    always @(*)
    begin
        case(current_state)
        s0:begin
            if(timer_count==4'd10)
            next_state=s1;
            else
            next_state=s0;
        end
        s1:begin
            if(timer_count==4'd3)
            next_state=s2;
            else
            next_state=s1;
        end
        s2:begin
            if(timer_count==4'd10)
            next_state=s3;
            else
            next_state=s2;
        end
        s3:begin
            if(timer_count==4'd3)
            next_state=s0;
            else
            next_state=s3;
        end
        default: next_state=s0;
        endcase
    end

    always @(*) 
    begin
        case(current_state)
            s0: begin
                ns_light=3'b001;
                ew_light=3'b100;
            end
            s1:begin
               ns_light=3'b010;
             ew_light=3'b100; 
            end
            s2:begin
                ns_light=3'b100;
                ew_light=3'b001;
            end
            s3:begin
                ns_light=3'b100;
                ew_light=3'b010; 
            end
            default: begin
                 ns_light=3'b100;
                 ew_light=3'b100;
            end
        endcase
        
    end

  

endmodule