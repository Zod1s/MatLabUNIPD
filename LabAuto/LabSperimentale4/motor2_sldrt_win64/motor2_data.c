/*
 * motor2_data.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "motor2".
 *
 * Model version              : 2.164
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C source code generated on : Mon Jun  5 14:10:55 2023
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "motor2.h"

/* Block parameters (default storage) */
P_motor2_T motor2_P = {
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

  /* Variable: dac
   * Referenced by: '<Root>/Saturation2'
   */
  {
    0.001,
    0.00030518043793392844,
    10.0
  },

  /* Variable: step
   * Referenced by: '<Root>/Step'
   */
  {
    250.0,
    1.0
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
    0.232,
    8.0
  },

  /* Variable: degs2rpm
   * Referenced by: '<Root>/Gain9'
   */
  0.16666666666666666,

  /* Variable: dend
   * Referenced by: '<Root>/Discrete Transfer Fcn'
   */
  { 1.0, 1.1584799000428243, 0.41970460582576558 },

  /* Variable: numd
   * Referenced by: '<Root>/Discrete Transfer Fcn'
   */
  { 64.454612646714736, 0.0, -64.454612646714736 },

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

  /* Expression: 0
   * Referenced by: '<Root>/Step'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/Discrete Transfer Fcn'
   */
  0.0,

  /* Computed Parameter: DiscreteTimeIntegrator_gainval
   * Referenced by: '<Root>/Discrete-Time Integrator'
   */
  0.02,

  /* Expression: 0
   * Referenced by: '<Root>/Discrete-Time Integrator'
   */
  0.0,

  /* Expression: 0
   * Referenced by: '<Root>/Unit Delay'
   */
  0.0
};
