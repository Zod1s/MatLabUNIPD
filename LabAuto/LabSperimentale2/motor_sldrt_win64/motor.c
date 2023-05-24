/*
 * motor.c
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
#include "rtwtypes.h"
#include "motor_private.h"
#include <math.h>
#include "rt_nonfinite.h"
#include <float.h>
#include <string.h>
#include "motor_dt.h"

/* options for Simulink Desktop Real-Time board 0 */
static double SLDRTBoardOptions0[] = {
  0.0,
  0.0,
  0.0,
  2.0,
  0.0,
  0.0,
  0.0,
};

/* list of Simulink Desktop Real-Time timers */
const int SLDRTTimerCount = 1;
const double SLDRTTimers[2] = {
  0.001, 0.0,
};

/* list of Simulink Desktop Real-Time boards */
const int SLDRTBoardCount = 1;
SLDRTBOARD SLDRTBoards[1] = {
  { "National_Instruments/PCIe-6321", 4294967295U, 7, SLDRTBoardOptions0 },
};

/* Block signals (default storage) */
B_motor_T motor_B;

/* Continuous states */
X_motor_T motor_X;

/* Block states (default storage) */
DW_motor_T motor_DW;

/* Real-time model */
static RT_MODEL_motor_T motor_M_;
RT_MODEL_motor_T *const motor_M = &motor_M_;
static void rate_scheduler(void);
real_T look1_binlxpw(real_T u0, const real_T bp0[], const real_T table[],
                     uint32_T maxIndex)
{
  real_T frac;
  real_T yL_0d0;
  uint32_T iLeft;

  /* Column-major Lookup 1-D
     Search method: 'binary'
     Use previous index: 'off'
     Interpolation method: 'Linear point-slope'
     Extrapolation method: 'Linear'
     Use last breakpoint for index at or above upper limit: 'off'
     Remove protection against out-of-range input in generated code: 'off'
   */
  /* Prelookup - Index and Fraction
     Index Search method: 'binary'
     Extrapolation method: 'Linear'
     Use previous index: 'off'
     Use last breakpoint for index at or above upper limit: 'off'
     Remove protection against out-of-range input in generated code: 'off'
   */
  if (u0 <= bp0[0U]) {
    iLeft = 0U;
    frac = (u0 - bp0[0U]) / (bp0[1U] - bp0[0U]);
  } else if (u0 < bp0[maxIndex]) {
    uint32_T bpIdx;
    uint32_T iRght;

    /* Binary Search */
    bpIdx = maxIndex >> 1U;
    iLeft = 0U;
    iRght = maxIndex;
    while (iRght - iLeft > 1U) {
      if (u0 < bp0[bpIdx]) {
        iRght = bpIdx;
      } else {
        iLeft = bpIdx;
      }

      bpIdx = (iRght + iLeft) >> 1U;
    }

    frac = (u0 - bp0[iLeft]) / (bp0[iLeft + 1U] - bp0[iLeft]);
  } else {
    iLeft = maxIndex - 1U;
    frac = (u0 - bp0[maxIndex - 1U]) / (bp0[maxIndex] - bp0[maxIndex - 1U]);
  }

  /* Column-major Interpolation 1-D
     Interpolation method: 'Linear point-slope'
     Use last breakpoint for index at or above upper limit: 'off'
     Overflow mode: 'portable wrapping'
   */
  yL_0d0 = table[iLeft];
  return (table[iLeft + 1U] - yL_0d0) * frac + yL_0d0;
}

/*
 *         This function updates active task flag for each subrate.
 *         The function is called at model base rate, hence the
 *         generated code self-manages all its subrates.
 */
static void rate_scheduler(void)
{
  /* Compute which subrates run during the next base time step.  Subrates
   * are an integer multiple of the base rate counter.  Therefore, the subtask
   * counter is reset when it reaches its limit (zero means run).
   */
  (motor_M->Timing.TaskCounters.TID[2])++;
  if ((motor_M->Timing.TaskCounters.TID[2]) > 4999) {/* Sample time: [5.0s, 0.0s] */
    motor_M->Timing.TaskCounters.TID[2] = 0;
  }

  motor_M->Timing.sampleHits[2] = (motor_M->Timing.TaskCounters.TID[2] == 0) ? 1
    : 0;
}

/*
 * This function updates continuous states using the ODE3 fixed-step
 * solver algorithm
 */
