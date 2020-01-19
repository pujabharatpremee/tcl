/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/

/*
 * helloworld.c: simple test application
 *
 * This application configures UART 16550 to baud rate 9600.
 * PS7 UART (Zynq) is not initialized by this application, since
 * bootrom/bsp configures it to baud rate 115200
 *
 * ------------------------------------------------
 * | UART TYPE   BAUD RATE                        |
 * ------------------------------------------------
 *   uartns550   9600
 *   uartlite    Configurable only in HW design
 *   ps7_uart    115200 (configured by bootrom/bsp)
 */

#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xpolar.h"
#include <unistd.h>
#include "xparameters.h"

/* u32 USER_DEFINED_BA_TABLE[64] ={ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1,
				                  0, 0, 0, 0, 0, 0, 2, 1, 0, 0, 0, 1, 2, 1, 1, 1,
                                  0, 0, 0, 0, 0, 0, 2, 1, 0, 2, 2, 1, 2, 1, 1, 1,
			                      0, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}; */

 /*u32 USER_DEFINED_BA_TABLE[128] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		 	   // 	    0  1  2  3  4  5  6  7  8  9  10 11 12 13 14 15
		                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2,
			   //   	16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
									0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 2, 2,
								//  32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
									0, 0, 0, 2, 0, 2, 2, 2, 0, 2, 2, 2, 2, 1, 1, 1,
							    //  48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
									0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 2, 0, 2, 2, 2,
								//  64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79
									0, 0, 0, 2, 0, 2, 2, 2, 2, 2, 2, 1, 2, 1, 1, 1,
								//  80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95
									0, 0, 2, 2, 2, 2, 2, 1, 2, 2, 2, 1, 2, 1, 1, 1,
								//  96 97 98 99 00 01 02 03 04 05 06 07 08 09 10 11
									2, 2, 2, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, };
                                //  12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27
*/

u32 USER_DEFINED_BA_TABLE[1024] = {
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //32

0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //64
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //96
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //128
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //160
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //192
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //224
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //256
																							//1
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //288
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //320
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //352
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //384
																							//2
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //416
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //448
																						//3  //4
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //480
																				//5   //6 //7 //8
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,  //512
                    //9          10    11 12 13          14    15 16 17 18 19 20 21 22 23 24 25
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //544
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //576
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //608
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //640
                                                                                     //26 27 28
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //672
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //704
																	//29         30    31 32 33
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //736
											//34                    35           36 37 38 39 40
0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //768
				//   41   p1  42 43 44 45 46 47   48 49 50 51 52 53 54 55 56 57  58 59 60 61 62
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, //800
																							//63
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, //832
										// 64                       65        p2 66 67 68 69 70
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 2, 0, 2, 2, 2, 2, 2, 2, 2, //864
										//   71                72 72 73    74 75 76 77 78 79 80
0, 0, 0, 2, 0, 2, 2, 2, 0, 2, 2, 2, 2, 2, 2, 2, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, //896
//      81     82 83 84    85 86 87 88 89 90 91   92 93 94 95 96 97 98 99 100 01 02 03 04 05 06
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 2, 0, 2, 2, 2, 0, 0, 0, 2, 0, 2, 2, 2, 0, 2, 2, 2, 2, 2, 2, 2, //928
//								07     8 9   10          11    12 13 14    15 16 17 18 19 20 21
0, 0, 0, 2, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, //960
//      22     23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49
0, 0, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, //992
//    50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79
3, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1  //1024
// 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 1  2  3  4  5  6  7  8  9  10 11
  };
int main()
{
    init_platform();

    xpolar_polar_parameters polar_params;
    polar_params.N = 1024;
    polar_params.K =  128;
    polar_params.AUGMENT = AUGMENT_CRC;
    polar_params.CRC_SEL = CRC_SEL_11;
    polar_params.ITLV = 0;
    polar_params.CRC_INIT = 0;

    // Segment the BA table in preparation for writing to AXI-lite
    u32 compressed_length = polar_params.N/16;
    u32 compressed_BA_TABLE[compressed_length];
    xpolar_compress_bit_allocation_table(USER_DEFINED_BA_TABLE, compressed_BA_TABLE,compressed_length);
    for (int i = 0; i < compressed_length; i++)
    {
    polar_params.BA_TABLE[i] = compressed_BA_TABLE[i];
    }
    // Polar Encoder/Decoder instance and cfg
    //xpolar_Config* polar_cfg;
    xpolar enc;
    xpolar dec;
    //int status;

    xpolar_Initialize(&enc,XPAR_ENC_DEVICE_ID);
    xpolar_Initialize(&dec,XPAR_DEC_DEVICE_ID);

    // Setup Polar Encoder/Decoder
      // AXI_WIDTH
      // o DIN_WORDS applies once per codeword
      // o DOUT_WORDS applies once per codeword
      xpolar_set_CORE_AXIS_WIDTH(&enc, 0x00000000);
      xpolar_set_CORE_AXIS_WIDTH(&dec, 0x00000000);

      // Interrupt Enable Register
      // o Enables all (DIN, DIN_WORDS and DOUT_WORDS) tlast missing and unexpected interrupts
      xpolar_set_CORE_IER(&enc, 0x0000007F);
      xpolar_set_CORE_IER(&dec, 0x0000007F);

      // ECC Interrupt Enable Register
      // o Enables all ECC interrupts
      xpolar_set_CORE_ECC_IER(&enc, 0x00000FFF);
      xpolar_set_CORE_ECC_IER(&dec, 0x00000FFF);

      xpolar_add_polar_params(&enc, &polar_params);
      xpolar_add_polar_params(&dec, &polar_params);

      // Enable FECs
      // o Enable all channesls
      xpolar_set_CORE_AXIS_ENABLE(&enc,63);
      xpolar_set_CORE_AXIS_ENABLE(&dec,63);
    cleanup_platform();
    return 0;
}
