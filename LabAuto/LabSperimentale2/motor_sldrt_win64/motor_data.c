/*
 * motor_data.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "motor".
 *
 * Model version              : 2.153
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C source code generated on : Mon May 22 12:36:51 2023
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "motor.h"

/* Block parameters (default storage) */
P_motor_T motor_P = {
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

  /* Variable: input
   * Referenced by: '<Root>/Constant1'
   */
  3.0,

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

  /* Mask Parameter: RepeatingSequenceStair_OutValues
   * Referenced by: '<S2>/Vector'
   */
  { 1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0 },

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

  /* Mask Parameter: RepeatingSequence_rep_seq_y
   * Referenced by: '<S1>/Look-Up Table1'
   */
  { 0.0, 1.0, 0.0 },

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

  /* Mask Parameter: LimitedCounter_uplimit
   * Referenced by: '<S5>/FixPt Switch'
   */
  9U,

  /* Expression: triang.A
   * Referenced by: '<Root>/Gain15'
   */
  450.0,

  /* Expression: step.A
   * Referenced by: '<Root>/Signal Generator'
   */
  -250.0,

  /* Expression: 1 / step.T
   * Referenced by: '<Root>/Signal Generator'
   */
  0.33333333333333331,

  /* Expression: stair.dw
   * Referenced by: '<Root>/Gain14'
   */
  50.0,

  /* Expression: period
   * Referenced by: '<S1>/Constant'
   */
  2.0,

  /* Expression: rep_seq_t - min(rep_seq_t)
   * Referenced by: '<S1>/Look-Up Table1'
   */
  { 0.0, 1.0, 2.0 },

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
  0.0,

  /* Computed Parameter: Constant_Value_a
   * Referenced by: '<S5>/Constant'
   */
  0U,

  /* Computed Parameter: Output_InitialCondition
   * Referenced by: '<S3>/Output'
   */
  0U,

  /* Computed Parameter: FixPtConstant_Value
   * Referenced by: '<S4>/FixPt Constant'
   */
  1U
};