static void rt_ertODEUpdateContinuousStates(RTWSolverInfo *si )
{
  /* Solver Matrices */
  static const real_T rt_ODE3_A[3] = {
    1.0/2.0, 3.0/4.0, 1.0
  };

  static const real_T rt_ODE3_B[3][3] = {
    { 1.0/2.0, 0.0, 0.0 },

    { 0.0, 3.0/4.0, 0.0 },

    { 2.0/9.0, 1.0/3.0, 4.0/9.0 }
  };

  time_T t = rtsiGetT(si);
  time_T tnew = rtsiGetSolverStopTime(si);
  time_T h = rtsiGetStepSize(si);
  real_T *x = rtsiGetContStates(si);
  ODE3_IntgData *id = (ODE3_IntgData *)rtsiGetSolverData(si);
  real_T *y = id->y;
  real_T *f0 = id->f[0];
  real_T *f1 = id->f[1];
  real_T *f2 = id->f[2];
  real_T hB[3];
  int_T i;
  int_T nXc = 4;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  motor_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE3_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[0]);
  rtsiSetdX(si, f1);
  motor_output();
  motor_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE3_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[1]);
  rtsiSetdX(si, f2);
  motor_output();
  motor_derivatives();

  /* tnew = t + hA(3);
     ynew = y + f*hB(:,3); */
  for (i = 0; i <= 2; i++) {
    hB[i] = h * rt_ODE3_B[2][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1] + f2[i]*hB[2]);
  }

  rtsiSetT(si, tnew);
  rtsiSetSimTimeStep(si,MAJOR_TIME_STEP);
}

real_T rt_remd_snf(real_T u0, real_T u1)
{
  real_T y;
  if (rtIsNaN(u0) || rtIsNaN(u1) || rtIsInf(u0)) {
    y = (rtNaN);
  } else if (rtIsInf(u1)) {
    y = u0;
  } else if ((u1 != 0.0) && (u1 != trunc(u1))) {
    real_T q;
    q = fabs(u0 / u1);
    if (!(fabs(q - floor(q + 0.5)) > DBL_EPSILON * q)) {
      y = 0.0 * u0;
    } else {
      y = fmod(u0, u1);
    }
  } else {
    y = fmod(u0, u1);
  }

  return y;
}

