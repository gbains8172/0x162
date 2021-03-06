`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// VGA verilog template
// Author:  Da Cheng
//////////////////////////////////////////////////////////////////////////////////
module vga_demo(ClkPort, vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b, Sw0, Sw1, btnU, btnD, btnL, btnR, btnC,
	St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar,
	An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
	LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7);
	input ClkPort, Sw0, btnU, btnD, Sw0, Sw1, btnR, btnL, btnC;
	output St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar;
	output vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b;
	output An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp;
	output LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
	
	reg vga_r, vga_g, vga_b;
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/*  LOCAL SIGNALS */
	wire	reset, start, ClkPort, board_clk, clk, button_clk;
	//integer shit;
	BUF BUF1 (board_clk, ClkPort); 	
	BUF BUF2 (reset, Sw0);
	BUF BUF3 (start, Sw1);
	
	reg [27:0]	DIV_CLK;
	always @ (posedge board_clk, posedge reset)  
	begin : CLOCK_DIVIDER
      if (reset)
			DIV_CLK <= 0;
      else
			DIV_CLK <= DIV_CLK + 1'b1;
	end	

	assign	button_clk = DIV_CLK[18];
	assign	clk = DIV_CLK[1];
	assign 	{St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar} = {5'b11111};
	
	wire inDisplayArea;
	wire [9:0] CounterX;
	wire [9:0] CounterY;

	hvsync_generator syncgen(.clk(clk), .reset(reset),.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));
	
	/////////////////////////////////////////////////////////////////
	///////////////		VGA control starts here		/////////////////
	/////////////////////////////////////////////////////////////////
	reg[19:0] playerX;
	reg[14:0] playerY;
	
	reg slot1;
	reg slot2;
	reg slot3;
	reg slot4;
	reg slot5;
	reg slot6;
	
	reg[19:0] row0;
	reg[19:0] row1;
	reg[19:0] row2;
	reg[19:0] row3;
	reg[19:0] row4;
	reg[19:0] row5;
	reg[19:0] row6;
	reg[19:0] row7;
	reg[19:0] row8;
	reg[19:0] row9;
	reg[19:0] row10;
	reg[19:0] row11;
	reg[19:0] row12;
	reg[19:0] row13;
	reg[19:0] row14;
	
	wire win;
	assign win = (playerY[0] && ((playerX & row0) == 0));
	
	reg[19:0] win0;
	reg[19:0] win1;
	reg[19:0] win2;
	reg[19:0] win3;
	reg[19:0] win4;
	reg[19:0] win5;
	reg[19:0] win6;
	reg[19:0] win7;
	reg[19:0] win8;
	reg[19:0] win9;
	reg[19:0] win10;
	reg[19:0] win11;
	reg[19:0] win12;
	reg[19:0] win13;
	reg[19:0] win14;
	
	
	always @(posedge DIV_CLK[23])
		begin // Obsticles always block
			row1 <= {row1[0], row1[19:1]};
			row2 <= {row2[0], row2[19:1]};
			row3 <= {row3[18:0], row3[19]};
			row4 <= {row4[18:0], row4[19]};
			row5 <= {row5[0], row5[19:1]};
			row6 <= {row6[0], row6[19:1]};
			row7 <= {row7[18:0], row7[19]};
			row8 <= {row8[18:0], row8[19]};
			row9 <= {row9[0], row9[19:1]};
			row10 <= {row10[0], row10[19:1]};
			row11 <= {row11[18:0], row11[19]};
			row12 <= {row12[0], row12[19:1]};
			row13 <= {row13[18:0], row13[19]};
			if(reset || btnC)
				begin
					row0 <= 20'b00000000000000000000; // Ending row
					row1 <= 20'b11100000110000010000;
					row2 <= 20'b00000110000100000000;
					row3 <= 20'b10000000000111000000;
					row4 <= 20'b00000010000000000010;
					row5 <= 20'b00000111000000000111;
					row6 <= 20'b01100000000111000000; 
					row7 <= 20'b00000000000000000000; // Middle row
					row8 <= 20'b00001100000000110000;
					row9 <= 20'b00110010000001110000;
					row10 <= 20'b10000000011000000011;
					row11 <= 20'b01000010000001000000;
					row12 <= 20'b00010000000110000000;
					row13 <= 20'b00000011000000000100;
					row14 <= 20'b00000000000000000000; // Starting row
				end
			
			if(win)
				begin
					row0 <= 20'b00000000000000000000; // Ending row
					row1 <= 20'b00000000000000000000;
					row2 <= 20'b00000000000000000000;
					row3 <= 20'b00000000000000000000;
					row4 <= 20'b00000000000000000000;
					row5 <= 20'b00000000000000000000;
					row6 <= 20'b00000000000000000000; 
					row7 <= 20'b00000000000000000000; // Middle row
					row8 <= 20'b00000000000000000000;
					row9 <= 20'b00000000000000000000;
					row10 <= 20'b00000000000000000000;
					row11 <= 20'b00000000000000000000;
					row12 <= 20'b00000000000000000000;
					row13 <= 20'b00000000000000000000;
					row14 <= 20'b00000000000000000000; // Starting row
				end 
		end 
	
	
	always @(posedge DIV_CLK[22])
		begin // Player always block
			
			if(reset || btnC)
				begin
					playerX <= 20'b00000000001000000000;
					playerY <= 15'b100000000000000;
					
					win0 <= 20'b00000000000000000000;
					win1 <= 20'b00000000000000000000;
					win2 <= 20'b00000000000000000000;
					win3 <= 20'b00000000000000000000;
					win4 <= 20'b00000000000000000000;
					win5 <= 20'b00000000000000000000;
					win6 <= 20'b00000000000000000000;
					win7 <= 20'b00000000000000000000;
					win8 <= 20'b00000000000000000000;
					win9 <= 20'b00000000000000000000;
					win10 <= 20'b00000000000000000000;
					win11 <= 20'b00000000000000000000;
					win12 <= 20'b00000000000000000000;
					win13 <= 20'b00000000000000000000;
					win14 <= 20'b00000000000000000000;
					
					slot1 <= 0;
					slot2 <= 0;
					slot3 <= 0;
					slot4 <= 0;
					slot5 <= 0;
					slot6 <= 0;
				end
			 
				
			else if(btnD && ~btnU && ~playerY[14])
				playerY <= {playerY[13:0], playerY[14]};
				
			else if(btnU && ~btnD && ~playerY[0])
				playerY <= {playerY[0], playerY[14:1]};
				
			else if(btnR && ~btnL && ~playerX[19])
				playerX <= {playerX[18:0], playerX[19]};
				
			else if(btnL && ~btnR && ~playerX[0])
				playerX <= {playerX[0], playerX[19:1]};
				
			if (((playerX & row13) && playerY[13]) != 0)
				begin
					playerX <= 20'b00000000001000000000;
					playerY <= 15'b100000000000000;
				end
			else if (((playerX & row12) && playerY[12]) != 0)
				begin
					playerX <= 20'b00000000001000000000;
					playerY <= 15'b100000000000000;
				end
			else if (((playerX & row11) && playerY[11]) != 0)
				begin
					playerX <= 20'b00000000001000000000;
					playerY <= 15'b100000000000000;
				end
			else if (((playerX & row10) && playerY[10]) != 0)
				begin
					playerX <= 20'b00000000001000000000;
					playerY <= 15'b100000000000000;
				end
			else if (((playerX & row9) && playerY[9]) != 0)
				begin
					playerX <= 20'b00000000001000000000;
					playerY <= 15'b100000000000000;
				end
			else if (((playerX & row8) && playerY[8]) != 0)
				begin
					playerX <= 20'b00000000001000000000;
					playerY <= 15'b100000000000000;
				end
			else if (((playerX & row6) && playerY[6]) != 0)
				begin
					playerX <= 20'b00000000001000000000;
					playerY <= 15'b100000000000000;
				end
			else if (((playerX & row5) && playerY[5]) != 0)
				begin
					playerX <= 20'b00000000001000000000;
					playerY <= 15'b100000000000000;
				end
			else if (((playerX & row4) && playerY[4]) != 0)
				begin
					playerX <= 20'b00000000001000000000;
					playerY <= 15'b100000000000000;
				end
			else if (((playerX & row3) && playerY[3]) != 0)
				begin
					playerX <= 20'b00000000001000000000;
					playerY <= 15'b100000000000000;
				end
			else if (((playerX & row2) && playerY[2]) != 0)
				begin
					playerX <= 20'b00000000001000000000;
					playerY <= 15'b100000000000000;
				end
			else if (((playerX & row1) && playerY[1]) != 0)
				begin
					playerX <= 20'b00000000001000000000;
					playerY <= 15'b100000000000000;
				end
			else if(win)
				begin
					win0 <= 20'b00000000000000000000;
					win1 <= 20'b01000100011100100010;
					win2 <= 20'b01000100100010010100;
					win3 <= 20'b01000101000001001000;
					win4 <= 20'b01000101000001001000;
					win5 <= 20'b01000100100010001000;
					win6 <= 20'b00111000011100001000;
					win7 <= 20'b00000000000000000000;
					win8 <= 20'b00000000000000000000;
					win9 <= 20'b01001011101000000010;
					win10 <= 20'b01011001001000100010;
					win11 <= 20'b01111001000100100100;
					win12 <= 20'b01101001000101010100;
					win13 <= 20'b01001011100010001000;
					win14 <= 20'b00000000000000000000;
				end
		end

	wire R = (CounterY[9:5]==1 && row1[CounterX[9:5]]) || (CounterY[9:5]==2 && row2[CounterX[9:5]]) ||
	(CounterY[9:5]==3 && row3[CounterX[9:5]]) || (CounterY[9:5]==4 && row4[CounterX[9:5]]) ||
	(CounterY[9:5]==5 && row5[CounterX[9:5]]) || (CounterY[9:5]==6 && row6[CounterX[9:5]]) ||
	(CounterY[9:5]==7 && row7[CounterX[9:5]]) || (CounterY[9:5]==8 && row8[CounterX[9:5]]) ||
	(CounterY[9:5]==9 && row9[CounterX[9:5]]) || (CounterY[9:5]==10 && row10[CounterX[9:5]]) ||
	(CounterY[9:5]==11 && row11[CounterX[9:5]]) || (CounterY[9:5]==12 && row12[CounterX[9:5]]) ||
	(CounterY[9:5]==13 && row13[CounterX[9:5]]);
	
	wire G = (playerX[CounterX[9:5]] && playerY[CounterY[9:5]]);
	
	wire B = (CounterY[9:5]==0 && win0[CounterX[9:5]]) || (CounterY[9:5]==14 && win14[CounterX[9:5]]) ||
	(CounterY[9:5]==1 && win1[CounterX[9:5]]) || (CounterY[9:5]==2 && win2[CounterX[9:5]]) ||
	(CounterY[9:5]==3 && win3[CounterX[9:5]]) || (CounterY[9:5]==4 && win4[CounterX[9:5]]) ||
	(CounterY[9:5]==5 && win5[CounterX[9:5]]) || (CounterY[9:5]==6 && win6[CounterX[9:5]]) ||
	(CounterY[9:5]==7 && win7[CounterX[9:5]]) || (CounterY[9:5]==8 && win8[CounterX[9:5]]) ||
	(CounterY[9:5]==9 && win9[CounterX[9:5]]) || (CounterY[9:5]==10 && win10[CounterX[9:5]]) ||
	(CounterY[9:5]==11 && win11[CounterX[9:5]]) || (CounterY[9:5]==12 && win12[CounterX[9:5]]) ||
	(CounterY[9:5]==13 && win13[CounterX[9:5]]);
	
	always @(posedge clk)
	begin
		vga_r <= R & inDisplayArea;
		vga_g <= G & inDisplayArea;
		vga_b <= B & inDisplayArea;
	end
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  VGA control ends here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  LD control starts here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	`define QI 			2'b00
	`define QGAME_1 	2'b01
	`define QGAME_2 	2'b10
	`define QDONE 		2'b11
	
	reg [3:0] p2_score;
	reg [3:0] p1_score;
	reg [1:0] state;
	wire LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
	
	assign LD0 = (p1_score == 4'b1010);
	assign LD1 = (p2_score == 4'b1010);
	
	assign LD2 = start;
	assign LD4 = reset;
	
	assign LD3 = (state == `QI);
	assign LD5 = (state == `QGAME_1);	
	assign LD6 = (state == `QGAME_2);
	assign LD7 = (state == `QDONE);
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  LD control ends here 	 	////////////////////
	/////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  SSD control starts here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	reg 	[3:0]	SSD;
	wire 	[3:0]	SSD0, SSD1, SSD2, SSD3;
	wire 	[1:0] ssdscan_clk;
	
	assign SSD3 = 4'b1111;
	assign SSD2 = 4'b1111;
	assign SSD1 = 4'b1111;
	assign SSD0 = 4'b1111;
	
	// need a scan clk for the seven segment display 
	// 191Hz (50MHz / 2^18) works well
	assign ssdscan_clk = DIV_CLK[19:18];	
	assign An0	= !(~(ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 00
	assign An1	= !(~(ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 01
	assign An2	= !( (ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 10
	assign An3	= !( (ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 11
	
	always @ (ssdscan_clk, SSD0, SSD1, SSD2, SSD3)
	begin : SSD_SCAN_OUT
		case (ssdscan_clk) 
			2'b00:
					SSD = SSD0;
			2'b01:
					SSD = SSD1;
			2'b10:
					SSD = SSD2;
			2'b11:
					SSD = SSD3;
		endcase 
	end	

	// and finally convert SSD_num to ssd
	reg [6:0]  SSD_CATHODES;
	assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp} = {SSD_CATHODES, 1'b1};
	// Following is Hex-to-SSD conversion
	always @ (SSD) 
	begin : HEX_TO_SSD
		case (SSD)		
			4'b1111: SSD_CATHODES = 7'b1111111 ; //Nothing 
			4'b0000: SSD_CATHODES = 7'b0000001 ; //0
			4'b0001: SSD_CATHODES = 7'b1001111 ; //1
			4'b0010: SSD_CATHODES = 7'b0010010 ; //2
			4'b0011: SSD_CATHODES = 7'b0000110 ; //3
			4'b0100: SSD_CATHODES = 7'b1001100 ; //4
			4'b0101: SSD_CATHODES = 7'b0100100 ; //5
			4'b0110: SSD_CATHODES = 7'b0100000 ; //6
			4'b0111: SSD_CATHODES = 7'b0001111 ; //7
			4'b1000: SSD_CATHODES = 7'b0000000 ; //8
			4'b1001: SSD_CATHODES = 7'b0000100 ; //9
			4'b1010: SSD_CATHODES = 7'b0001000 ; //10 or A
			default: SSD_CATHODES = 7'bXXXXXXX ; // default is not needed as we covered all cases
		endcase
	end
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  SSD control ends here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
endmodule
