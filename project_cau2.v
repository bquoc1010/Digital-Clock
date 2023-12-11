//----------old code-----------------
//module CLK1HZ(CLOCK_50, CLK); 
//
//	input CLOCK_50;
//	output CLK;
//	reg CLK_1HZ = 0;
//	reg [24:0] counter = 0;
//
//	always @(posedge CLOCK_50)
//		begin
//			if(counter == 25000000)
//				begin
//					CLK_1HZ <= ~CLK_1HZ; //xung clock 1Hz
//					counter <= 0;
//				end
//			else counter <= counter + 1;
//		end
//	
//	assign CLK = CLK_1HZ;
//endmodule
//
//
//
//
//module Counter(CLOCK_50, CLOCK_1HZ, BUTTON, sec, min);
//input CLOCK_1HZ;
//input CLOCK_50;
//input [1:0] BUTTON;
//output [5:0] sec;      // seconds output
//output [5:0] min;      // minutes output
//	
//reg [1:0]timer_event = 2'b10;              //timer_event[1] = count, timer_event[0] = reset
//reg [1:0]state_button = 2'b00;              //state_button[1] = state count, state_button[0] = state reset
//
//reg [5:0] seconds_cnt;      // seconds counter from 0 to 59
//reg [5:0] minutes_cnt;     // minutes counter from 0 to 59
//
//			
//			always @(posedge CLOCK_50)
//				begin		
//					if(~BUTTON[1])  //nhan key[1]
//						begin
//							state_button[1] = 1'b1;
//						end
//						
//					if(BUTTON[1])  //khong nhan key[1]
//						begin
//							if (state_button[1] == 1'b1)
//								begin
//									timer_event[1] = ~timer_event[1];
//									state_button[1] = 1'b0;
//								end
//						end
//					if(BUTTON[0] == 1'b0) timer_event[0] = 1'b1;  //nhan key[0]
//					if(BUTTON[1] == 1'b0 && BUTTON[0] == 1'b1 && state_button[0] == 1'b1)  //xet dieu kien dao flag
//						begin
//							timer_event[0] = 1'b0;
//							timer_event[1] = 1'b1;
//						end
//				end
//	
//
//	always @(posedge CLOCK_1HZ)
//		begin
//			if(timer_event[0]) 
//				begin
//					minutes_cnt <= 6'd0;
//					seconds_cnt <= 6'd0;
//					state_button[0] <= 1'b1;
//				end
//			else if(~timer_event[1]) 
//				begin
//					state_button[0] <= 1'b0;
//					seconds_cnt <= seconds_cnt + 1'b1;
//					if (seconds_cnt == 6'd59)
//						begin
//							seconds_cnt <= 0;
//							if (minutes_cnt == 6'd59)
//								begin
//									minutes_cnt  <= 6'd0;	
//								end 
//							 else if(~timer_event[1]) 
//								 begin
//									minutes_cnt <= minutes_cnt + 1'b1;
//								 end
//						end
//		      end
//			
//			
//		end
//		assign sec = seconds_cnt;
//		assign min = minutes_cnt; 
//endmodule
//
//
//module Decoder (sec, min, HEX0, HEX1, HEX2, HEX3);
//input [5:0] sec;
//input [5:0] min;
//output [0:6] HEX0, HEX1, HEX2, HEX3;
//wire[3:0] donvi_sec,chuc_sec,donvi_min,chuc_min;
//
//assign donvi_sec = sec % 10;
//assign chuc_sec = sec / 10;
//assign donvi_min = min % 10;
//assign chuc_min = min / 10;
//
//assign HEX0 =  (donvi_sec == 6'b000000) ? 7'b0000001 :
//					(donvi_sec == 6'b000001) ? 7'b1001111 :
//					(donvi_sec == 6'b000010) ? 7'b0010010 :
//					(donvi_sec == 6'b000011) ? 7'b0000110 :
//					(donvi_sec == 6'b000100) ? 7'b1001100 :
//					(donvi_sec == 6'b000101) ? 7'b0100100 :
//					(donvi_sec == 6'b000110) ? 7'b0100000 :
//					(donvi_sec == 6'b000111) ? 7'b0001111 :
//					(donvi_sec == 6'b001000) ? 7'b0000000 :
//					(donvi_sec == 6'b001001) ? 7'b0000100 : 7'b1111111;
//assign HEX1 =  (chuc_sec == 6'b000000) ? 7'b0000001 :
//					(chuc_sec == 6'b000001) ? 7'b1001111 :
//					(chuc_sec == 6'b000010) ? 7'b0010010 : 
//					(chuc_sec == 6'b000011) ? 7'b0000110 :
//					(chuc_sec == 6'b000100) ? 7'b1001100 :
//					(chuc_sec == 6'b000101) ? 7'b0100100 : 7'b1111111;
//					
//assign HEX2 =  (donvi_min == 6'b000000) ? 7'b0000001 :
//					(donvi_min == 6'b000001) ? 7'b1001111 :
//					(donvi_min == 6'b000010) ? 7'b0010010 :
//					(donvi_min == 6'b000011) ? 7'b0000110 :
//					(donvi_min == 6'b000100) ? 7'b1001100 :
//					(donvi_min == 6'b000101) ? 7'b0100100 :
//					(donvi_min == 6'b000110) ? 7'b0100000 :
//					(donvi_min == 6'b000111) ? 7'b0001111 :
//					(donvi_min == 6'b001000) ? 7'b0000000 :
//					(donvi_min == 6'b001001) ? 7'b0000100 : 7'b1111111;
//assign HEX3 =  (chuc_min == 6'b000000) ? 7'b0000001 :
//					(chuc_min == 6'b000001) ? 7'b1001111 :
//					(chuc_min == 6'b000010) ? 7'b0010010 : 
//					(chuc_min == 6'b000011) ? 7'b0000110 :
//					(chuc_min == 6'b000100) ? 7'b1001100 :
//					(chuc_min == 6'b000101) ? 7'b0100100 : 7'b1111111;
//endmodule	
//		
//module project_cau2(input CLOCK_50, input [1:0]BUTTON, output [0:6]HEX0, HEX1, HEX2, HEX3);
//	
//	wire [5:0]sec;
//	wire [5:0]min;
//	wire CLK;
//	
//	CLK1HZ(.CLOCK_50(CLOCK_50), .CLK(CLK));
//	Counter U1(.CLOCK_50(CLOCK_50), .CLOCK_1HZ(CLK), .BUTTON(BUTTON), .sec(sec), .min(min));
//	Decoder U2(.sec(sec), .min(min), .HEX0(HEX0), .HEX1(HEX1), .HEX2(HEX2), .HEX3(HEX3));
//	
//			
//endmodule
// ----------- old code-------------