/* Model output function */
void motor_output(void)
{
  real_T rtb_AnalogInput[2];
  real_T rtb_Gain12;
  real_T temp;
  uint8_T rtb_Output_e;
  if (rtmIsMajorTimeStep(motor_M)) {
    /* set solver stop time */
    if (!(motor_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&motor_M->solverInfo, ((motor_M->Timing.clockTickH0
        + 1) * motor_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&motor_M->solverInfo, ((motor_M->Timing.clockTick0 +
        1) * motor_M->Timing.stepSize0 + motor_M->Timing.clockTickH0 *
        motor_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(motor_M)) {
    motor_M->Timing.t[0] = rtsiGetT(&motor_M->solverInfo);
  }

  /* SignalGenerator: '<Root>/Signal Generator' incorporates:
   *  Clock: '<S1>/Clock'
   */
  rtb_Gain12 = motor_M->Timing.t[0];
  temp = motor_P.SignalGenerator_Frequency * rtb_Gain12;
  if (rtmIsMajorTimeStep(motor_M) &&
      motor_M->Timing.TaskCounters.TID[2] == 0) {
    /* UnitDelay: '<S3>/Output' */
    rtb_Output_e = motor_DW.Output_DSTATE;

    /* Gain: '<Root>/Gain14' incorporates:
     *  Constant: '<S2>/Vector'
     *  MultiPortSwitch: '<S2>/Output'
     *  UnitDelay: '<S3>/Output'
     */
    motor_B.Gain14 = motor_P.Gain14_Gain *
      motor_P.RepeatingSequenceStair_OutValues[motor_DW.Output_DSTATE];
  }

  /* Math: '<S1>/Math Function' incorporates:
   *  Constant: '<S1>/Constant'
   *  S-Function (sfun_tstart): '<S1>/startTime'
   *  Sum: '<S1>/Sum'
   */
  rtb_Gain12 = rt_remd_snf(rtb_Gain12 - (0.0), motor_P.Constant_Value);

  /* MultiPortSwitch: '<Root>/Multiport Switch1' incorporates:
   *  Constant: '<Root>/Constant1'
   */
  switch ((int32_T)motor_P.input) {
   case 1:
    /* SignalGenerator: '<Root>/Signal Generator' */
    if (temp - floor(temp) >= 0.5) {
      /* MultiPortSwitch: '<Root>/Multiport Switch1' incorporates:
       *  SignalGenerator: '<Root>/Signal Generator'
       */
      motor_B.MultiportSwitch1 = motor_P.SignalGenerator_Amplitude;
    } else {
      /* MultiPortSwitch: '<Root>/Multiport Switch1' incorporates:
       *  SignalGenerator: '<Root>/Signal Generator'
       */
      motor_B.MultiportSwitch1 = -motor_P.SignalGenerator_Amplitude;
    }
    break;

   case 2:
    /* MultiPortSwitch: '<Root>/Multiport Switch1' */
    motor_B.MultiportSwitch1 = motor_B.Gain14;
    break;

   default:
    /* MultiPortSwitch: '<Root>/Multiport Switch1' incorporates:
     *  Gain: '<Root>/Gain12'
     *  Gain: '<Root>/Gain15'
     *  Lookup_n-D: '<S1>/Look-Up Table1'
     */
    motor_B.MultiportSwitch1 = motor_P.Gain15_Gain * look1_binlxpw(rtb_Gain12,
      motor_P.LookUpTable1_bp01Data, motor_P.RepeatingSequence_rep_seq_y, 2U);
    break;
  }

  /* End of MultiPortSwitch: '<Root>/Multiport Switch1' */

  /* S-Function (sldrtei): '<Root>/Encoder Input' */
  /* S-Function Block: <Root>/Encoder Input */
  {
    ENCODERINPARM parm;
    parm.quad = (QUADMODE) 2;
    parm.index = (INDEXPULSE) 0;
    parm.infilter = motor_P.EncoderInput_InputFilter;
    RTBIO_DriverIO(0, ENCODERINPUT, IOREAD, 1, &motor_P.EncoderInput_Channels,
                   &rtb_Gain12, &parm);
  }

  if (rtmIsMajorTimeStep(motor_M) &&
      motor_M->Timing.TaskCounters.TID[1] == 0) {
    /* S-Function (sldrtai): '<Root>/Analog Input' */
    /* S-Function Block: <Root>/Analog Input */
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor_P.AnalogInput_RangeMode;
      parm.rangeidx = motor_P.AnalogInput_VoltRange;
      RTBIO_DriverIO(0, ANALOGINPUT, IOREAD, 2, motor_P.AnalogInput_Channels,
                     &rtb_AnalogInput[0], &parm);
    }

    /* Delay: '<Root>/Delay' */
    motor_B.Delay = motor_DW.Delay_DSTATE[0];
  }

  /* Gain: '<Root>/Gain8' */
  motor_B.Gain8 = motor_P.sens.enc.pulse2deg * rtb_Gain12;

  /* MultiPortSwitch: '<Root>/Multiport Switch' incorporates:
   *  Constant: '<Root>/Constant'
   *  Gain: '<Root>/Gain7'
   *  Sum: '<Root>/Sum2'
   *  TransferFcn: '<Root>/Transfer Fcn4'
   *  TransferFcn: '<Root>/Transfer Fcn5'
   */
  switch ((int32_T)motor_P.diff.type) {
   case 1:
    rtb_Gain12 = motor_P.TransferFcn5_C * motor_X.TransferFcn5_CSTATE +
      motor_P.TransferFcn5_D * motor_B.Gain8;
    break;

   case 2:
    rtb_Gain12 = motor_P.TransferFcn4_C[0] * motor_X.TransferFcn4_CSTATE[0] +
      motor_P.TransferFcn4_C[1] * motor_X.TransferFcn4_CSTATE[1];
    break;

   default:
    rtb_Gain12 = 1.0 / (motor_P.diff.Ts * motor_P.diff.N) * (motor_B.Gain8 -
      motor_B.Delay);
    break;
  }

  /* End of MultiPortSwitch: '<Root>/Multiport Switch' */

  /* Gain: '<Root>/Gain9' */
  motor_B.Gain9 = motor_P.degs2rpm * rtb_Gain12;

  /* Sum: '<Root>/Sum3' */
  motor_B.Sum3 = motor_B.MultiportSwitch1 - motor_B.Gain9;

  /* Gain: '<Root>/Gain12' */
  rtb_Gain12 = motor_P.rpm2rads * motor_B.Sum3;

  /* Sum: '<Root>/Sum4' incorporates:
   *  Gain: '<Root>/Gain11'
   *  Integrator: '<Root>/Integrator1'
   */
  motor_B.Sum4 = motor_P.pid.Kp * rtb_Gain12 + motor_X.Integrator1_CSTATE;

  /* S-Function (sldrtao): '<Root>/Analog Output' */
  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1, &motor_P.AnalogOutput_Channels,
                     ((real_T*) (&motor_B.Sum4)), &parm);
    }
  }

  if (rtmIsMajorTimeStep(motor_M) &&
      motor_M->Timing.TaskCounters.TID[1] == 0) {
    /* Gain: '<Root>/Gain1' incorporates:
     *  Sum: '<Root>/Add'
     */
    motor_B.Gain1 = 1.0 / motor_P.sens.curr.Rs * (rtb_AnalogInput[0] -
      rtb_AnalogInput[1]);
  }

  /* Gain: '<Root>/Gain13' */
  motor_B.Gain13 = motor_P.pid.Ki * rtb_Gain12;
  if (rtmIsMajorTimeStep(motor_M) &&
      motor_M->Timing.TaskCounters.TID[2] == 0) {
    /* Sum: '<S4>/FixPt Sum1' incorporates:
     *  Constant: '<S4>/FixPt Constant'
     */
    rtb_Output_e += motor_P.FixPtConstant_Value;

    /* Switch: '<S5>/FixPt Switch' */
    if (rtb_Output_e > motor_P.LimitedCounter_uplimit) {
      /* Switch: '<S5>/FixPt Switch' incorporates:
       *  Constant: '<S5>/Constant'
       */
      motor_B.FixPtSwitch = motor_P.Constant_Value_a;
    } else {
      /* Switch: '<S5>/FixPt Switch' */
      motor_B.FixPtSwitch = rtb_Output_e;
    }

    /* End of Switch: '<S5>/FixPt Switch' */
  }
}

