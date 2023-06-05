/*
 * motor1_data.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "motor1".
 *
 * Model version              : 2.138
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C source code generated on : Mon May 29 13:58:28 2023
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "motor1.h"

/* Block parameters (default storage) */
P_motor1_T motor1_P = {
  /* Variable: sens
   * Referenced by:
   *   '<Root>/Gain1'
   *   '<Root>/Gain8'
   */
  {
    {
      0.5
    },

    {
      2000.0,
      0.18,
      0.0031415926535897933,
      5.5555555555555554,
      318.3098861837907
    },

    {
      {
        10000.0,
        5.0,
        345.0,
        6.0213859193804371
      },
      0.014492753623188406,
      0.83037361613162786,
      69.0,
      1.2042771838760873
    }
  },

  /* Variable: diff
   * Referenced by:
   *   '<Root>/Constant'
   *   '<Root>/Gain7'
   */
  {
    0.0031830988618379067,
    314.15926535897933,
    0.70710678118654746,
    10.0,
    0.001,
    2.0
  },

  /* Variable: dac
   * Referenced by: '<Root>/Saturation2'
   */
  {
    0.001,
    0.00030518043793392844,
    10.0
  },

  /* Variable: awu
   * Referenced by:
   *   '<Root>/Gain14'
   *   '<Root>/Gain15'
   */
  {
    0.048333333333333332,
    1.0
  },

  /* Variable: pid
   * Referenced by:
   *   '<Root>/Gain11'
   *   '<Root>/Gain13'
   */
  {
    0.0298,
    6.5015
  },

  /* Variable: degs2rpm
   * Referenced by: '<Root>/Gain9'
   */
  0.16666666666666666,

  /* Variable: rpm2rads
   * Referenced by: '<Root>/Gain12'
   */
  0.10471975511965977,

  /* Mask Parameter: AnalogOutput_FinalValue
   * Referenced by: '<Root>/Analog Output'
   */
  0.0,

  /* Mask Parameter: AnalogOutput_InitialValue
   * Referenced by: '<Root>/Analog Output'
   */
  0.0,

  /* Mask Parameter: EncoderInput_InputFilter
   * Referenced by: '<Root>/Encoder Input'
   */
  0.0,

  /* Mask Parameter: EncoderInput_MaxMissedTicks
   * Referenced by: '<Root>/Encoder Input'
   */
  10.0,

  /* Mask Parameter: AnalogInput_MaxMissedTicks
   * Referenced by: '<Root>/Analog Input'
   */
  10.0,

  /* Mask Parameter: AnalogOutput_MaxMissedTicks
   * Referenced by: '<Root>/Analog Output'
   */
  10.0,

  /* Mask Parameter: EncoderInput_YieldWhenWaiting
   * Referenced by: '<Root>/Encoder Input'
   */
  0.0,

  /* Mask Parameter: AnalogInput_YieldWhenWaiting
   * Referenced by: '<Root>/Analog Input'
   */
  0.0,

  /* Mask Parameter: AnalogOutput_YieldWhenWaiting
   * Referenced by: '<Root>/Analog Output'
   */
  0.0,

  /* Mask Parameter: EncoderInput_Channels
   * Referenced by: '<Root>/Encoder Input'
   */
  0,

  /* Mask Parameter: AnalogInput_Channels
   * Referenced by: '<Root>/Analog Input'
   */
  { 0, 1 },

  /* Mask Parameter: AnalogOutput_Channels
   * Referenced by: '<Root>/Analog Output'
   */
  0,

  /* Mask Parameter: AnalogInput_RangeMode
   * Referenced by: '<Root>/Analog Input'
   */
  0,

  /* Mask Parameter: AnalogOutput_RangeMode
   * Referenced by: '<Root>/Analog Output'
   */
  0,

  /* Mask Parameter: AnalogInput_VoltRange
   * Referenced by: '<Root>/Analog Input'
   */
  0,

  /* Mask Parameter: AnalogOutput_VoltRange
   * Referenced by: '<Root>/Analog Output'
   */
  0,

  /* Expression: step.T
   * Referenced by: '<Root>/Step'
   */
  1.0,

  /* Expression: 0
   * Referenced by: '<Root>/Step'
   */
  0.0,

  /* Expression: step.A
   * Referenced by: '<Root>/Step'
   */
  450.0,

  /* Computed Parameter: TransferFcn5_A
   * Referenced by: '<Root>/Transfer Fcn5'
   */
  -314.15926535897933,

  /* Computed Parameter: TransferFcn5_C
   * Referenced by: '<Root>/Transfer Fcn5'
   */
  -98696.044010893587,

  /* Computed Parameter: TransferFcn5_D
   * Referenced by: '<Root>/Transfer Fcn5'
   */
  314.15926535897933,

  /* Computed Parameter: TransferFcn4_A
   * Referenced by: '<Root>/Transfer Fcn4'
   */
  { -444.2882938158366, -98696.044010893587 },

  /* Computed Parameter: TransferFcn4_C
   * Referenced by: '<Root>/Transfer Fcn4'
   */
  { 98696.044010893587, 0.0 },

  /* Expression: 0.0
   * Referenced by: '<Root>/Delay'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/Integrator1'
   */
  0.0
};
