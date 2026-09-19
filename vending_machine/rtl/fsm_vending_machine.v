module fsm_vending_machine (
    input  clk, reset, coin_5, coin_10, coin_25, req_item_a, req_item_b,

    output reg dispense_a, dispense_b, insufficient_funds,
    
    output reg [7:0] change_returned,

    output reg [7:0] total_funds
);

   
    localparam [7:0] PRICE_A = 8'd15;
    localparam [7:0] PRICE_B = 8'd40;

    localparam [2:0]
        IDLE     = 3'd0,
        ADD_COIN = 3'd1,
        CHECK_A  = 3'd2,
        CHECK_B  = 3'd3,
        VEND_A   = 3'd4,
        VEND_B   = 3'd5,
        WARN     = 3'd6;

    reg [2:0] current_state;
    reg [2:0] next_state;

    reg ctrl_add_5;
    reg ctrl_add_10;
    reg ctrl_add_25;
    reg ctrl_clear_funds;

    wire funds_ok_a;
    wire funds_ok_b;

    assign funds_ok_a = (total_funds >= PRICE_A);
    assign funds_ok_b = (total_funds >= PRICE_B);

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            total_funds <= 8'd0;
        end
        
        else begin        
            if (ctrl_clear_funds) begin
                total_funds <= 8'd0;
            end

            else if (ctrl_add_25) begin
                total_funds <= total_funds + 8'd25;
            end

            else if (ctrl_add_10) begin
                total_funds <= total_funds + 8'd10;
            end

            else if (ctrl_add_5) begin
                total_funds <= total_funds + 8'd5;
            end
        end
    end

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            current_state <= IDLE;
        end

        else begin
            current_state <= next_state;
        end

    end

    always @(*) begin

        next_state = current_state;

        case (current_state)

            IDLE: begin

                if (coin_5 || coin_10 || coin_25) begin
                    next_state = ADD_COIN;
                end

                else if (req_item_a) begin
                    next_state = CHECK_A;
                end

                else if (req_item_b) begin
                    next_state = CHECK_B;
                end

                else begin
                    next_state = IDLE;
                end

            end

            ADD_COIN: begin
                next_state = IDLE;
            end

            CHECK_A: begin

                if (funds_ok_a)
                    next_state = VEND_A;
                else
                    next_state = WARN;

            end

            CHECK_B: begin

                if (funds_ok_b)
                    next_state = VEND_B;
                else
                    next_state = WARN;

            end

            VEND_A: begin
                next_state = IDLE;
            end

            VEND_B: begin
                next_state = IDLE;
            end

            WARN: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end

        endcase

    end

    always @(*) begin

        dispense_a         = 1'b0;
        dispense_b         = 1'b0;
        insufficient_funds = 1'b0;

        ctrl_add_5       = 1'b0;
        ctrl_add_10      = 1'b0;
        ctrl_add_25      = 1'b0;
        ctrl_clear_funds = 1'b0;

        case (current_state)

            ADD_COIN: begin

                if (coin_25) begin
                    ctrl_add_25 = 1'b1;
                end

                else if (coin_10) begin
                    ctrl_add_10 = 1'b1;
                end

                else if (coin_5) begin
                    ctrl_add_5 = 1'b1;
                end

            end            

            VEND_A: begin

                dispense_a = 1'b1;
                
                ctrl_clear_funds = 1'b1;

            end

            VEND_B: begin

                dispense_b = 1'b1;
                
                ctrl_clear_funds = 1'b1;

            end

            WARN: begin

                insufficient_funds = 1'b1;

            end

            default: begin
                
            end

        endcase

    end
    
    always @(posedge clk or posedge reset) begin

        if (reset) begin
            
            change_returned <= 8'd0;
        end

        else begin

            if (current_state == VEND_A) begin

                change_returned <= total_funds - PRICE_A;

            end

            else if (current_state == VEND_B) begin

                change_returned <= total_funds - PRICE_B;

            end

            else if (current_state == IDLE) begin
              
                change_returned <= change_returned;

            end

        end

    end

endmodule