/* Model update function */
void motor_update(void)
{
  int_T idxDelay;
  if (rtmIsMajorTimeStep(motor_M) &&
      motor_M->Timing.TaskCounters.TID[2] == 0) {
    /* Update for UnitDelay: '<S3>/Output' */
    motor_DW.Output_DSTATE = motor_B.FixPtSwitch;
  }

  if (rtmIsMajorTimeStep(motor_M) &&
      motor_M->Timing.TaskCounters.TID[1] == 0) {
    /* Update for Delay: '<Root>/Delay' */
    for (idxDelay = 0; idxDelay < 9; idxDelay++) {
      motor_DW.Delay_DSTATE[idxDelay] = motor_DW.Delay_DSTATE[idxDelay + 1];
    }

    motor_DW.Delay_DSTATE[9] = motor_B.Gain8;

    /* End of Update for Delay: '<Root>/Delay' */
  }

  if (rtmIsMajorTimeStep(motor_M)) {
    rt_ertODEUpdateContinuousStates(&motor_M->solverInfo);
  }

  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++motor_M->Timing.clockTick0)) {
    ++motor_M->Timing.clockTickH0;
  }

  motor_M->Timing.t[0] = rtsiGetSolverStopTime(&motor_M->solverInfo);

  {
    /* Update absolute timer for sample time: [0.001s, 0.0s] */
    /* The "clockTick1" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick1"
     * and "Timing.stepSize1". Size of "clockTick1" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick1 and the high bits
     * Timing.clockTickH1. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++motor_M->Timing.clockTick1)) {
      ++motor_M->Timing.clockTickH1;
    }

    motor_M->Timing.t[1] = motor_M->Timing.clockTick1 *
      motor_M->Timing.stepSize1 + motor_M->Timing.clockTickH1 *
      motor_M->Timing.stepSize1 * 4294967296.0;
  }

  if (rtmIsMajorTimeStep(motor_M) &&
      motor_M->Timing.TaskCounters.TID[2] == 0) {
    /* Update absolute timer for sample time: [5.0s, 0.0s] */
    /* The "clockTick2" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick2"
     * and "Timing.stepSize2". Size of "clockTick2" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick2 and the high bits
     * Timing.clockTickH2. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++motor_M->Timing.clockTick2)) {
      ++motor_M->Timing.clockTickH2;
    }

    motor_M->Timing.t[2] = motor_M->Timing.clockTick2 *
      motor_M->Timing.stepSize2 + motor_M->Timing.clockTickH2 *
      motor_M->Timing.stepSize2 * 4294967296.0;
  }

  rate_scheduler();
}

/* Derivatives for root system: '<Root>' */
void motor_derivatives(void)
{
  XDot_motor_T *_rtXdot;
  _rtXdot = ((XDot_motor_T *) motor_M->derivs);

  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn5' */
  _rtXdot->TransferFcn5_CSTATE = motor_P.TransferFcn5_A *
    motor_X.TransferFcn5_CSTATE;
  _rtXdot->TransferFcn5_CSTATE += motor_B.Gain8;

  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn4' */
  _rtXdot->TransferFcn4_CSTATE[0] = motor_P.TransferFcn4_A[0] *
    motor_X.TransferFcn4_CSTATE[0];
  _rtXdot->TransferFcn4_CSTATE[0] += motor_P.TransferFcn4_A[1] *
    motor_X.TransferFcn4_CSTATE[1];
  _rtXdot->TransferFcn4_CSTATE[1] = motor_X.TransferFcn4_CSTATE[0];
  _rtXdot->TransferFcn4_CSTATE[0] += motor_B.Gain8;

  /* Derivatives for Integrator: '<Root>/Integrator1' */
  _rtXdot->Integrator1_CSTATE = motor_B.Gain13;
}

/* Model initialize function */
void motor_initialize(void)
{
  /* Start for S-Function (sldrtao): '<Root>/Analog Output' */

  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1, &motor_P.AnalogOutput_Channels,
                     &motor_P.AnalogOutput_InitialValue, &parm);
    }
  }

  {
    int32_T i;

    /* InitializeConditions for UnitDelay: '<S3>/Output' */
    motor_DW.Output_DSTATE = motor_P.Output_InitialCondition;

    /* InitializeConditions for S-Function (sldrtei): '<Root>/Encoder Input' */

    /* S-Function Block: <Root>/Encoder Input */
    {
      ENCODERINPARM parm;
      parm.quad = (QUADMODE) 2;
      parm.index = (INDEXPULSE) 0;
      parm.infilter = motor_P.EncoderInput_InputFilter;
      RTBIO_DriverIO(0, ENCODERINPUT, IORESET, 1, &motor_P.EncoderInput_Channels,
                     NULL, &parm);
    }

    /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn5' */
    motor_X.TransferFcn5_CSTATE = 0.0;

    /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn4' */
    motor_X.TransferFcn4_CSTATE[0] = 0.0;
    motor_X.TransferFcn4_CSTATE[1] = 0.0;

    /* InitializeConditions for Delay: '<Root>/Delay' */
    for (i = 0; i < 10; i++) {
      motor_DW.Delay_DSTATE[i] = motor_P.Delay_InitialCondition;
    }

    /* End of InitializeConditions for Delay: '<Root>/Delay' */

    /* InitializeConditions for Integrator: '<Root>/Integrator1' */
    motor_X.Integrator1_CSTATE = motor_P.Integrator1_IC;
  }
}

