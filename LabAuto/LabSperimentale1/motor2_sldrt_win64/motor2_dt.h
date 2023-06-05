/*
 * motor2_dt.h
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "motor2".
 *
 * Model version              : 2.149
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C source code generated on : Mon May 29 14:14:01 2023
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "ext_types.h"

/* data type size table */
static uint_T rtDataTypeSizes[] = {
  sizeof(real_T),
  sizeof(real32_T),
  sizeof(int8_T),
  sizeof(uint8_T),
  sizeof(int16_T),
  sizeof(uint16_T),
  sizeof(int32_T),
  sizeof(uint32_T),
  sizeof(boolean_T),
  sizeof(fcn_call_T),
  sizeof(int_T),
  sizeof(pointer_T),
  sizeof(action_T),
  2*sizeof(uint32_T),
  sizeof(int32_T),
  sizeof(int64_T),
  sizeof(uint64_T),
  sizeof(struct_zh0Jahtydja9slL4vn0KNB),
  sizeof(struct_vHPMdAr9HfDgWNbG6U3SfC),
  sizeof(struct_nZqFUEOh71pPhzsMP64FWD),
  sizeof(struct_DqRrFctOcoTwJhkxMXTGZG),
  sizeof(struct_t4jfYKvXkqvqbOrnXV9flF),
  sizeof(struct_8LnTg2HasR61N4e63tMdJ),
  sizeof(struct_xYTLf9xRBpYnquzooZvpnD),
  sizeof(struct_vJJjEYOykwYuBPVflT2NUH),
  sizeof(struct_hqe83yBAMISEn9IXxbwOKF),
  sizeof(struct_tOQDypDRbFi5SWlJtRB3OB),
  sizeof(uint64_T),
  sizeof(int64_T),
  sizeof(uint_T),
  sizeof(char_T),
  sizeof(uchar_T),
  sizeof(time_T)
};

/* data type name table */
static const char_T * rtDataTypeNames[] = {
  "real_T",
  "real32_T",
  "int8_T",
  "uint8_T",
  "int16_T",
  "uint16_T",
  "int32_T",
  "uint32_T",
  "boolean_T",
  "fcn_call_T",
  "int_T",
  "pointer_T",
  "action_T",
  "timer_uint32_pair_T",
  "physical_connection",
  "int64_T",
  "uint64_T",
  "struct_zh0Jahtydja9slL4vn0KNB",
  "struct_vHPMdAr9HfDgWNbG6U3SfC",
  "struct_nZqFUEOh71pPhzsMP64FWD",
  "struct_DqRrFctOcoTwJhkxMXTGZG",
  "struct_t4jfYKvXkqvqbOrnXV9flF",
  "struct_8LnTg2HasR61N4e63tMdJ",
  "struct_xYTLf9xRBpYnquzooZvpnD",
  "struct_vJJjEYOykwYuBPVflT2NUH",
  "struct_hqe83yBAMISEn9IXxbwOKF",
  "struct_tOQDypDRbFi5SWlJtRB3OB",
  "uint64_T",
  "int64_T",
  "uint_T",
  "char_T",
  "uchar_T",
  "time_T"
};

/* data type transitions for block I/O structure */
static DataTypeTransition rtBTransitions[] = {
  { (char_T *)(&motor2_B.Out), 0, 0, 11 },

  { (char_T *)(&motor2_B.FixPtSwitch), 3, 0, 1 }
  ,

  { (char_T *)(&motor2_DW.Delay_DSTATE[0]), 0, 0, 10 },

  { (char_T *)(&motor2_DW.EncoderInput_PWORK), 11, 0, 11 },

  { (char_T *)(&motor2_DW.Output_DSTATE), 3, 0, 1 }
};

/* data type transition table for block I/O structure */
static DataTypeTransitionTable rtBTransTable = {
  5U,
  rtBTransitions
};

/* data type transitions for Parameters structure */
static DataTypeTransition rtPTransitions[] = {
  { (char_T *)(&motor2_P.sens), 22, 0, 1 },

  { (char_T *)(&motor2_P.ff), 25, 0, 1 },

  { (char_T *)(&motor2_P.diff), 17, 0, 1 },

  { (char_T *)(&motor2_P.dac), 26, 0, 1 },

  { (char_T *)(&motor2_P.awu), 24, 0, 1 },

  { (char_T *)(&motor2_P.pid), 23, 0, 1 },

  { (char_T *)(&motor2_P.degs2rpm), 0, 0, 17 },

  { (char_T *)(&motor2_P.EncoderInput_Channels), 6, 0, 8 },

  { (char_T *)(&motor2_P.LimitedCounter_uplimit), 3, 0, 1 },

  { (char_T *)(&motor2_P.Integrator2_IC), 0, 0, 13 },

  { (char_T *)(&motor2_P.Constant_Value), 3, 0, 3 }
};

/* data type transition table for Parameters structure */
static DataTypeTransitionTable rtPTransTable = {
  11U,
  rtPTransitions
};

/* [EOF] motor2_dt.h */