//------------new code-----------------

module CLK1HZ(CLOCK_50, CLK); 

	input CLOCK_50;
	output CLK;
	reg CLK_1HZ = 0;
	reg [25:0] counter = 0;

	always @(posedge CLOCK_50)
		begin
			if(counter == 25000000)
				begin
					CLK_1HZ <= ~CLK_1HZ; //xung clock 1Hz
					counter <= 0;
				end
			else counter <= counter + 1;
		end
	
	assign CLK = CLK_1HZ;
endmodule




module Counter(CLOCK_50, CLOCK_1HZ, BUTTON, sec, min);
input CLOCK_1HZ;
input CLOCK_50;
input [1:0] BUTTON;
output [5:0] sec;      // seconds output
output [5:0] min;      // minutes output
	
reg [1:0]timer_event;    //timer_event[1] = count, timer_event[0] = reset          
reg [1:0]state_button;   //state_button[1] = state count, state_button[0] = state reset

reg [5:0] sec_cnt;      // seconds counter from 0 to 59
reg [5:0] min_cnt;     // minutes counter from 0 to 59

			
			always @(posedge CLOCK_50)
				begin		
					if(~BUTTON[1])  //nhan key[1]
						begin
							state_button[1] <= 1'b1;
						end
						
					if(BUTTON[1])  //khong nhan key[1]
						begin
							if (state_button[1] == 1'b1)
								begin
									timer_event[1] <= ~timer_event[1];
									state_button[1] <= 1'b0;
								end
						end
					if(BUTTON[0] == 1'b0) timer_event[0] <= 1'b1;  //nhan key[0]
					if(BUTTON[1] == 1'b0 && BUTTON[0] == 1'b1 && state_button[0] == 1'b1)  //xet dieu kien dao flag
						begin
							timer_event[0] <= 1'b0;
							timer_event[1] <= 1'b1;
						end
				end
	

	always @(posedge CLOCK_1HZ)
		begin
			if(timer_event[0]) 
				begin
					min_cnt <= 6'd0;
					sec_cnt <= 6'd0;
					state_button[0] <= 1'b1;
				end
			else if(~timer_event[1]) 
				begin
					state_button[0] <= 1'b0;
					sec_cnt <= sec_cnt + 1'b1;
					if (sec_cnt == 6'd59)
						begin
							sec_cnt <= 0;
							if (min_cnt == 6'd59)
								begin
									min_cnt  <= 6'd0;	
								end 
							 else if(~timer_event[1]) 
								 begin
									min_cnt <= min_cnt + 1'b1;
								 end
						end
		      end
			
			
		end
		assign sec = sec_cnt;
		assign min = min_cnt; 
endmodule


module Decoder (Result, LED_donvi, LED_chuc);
input [5:0] Result;
output [0:6] LED_donvi, LED_chuc;
wire[3:0] donvi,chuc;

assign donvi = Result % 10;
assign chuc = Result / 10;


assign LED_donvi =  (donvi == 4'b0000) ? 7'b0000001 :
							(donvi == 4'b0001) ? 7'b1001111 :
							(donvi == 4'b0010) ? 7'b0010010 :
							(donvi == 4'b0011) ? 7'b0000110 :
							(donvi == 4'b0100) ? 7'b1001100 :
							(donvi == 4'b0101) ? 7'b0100100 :
							(donvi == 4'b0110) ? 7'b0100000 :
							(donvi == 4'b0111) ? 7'b0001111 :
							(donvi == 4'b1000) ? 7'b0000000 :
							(donvi == 4'b1001) ? 7'b0000100 : 7'b1111111;
assign LED_chuc =  (chuc == 4'b0000) ? 7'b0000001 :
							(chuc == 4'b0001) ? 7'b1001111 :
							(chuc == 4'b0010) ? 7'b0010010 : 
							(chuc == 4'b0011) ? 7'b0000110 :
							(chuc == 4'b0100) ? 7'b1001100 :
							(chuc == 4'b0101) ? 7'b0100100 : 7'b1111111;
							
endmodule	
		
module project_cau2(input CLOCK_50, input [1:0]BUTTON, output [0:6]HEX0, HEX1, HEX2, HEX3);
	
	wire [5:0]sec;
	wire [5:0]min;
	wire CLK;
	
	CLK1HZ Clock_1Hz(.CLOCK_50(CLOCK_50), .CLK(CLK));
	Counter SecMinCounter(.CLOCK_50(CLOCK_50), .CLOCK_1HZ(CLK), .BUTTON(BUTTON), .sec(sec), .min(min));
	Decoder Seconds(.Result(sec), .LED_donvi(HEX0), .LED_chuc(HEX1));
	Decoder Minutes(.Result(min), .LED_donvi(HEX2), .LED_chuc(HEX3));
	
			
endmodule


//-------------new code----------------