/* Model terminate function */
void motor_terminate(void)
{
  /* Terminate for S-Function (sldrtao): '<Root>/Analog Output' */

  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1, &motor_P.AnalogOutput_Channels,
                     &motor_P.AnalogOutput_FinalValue, &parm);
    }
  }
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/

/* Solver interface called by GRT_Main */
#ifndef USE_GENERATED_SOLVER

void rt_ODECreateIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEDestroyIntegrationData(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

void rt_ODEUpdateContinuousStates(RTWSolverInfo *si)
{
  UNUSED_PARAMETER(si);
  return;
}                                      /* do nothing */

#endif

void MdlOutputs(int_T tid)
{
  motor_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  motor_update();
  UNUSED_PARAMETER(tid);
}

void MdlInitializeSizes(void)
{
}

void MdlInitializeSampleTimes(void)
{
}

void MdlInitialize(void)
{
}

void MdlStart(void)
{
  motor_initialize();
}

void MdlTerminate(void)
{
  motor_terminate();
}

/* Registration function */
RT_MODEL_motor_T *motor(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* non-finite (run-time) assignments */
  motor_P.EncoderInput_InputFilter = rtInf;

  /* initialize real-time model */
  (void) memset((void *)motor_M, 0,
                sizeof(RT_MODEL_motor_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&motor_M->solverInfo, &motor_M->Timing.simTimeStep);
    rtsiSetTPtr(&motor_M->solverInfo, &rtmGetTPtr(motor_M));
    rtsiSetStepSizePtr(&motor_M->solverInfo, &motor_M->Timing.stepSize0);
    rtsiSetdXPtr(&motor_M->solverInfo, &motor_M->derivs);
    rtsiSetContStatesPtr(&motor_M->solverInfo, (real_T **) &motor_M->contStates);
    rtsiSetNumContStatesPtr(&motor_M->solverInfo, &motor_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&motor_M->solverInfo,
      &motor_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&motor_M->solverInfo,
      &motor_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&motor_M->solverInfo,
      &motor_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&motor_M->solverInfo, (&rtmGetErrorStatus(motor_M)));
    rtsiSetRTModelPtr(&motor_M->solverInfo, motor_M);
  }

  rtsiSetSimTimeStep(&motor_M->solverInfo, MAJOR_TIME_STEP);
  motor_M->intgData.y = motor_M->odeY;
  motor_M->intgData.f[0] = motor_M->odeF[0];
  motor_M->intgData.f[1] = motor_M->odeF[1];
  motor_M->intgData.f[2] = motor_M->odeF[2];
  motor_M->contStates = ((real_T *) &motor_X);
  rtsiSetSolverData(&motor_M->solverInfo, (void *)&motor_M->intgData);
  rtsiSetIsMinorTimeStepWithModeChange(&motor_M->solverInfo, false);
  rtsiSetSolverName(&motor_M->solverInfo,"ode3");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = motor_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;
    mdlTsMap[2] = 2;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "motor_M points to
       static memory which is guaranteed to be non-NULL" */
    motor_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    motor_M->Timing.sampleTimes = (&motor_M->Timing.sampleTimesArray[0]);
    motor_M->Timing.offsetTimes = (&motor_M->Timing.offsetTimesArray[0]);

    /* task periods */
    motor_M->Timing.sampleTimes[0] = (0.0);
    motor_M->Timing.sampleTimes[1] = (0.001);
    motor_M->Timing.sampleTimes[2] = (5.0);

    /* task offsets */
    motor_M->Timing.offsetTimes[0] = (0.0);
    motor_M->Timing.offsetTimes[1] = (0.0);
    motor_M->Timing.offsetTimes[2] = (0.0);
  }

  rtmSetTPtr(motor_M, &motor_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = motor_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    mdlSampleHits[2] = 1;
    motor_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(motor_M, 20.0);
  motor_M->Timing.stepSize0 = 0.001;
  motor_M->Timing.stepSize1 = 0.001;
  motor_M->Timing.stepSize2 = 5.0;

  /* External mode info */
  motor_M->Sizes.checksums[0] = (825957385U);
  motor_M->Sizes.checksums[1] = (36918580U);
  motor_M->Sizes.checksums[2] = (3046834604U);
  motor_M->Sizes.checksums[3] = (2533380472U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[4];
    motor_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    systemRan[2] = &rtAlwaysEnabled;
    systemRan[3] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(motor_M->extModeInfo,
      &motor_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(motor_M->extModeInfo, motor_M->Sizes.checksums);
    rteiSetTPtr(motor_M->extModeInfo, rtmGetTPtr(motor_M));
  }

  motor_M->solverInfoPtr = (&motor_M->solverInfo);
  motor_M->Timing.stepSize = (0.001);
  rtsiSetFixedStepSize(&motor_M->solverInfo, 0.001);
  rtsiSetSolverMode(&motor_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  motor_M->blockIO = ((void *) &motor_B);
  (void) memset(((void *) &motor_B), 0,
                sizeof(B_motor_T));

  /* parameters */
  motor_M->defaultParam = ((real_T *)&motor_P);

  /* states (continuous) */
  {
    real_T *x = (real_T *) &motor_X;
    motor_M->contStates = (x);
    (void) memset((void *)&motor_X, 0,
                  sizeof(X_motor_T));
  }

  /* states (dwork) */
  motor_M->dwork = ((void *) &motor_DW);
  (void) memset((void *)&motor_DW, 0,
                sizeof(DW_motor_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    motor_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 30;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  motor_M->Sizes.numContStates = (4);  /* Number of continuous states */
  motor_M->Sizes.numPeriodicContStates = (0);
                                      /* Number of periodic continuous states */
  motor_M->Sizes.numY = (0);           /* Number of model outputs */
  motor_M->Sizes.numU = (0);           /* Number of model inputs */
  motor_M->Sizes.sysDirFeedThru = (0); /* The model is not direct feedthrough */
  motor_M->Sizes.numSampTimes = (3);   /* Number of sample times */
  motor_M->Sizes.numBlocks = (42);     /* Number of blocks */
  motor_M->Sizes.numBlockIO = (10);    /* Number of block outputs */
  motor_M->Sizes.numBlockPrms = (57);  /* Sum of parameter "widths" */
  return motor_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
