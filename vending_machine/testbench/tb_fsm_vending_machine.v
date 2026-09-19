`timescale 1ns/1ps

module tb_fsm_vending_machine;
    reg clk;
    reg reset;

    reg coin_5;
    reg coin_10;
    reg coin_25;

    reg req_item_a;
    reg req_item_b;


    wire dispense_a;
    wire dispense_b;
    wire insufficient_funds;
    wire [7:0] change_returned;
    wire [7:0] total_funds;


    fsm_vending_machine DUT (

        .clk(clk),
        .reset(reset),

        .coin_5(coin_5),
        .coin_10(coin_10),
        .coin_25(coin_25),

        .req_item_a(req_item_a),
        .req_item_b(req_item_b),

        .dispense_a(dispense_a),
        .dispense_b(dispense_b),
        .insufficient_funds(insufficient_funds),
        .change_returned(change_returned),
        .total_funds(total_funds)

    );

    initial begin

        clk = 1'b0;

        forever #5 clk = ~clk;

    end
    
    initial begin

        $dumpfile("vending_machine.vcd");
        $dumpvars(0, tb_fsm_vending_machine);

        reset = 1'b0;

        coin_5  = 1'b0;
        coin_10 = 1'b0;
        coin_25 = 1'b0;

        req_item_a = 1'b0;
        req_item_b = 1'b0;

    end


    initial begin

        
        // TEST 1: RESET
        $display("========================================");
        $display("TEST 1: RESET");
        $display("========================================");

        reset = 1'b1;

        #10;

        reset = 1'b0;

        #10;

        $display("Total funds = %d", total_funds);

        // TEST 2: INSERT ₹5

        $display("========================================");
        $display("TEST 2: INSERT ₹5");
        $display("========================================");

        coin_5 = 1'b1;

        #10;

        coin_5 = 1'b0;

        #10;

        $display("Total funds = %d", total_funds);


        
        // TEST 3: INSERT ₹10
        // Total should become ₹15

        $display("========================================");
        $display("TEST 3: INSERT ₹10");
        $display("========================================");

        coin_10 = 1'b1;

        #10;

        coin_10 = 1'b0;

        #10;

        $display("Total funds = %d", total_funds);

        // TEST 4: BUY ITEM A
        // Price A = ₹15
        // Expected:
        // dispense_a = 1
        // change = 0
        // total_funds = 0

        $display("========================================");
        $display("TEST 4: BUY ITEM A");
        $display("========================================");

        req_item_a = 1'b1;

        #10;

        req_item_a = 1'b0;

        #20;

        $display("Dispense A       = %b", dispense_a);
        $display("Change returned  = %d", change_returned);
        $display("Total funds      = %d", total_funds);


        
        // TEST 5: INSERT ₹25
        

        $display("========================================");
        $display("TEST 5: INSERT ₹25");
        $display("========================================");

        coin_25 = 1'b1;

        #10;

        coin_25 = 1'b0;

        #10;

        $display("Total funds = %d", total_funds);


        
        // TEST 6: BUY ITEM A WITH ₹25
        // Expected change = ₹10
        
        $display("========================================");
        $display("TEST 6: BUY ITEM A WITH ₹25");
        $display("========================================");

        req_item_a = 1'b1;

        #10;

        req_item_a = 1'b0;

        #20;

        $display("Dispense A       = %b", dispense_a);
        $display("Change returned  = %d", change_returned);
        $display("Total funds      = %d", total_funds);

        // TEST 7: INSERT ₹40

        $display("========================================");
        $display("TEST 7: INSERT ₹40");
        $display("========================================");

        coin_25 = 1'b1;

        #10;

        coin_25 = 1'b0;

        #10;

        coin_10 = 1'b1;

        #10;

        coin_10 = 1'b0;

        #10;

        coin_5 = 1'b1;

        #10;

        coin_5 = 1'b0;

        #10;

        $display("Total funds = %d", total_funds);


        // TEST 8: BUY ITEM B
        // Price B = ₹40
        // Expected:
        // dispense_b = 1
        // change = 0

        $display("========================================");
        $display("TEST 8: BUY ITEM B");
        $display("========================================");

        req_item_b = 1'b1;

        #10;

        req_item_b = 1'b0;

        #20;

        $display("Dispense B       = %b", dispense_b);
        $display("Change returned  = %d", change_returned);
        $display("Total funds      = %d", total_funds);


        
        // TEST 9: INSUFFICIENT FUNDS
        // Insert ₹10
        // Request B (₹40)

        $display("========================================");
        $display("TEST 9: INSUFFICIENT FUNDS");
        $display("========================================");

        coin_10 = 1'b1;

        #10;

        coin_10 = 1'b0;

        #10;

        req_item_b = 1'b1;

        #10;

        req_item_b = 1'b0;

        #20;

        $display("Insufficient funds = %b", insufficient_funds);
        $display("Total funds        = %d", total_funds);


        // TEST 10: ADD MORE MONEY AFTER INSUFFICIENT FUNDS
        // Existing = ₹10
        // Add ₹25 + ₹5
        // Total = ₹40
        $display("========================================");
        $display("TEST 10: ADD MORE MONEY");
        $display("========================================");

        coin_25 = 1'b1;

        #10;

        coin_25 = 1'b0;

        #10;

        coin_5 = 1'b1;

        #10;

        coin_5 = 1'b0;

        #10;

        $display("Total funds = %d", total_funds);


        
        // TEST 11: BUY ITEM B AFTER ADDING MONEY
    

        $display("========================================");
        $display("TEST 11: BUY ITEM B");
        $display("========================================");

        req_item_b = 1'b1;

        #10;

        req_item_b = 1'b0;

        #20;

        $display("Dispense B       = %b", dispense_b);
        $display("Change returned  = %d", change_returned);
        $display("Total funds      = %d", total_funds);


        
        // END SIMULATION

        $display("========================================");
        $display("ALL TESTS COMPLETED");
        $display("========================================");

        #20;

        $finish;

    end


    
    // 7. MONITOR IMPORTANT SIGNALS

    initial begin

        $monitor(
            "TIME=%0t | CLK=%b | RESET=%b | COINS=%b%b%b | REQ_A=%b | REQ_B=%b | FUNDS=%d | DISP_A=%b | DISP_B=%b | WARN=%b | CHANGE=%d",
            $time,
            clk,
            reset,
            coin_25,
            coin_10,
            coin_5,
            req_item_a,
            req_item_b,
            total_funds,
            dispense_a,
            dispense_b,
            insufficient_funds,
            change_returned
        );

    end

endmodule