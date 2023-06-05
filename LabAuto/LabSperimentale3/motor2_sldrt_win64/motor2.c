/*
 * motor2.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "motor2".
 *
 * Model version              : 2.157
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C source code generated on : Mon May 29 14:37:26 2023
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "motor2.h"
#include "rtwtypes.h"
#include "rt_nonfinite.h"
#include "motor2_private.h"
#include <string.h>
#include "motor2_dt.h"

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
B_motor2_T motor2_B;

/* Continuous states */
X_motor2_T motor2_X;

/* Block states (default storage) */
DW_motor2_T motor2_DW;

/* Real-time model */
static RT_MODEL_motor2_T motor2_M_;
RT_MODEL_motor2_T *const motor2_M = &motor2_M_;
static void rate_scheduler(void);

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
  (motor2_M->Timing.TaskCounters.TID[2])++;
  if ((motor2_M->Timing.TaskCounters.TID[2]) > 499) {/* Sample time: [0.5s, 0.0s] */
    motor2_M->Timing.TaskCounters.TID[2] = 0;
  }

  motor2_M->Timing.sampleHits[2] = (motor2_M->Timing.TaskCounters.TID[2] == 0) ?
    1 : 0;
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
  int_T nXc = 5;
  rtsiSetSimTimeStep(si,MINOR_TIME_STEP);

  /* Save the state values at time t in y, we'll use x as ynew. */
  (void) memcpy(y, x,
                (uint_T)nXc*sizeof(real_T));

  /* Assumes that rtsiSetT and ModelOutputs are up-to-date */
  /* f0 = f(t,y) */
  rtsiSetdX(si, f0);
  motor2_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE3_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[0]);
  rtsiSetdX(si, f1);
  motor2_output();
  motor2_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE3_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[1]);
  rtsiSetdX(si, f2);
  motor2_output();
  motor2_derivatives();

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

/* Model output function */
void motor2_output(void)
{
  real_T rtb_AnalogInput[2];
  real_T rtb_Gain12;
  real_T rtb_Gain16;
  real_T rtb_Gain21;
  real_T y;
  uint8_T rtb_Output_b;
  if (rtmIsMajorTimeStep(motor2_M)) {
    /* set solver stop time */
    if (!(motor2_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&motor2_M->solverInfo,
                            ((motor2_M->Timing.clockTickH0 + 1) *
        motor2_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&motor2_M->solverInfo, ((motor2_M->Timing.clockTick0
        + 1) * motor2_M->Timing.stepSize0 + motor2_M->Timing.clockTickH0 *
        motor2_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(motor2_M)) {
    motor2_M->Timing.t[0] = rtsiGetT(&motor2_M->solverInfo);
  }

  if (rtmIsMajorTimeStep(motor2_M) &&
      motor2_M->Timing.TaskCounters.TID[2] == 0) {
    /* UnitDelay: '<S2>/Output' */
    rtb_Output_b = motor2_DW.Output_DSTATE;

    /* SignalConversion: '<S1>/Out' incorporates:
     *  Constant: '<S1>/Vector'
     *  MultiPortSwitch: '<S1>/Output'
     *  UnitDelay: '<S2>/Output'
     */
    motor2_B.Out =
      motor2_P.RepeatingSequenceStair_OutValues[motor2_DW.Output_DSTATE];

    /* Gain: '<Root>/Gain22' incorporates:
     *  Gain: '<Root>/Gain18'
     *  Gain: '<Root>/Gain23'
     */
    motor2_B.Gain22 = motor2_P.ff.en * motor2_B.Out * motor2_P.rpm2rads *
      motor2_P.ff.inertia;
  }

  /* Integrator: '<Root>/Integrator2' */
  motor2_B.Integrator2 = motor2_X.Integrator2_CSTATE;

  /* Gain: '<Root>/Gain17' incorporates:
   *  Gain: '<Root>/Gain24'
   */
  rtb_Gain12 = motor2_P.ff.en * motor2_B.Integrator2 * motor2_P.rpm2rads;

  /* Gain: '<Root>/Gain21' */
  rtb_Gain21 = motor2_P.ff.viscous * rtb_Gain12;

  /* Signum: '<Root>/Sign1' */
  if (rtIsNaN(rtb_Gain12)) {
    y = (rtNaN);
  } else if (rtb_Gain12 < 0.0) {
    y = -1.0;
  } else {
    y = (rtb_Gain12 > 0.0);
  }

  /* End of Signum: '<Root>/Sign1' */

  /* Gain: '<Root>/Gain16' */
  rtb_Gain16 = motor2_P.ff.BEMF * rtb_Gain12;

  /* S-Function (sldrtei): '<Root>/Encoder Input' */
  /* S-Function Block: <Root>/Encoder Input */
  {
    ENCODERINPARM parm;
    parm.quad = (QUADMODE) 2;
    parm.index = (INDEXPULSE) 0;
    parm.infilter = motor2_P.EncoderInput_InputFilter;
    RTBIO_DriverIO(0, ENCODERINPUT, IOREAD, 1, &motor2_P.EncoderInput_Channels,
                   &rtb_Gain12, &parm);
  }

  if (rtmIsMajorTimeStep(motor2_M) &&
      motor2_M->Timing.TaskCounters.TID[1] == 0) {
    /* S-Function (sldrtai): '<Root>/Analog Input' */
    /* S-Function Block: <Root>/Analog Input */
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor2_P.AnalogInput_RangeMode;
      parm.rangeidx = motor2_P.AnalogInput_VoltRange;
      RTBIO_DriverIO(0, ANALOGINPUT, IOREAD, 2, motor2_P.AnalogInput_Channels,
                     &rtb_AnalogInput[0], &parm);
    }

    /* Delay: '<Root>/Delay' */
    motor2_B.Delay = motor2_DW.Delay_DSTATE[0];
  }

  /* Gain: '<Root>/Gain8' */
  motor2_B.Gain8 = motor2_P.sens.enc.pulse2deg * rtb_Gain12;

  /* MultiPortSwitch: '<Root>/Multiport Switch' incorporates:
   *  Constant: '<Root>/Constant'
   *  Gain: '<Root>/Gain7'
   *  Sum: '<Root>/Sum2'
   *  TransferFcn: '<Root>/Transfer Fcn4'
   *  TransferFcn: '<Root>/Transfer Fcn5'
   */
  switch ((int32_T)motor2_P.diff.type) {
   case 1:
    rtb_Gain12 = motor2_P.TransferFcn5_C * motor2_X.TransferFcn5_CSTATE +
      motor2_P.TransferFcn5_D * motor2_B.Gain8;
    break;

   case 2:
    rtb_Gain12 = motor2_P.TransferFcn4_C[0] * motor2_X.TransferFcn4_CSTATE[0] +
      motor2_P.TransferFcn4_C[1] * motor2_X.TransferFcn4_CSTATE[1];
    break;

   default:
    rtb_Gain12 = 1.0 / (motor2_P.diff.Ts * motor2_P.diff.N) * (motor2_B.Gain8 -
      motor2_B.Delay);
    break;
  }

  /* End of MultiPortSwitch: '<Root>/Multiport Switch' */

  /* Gain: '<Root>/Gain9' */
  motor2_B.Gain9 = motor2_P.degs2rpm * rtb_Gain12;

  /* Sum: '<Root>/Sum3' */
  motor2_B.Sum3 = motor2_B.Integrator2 - motor2_B.Gain9;

  /* Gain: '<Root>/Gain12' */
  rtb_Gain12 = motor2_P.rpm2rads * motor2_B.Sum3;

  /* Sum: '<Root>/Sum9' incorporates:
   *  Gain: '<Root>/Gain11'
   *  Gain: '<Root>/Gain19'
   *  Gain: '<Root>/Gain20'
   *  Integrator: '<Root>/Integrator1'
   *  Sum: '<Root>/Sum10'
   *  Sum: '<Root>/Sum4'
   *  Sum: '<Root>/Sum7'
   *  Sum: '<Root>/Sum8'
   */
  motor2_B.Sum9 = ((motor2_P.ff.coulomb * y + rtb_Gain21) * motor2_P.ff.friction
                   + ((motor2_P.pid.Kp * rtb_Gain12 +
                       motor2_X.Integrator1_CSTATE) + rtb_Gain16)) +
    motor2_B.Gain22;

  /* Saturate: '<Root>/Saturation2' */
  if (motor2_B.Sum9 > motor2_P.dac.V) {
    /* Saturate: '<Root>/Saturation2' */
    motor2_B.Saturation2 = motor2_P.dac.V;
  } else if (motor2_B.Sum9 < -motor2_P.dac.V) {
    /* Saturate: '<Root>/Saturation2' */
    motor2_B.Saturation2 = -motor2_P.dac.V;
  } else {
    /* Saturate: '<Root>/Saturation2' */
    motor2_B.Saturation2 = motor2_B.Sum9;
  }

  /* End of Saturate: '<Root>/Saturation2' */

  /* S-Function (sldrtao): '<Root>/Analog Output' */
  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor2_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor2_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &motor2_P.AnalogOutput_Channels, ((real_T*)
        (&motor2_B.Saturation2)), &parm);
    }
  }

  if (rtmIsMajorTimeStep(motor2_M) &&
      motor2_M->Timing.TaskCounters.TID[1] == 0) {
    /* Gain: '<Root>/Gain1' incorporates:
     *  Sum: '<Root>/Add'
     */
    motor2_B.Gain1 = 1.0 / motor2_P.sens.curr.Rs * (rtb_AnalogInput[0] -
      rtb_AnalogInput[1]);
  }

  if (rtmIsMajorTimeStep(motor2_M) &&
      motor2_M->Timing.TaskCounters.TID[2] == 0) {
    /* Sum: '<S3>/FixPt Sum1' incorporates:
     *  Constant: '<S3>/FixPt Constant'
     */
    rtb_Output_b += motor2_P.FixPtConstant_Value;

    /* Switch: '<S4>/FixPt Switch' */
    if (rtb_Output_b > motor2_P.LimitedCounter_uplimit) {
      /* Switch: '<S4>/FixPt Switch' incorporates:
       *  Constant: '<S4>/Constant'
       */
      motor2_B.FixPtSwitch = motor2_P.Constant_Value;
    } else {
      /* Switch: '<S4>/FixPt Switch' */
      motor2_B.FixPtSwitch = rtb_Output_b;
    }

    /* End of Switch: '<S4>/FixPt Switch' */
  }

  /* Sum: '<Root>/Sum6' incorporates:
   *  Gain: '<Root>/Gain13'
   *  Gain: '<Root>/Gain14'
   *  Gain: '<Root>/Gain15'
   *  Sum: '<Root>/Sum5'
   */
  motor2_B.Sum6 = motor2_P.pid.Ki * rtb_Gain12 - (motor2_B.Sum9 -
    motor2_B.Saturation2) * motor2_P.awu.en * (1.0 / motor2_P.awu.Tw);
}

/* Model update function */
void motor2_update(void)
{
  int_T idxDelay;
  if (rtmIsMajorTimeStep(motor2_M) &&
      motor2_M->Timing.TaskCounters.TID[2] == 0) {
    /* Update for UnitDelay: '<S2>/Output' */
    motor2_DW.Output_DSTATE = motor2_B.FixPtSwitch;
  }

  if (rtmIsMajorTimeStep(motor2_M) &&
      motor2_M->Timing.TaskCounters.TID[1] == 0) {
    /* Update for Delay: '<Root>/Delay' */
    for (idxDelay = 0; idxDelay < 9; idxDelay++) {
      motor2_DW.Delay_DSTATE[idxDelay] = motor2_DW.Delay_DSTATE[idxDelay + 1];
    }

    motor2_DW.Delay_DSTATE[9] = motor2_B.Gain8;

    /* End of Update for Delay: '<Root>/Delay' */
  }

  if (rtmIsMajorTimeStep(motor2_M)) {
    rt_ertODEUpdateContinuousStates(&motor2_M->solverInfo);
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
  if (!(++motor2_M->Timing.clockTick0)) {
    ++motor2_M->Timing.clockTickH0;
  }

  motor2_M->Timing.t[0] = rtsiGetSolverStopTime(&motor2_M->solverInfo);

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
    if (!(++motor2_M->Timing.clockTick1)) {
      ++motor2_M->Timing.clockTickH1;
    }

    motor2_M->Timing.t[1] = motor2_M->Timing.clockTick1 *
      motor2_M->Timing.stepSize1 + motor2_M->Timing.clockTickH1 *
      motor2_M->Timing.stepSize1 * 4294967296.0;
  }

  if (rtmIsMajorTimeStep(motor2_M) &&
      motor2_M->Timing.TaskCounters.TID[2] == 0) {
    /* Update absolute timer for sample time: [0.5s, 0.0s] */
    /* The "clockTick2" counts the number of times the code of this task has
     * been executed. The absolute time is the multiplication of "clockTick2"
     * and "Timing.stepSize2". Size of "clockTick2" ensures timer will not
     * overflow during the application lifespan selected.
     * Timer of this task consists of two 32 bit unsigned integers.
     * The two integers represent the low bits Timing.clockTick2 and the high bits
     * Timing.clockTickH2. When the low bit overflows to 0, the high bits increment.
     */
    if (!(++motor2_M->Timing.clockTick2)) {
      ++motor2_M->Timing.clockTickH2;
    }

    motor2_M->Timing.t[2] = motor2_M->Timing.clockTick2 *
      motor2_M->Timing.stepSize2 + motor2_M->Timing.clockTickH2 *
      motor2_M->Timing.stepSize2 * 4294967296.0;
  }

  rate_scheduler();
}

/* Derivatives for root system: '<Root>' */
void motor2_derivatives(void)
{
  XDot_motor2_T *_rtXdot;
  _rtXdot = ((XDot_motor2_T *) motor2_M->derivs);

  /* Derivatives for Integrator: '<Root>/Integrator2' */
  _rtXdot->Integrator2_CSTATE = motor2_B.Out;

  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn5' */
  _rtXdot->TransferFcn5_CSTATE = motor2_P.TransferFcn5_A *
    motor2_X.TransferFcn5_CSTATE;
  _rtXdot->TransferFcn5_CSTATE += motor2_B.Gain8;

  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn4' */
  _rtXdot->TransferFcn4_CSTATE[0] = motor2_P.TransferFcn4_A[0] *
    motor2_X.TransferFcn4_CSTATE[0];
  _rtXdot->TransferFcn4_CSTATE[0] += motor2_P.TransferFcn4_A[1] *
    motor2_X.TransferFcn4_CSTATE[1];
  _rtXdot->TransferFcn4_CSTATE[1] = motor2_X.TransferFcn4_CSTATE[0];
  _rtXdot->TransferFcn4_CSTATE[0] += motor2_B.Gain8;

  /* Derivatives for Integrator: '<Root>/Integrator1' */
  _rtXdot->Integrator1_CSTATE = motor2_B.Sum6;
}

/* Model initialize function */
void motor2_initialize(void)
{
  /* Start for S-Function (sldrtao): '<Root>/Analog Output' */

  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor2_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor2_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &motor2_P.AnalogOutput_Channels,
                     &motor2_P.AnalogOutput_InitialValue, &parm);
    }
  }

  {
    int32_T i;

    /* InitializeConditions for UnitDelay: '<S2>/Output' */
    motor2_DW.Output_DSTATE = motor2_P.Output_InitialCondition;

    /* InitializeConditions for Integrator: '<Root>/Integrator2' */
    motor2_X.Integrator2_CSTATE = motor2_P.Integrator2_IC;

    /* InitializeConditions for S-Function (sldrtei): '<Root>/Encoder Input' */

    /* S-Function Block: <Root>/Encoder Input */
    {
      ENCODERINPARM parm;
      parm.quad = (QUADMODE) 2;
      parm.index = (INDEXPULSE) 0;
      parm.infilter = motor2_P.EncoderInput_InputFilter;
      RTBIO_DriverIO(0, ENCODERINPUT, IORESET, 1,
                     &motor2_P.EncoderInput_Channels, NULL, &parm);
    }

    /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn5' */
    motor2_X.TransferFcn5_CSTATE = 0.0;

    /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn4' */
    motor2_X.TransferFcn4_CSTATE[0] = 0.0;
    motor2_X.TransferFcn4_CSTATE[1] = 0.0;

    /* InitializeConditions for Delay: '<Root>/Delay' */
    for (i = 0; i < 10; i++) {
      motor2_DW.Delay_DSTATE[i] = motor2_P.Delay_InitialCondition;
    }

    /* End of InitializeConditions for Delay: '<Root>/Delay' */

    /* InitializeConditions for Integrator: '<Root>/Integrator1' */
    motor2_X.Integrator1_CSTATE = motor2_P.Integrator1_IC;
  }
}

/* Model terminate function */
void motor2_terminate(void)
{
  /* Terminate for S-Function (sldrtao): '<Root>/Analog Output' */

  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor2_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor2_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &motor2_P.AnalogOutput_Channels,
                     &motor2_P.AnalogOutput_FinalValue, &parm);
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
  motor2_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  motor2_update();
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
  motor2_initialize();
}

void MdlTerminate(void)
{
  motor2_terminate();
}

/* Registration function */
RT_MODEL_motor2_T *motor2(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* non-finite (run-time) assignments */
  motor2_P.EncoderInput_InputFilter = rtInf;

  /* initialize real-time model */
  (void) memset((void *)motor2_M, 0,
                sizeof(RT_MODEL_motor2_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&motor2_M->solverInfo, &motor2_M->Timing.simTimeStep);
    rtsiSetTPtr(&motor2_M->solverInfo, &rtmGetTPtr(motor2_M));
    rtsiSetStepSizePtr(&motor2_M->solverInfo, &motor2_M->Timing.stepSize0);
    rtsiSetdXPtr(&motor2_M->solverInfo, &motor2_M->derivs);
    rtsiSetContStatesPtr(&motor2_M->solverInfo, (real_T **)
                         &motor2_M->contStates);
    rtsiSetNumContStatesPtr(&motor2_M->solverInfo,
      &motor2_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&motor2_M->solverInfo,
      &motor2_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&motor2_M->solverInfo,
      &motor2_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&motor2_M->solverInfo,
      &motor2_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&motor2_M->solverInfo, (&rtmGetErrorStatus(motor2_M)));
    rtsiSetRTModelPtr(&motor2_M->solverInfo, motor2_M);
  }

  rtsiSetSimTimeStep(&motor2_M->solverInfo, MAJOR_TIME_STEP);
  motor2_M->intgData.y = motor2_M->odeY;
  motor2_M->intgData.f[0] = motor2_M->odeF[0];
  motor2_M->intgData.f[1] = motor2_M->odeF[1];
  motor2_M->intgData.f[2] = motor2_M->odeF[2];
  motor2_M->contStates = ((real_T *) &motor2_X);
  rtsiSetSolverData(&motor2_M->solverInfo, (void *)&motor2_M->intgData);
  rtsiSetIsMinorTimeStepWithModeChange(&motor2_M->solverInfo, false);
  rtsiSetSolverName(&motor2_M->solverInfo,"ode3");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = motor2_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;
    mdlTsMap[2] = 2;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "motor2_M points to
       static memory which is guaranteed to be non-NULL" */
    motor2_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    motor2_M->Timing.sampleTimes = (&motor2_M->Timing.sampleTimesArray[0]);
    motor2_M->Timing.offsetTimes = (&motor2_M->Timing.offsetTimesArray[0]);

    /* task periods */
    motor2_M->Timing.sampleTimes[0] = (0.0);
    motor2_M->Timing.sampleTimes[1] = (0.001);
    motor2_M->Timing.sampleTimes[2] = (0.5);

    /* task offsets */
    motor2_M->Timing.offsetTimes[0] = (0.0);
    motor2_M->Timing.offsetTimes[1] = (0.0);
    motor2_M->Timing.offsetTimes[2] = (0.0);
  }

  rtmSetTPtr(motor2_M, &motor2_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = motor2_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    mdlSampleHits[2] = 1;
    motor2_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(motor2_M, 60.0);
  motor2_M->Timing.stepSize0 = 0.001;
  motor2_M->Timing.stepSize1 = 0.001;
  motor2_M->Timing.stepSize2 = 0.5;

  /* External mode info */
  motor2_M->Sizes.checksums[0] = (1403779099U);
  motor2_M->Sizes.checksums[1] = (505328843U);
  motor2_M->Sizes.checksums[2] = (1543816924U);
  motor2_M->Sizes.checksums[3] = (3765017758U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[3];
    motor2_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    systemRan[2] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(motor2_M->extModeInfo,
      &motor2_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(motor2_M->extModeInfo, motor2_M->Sizes.checksums);
    rteiSetTPtr(motor2_M->extModeInfo, rtmGetTPtr(motor2_M));
  }

  motor2_M->solverInfoPtr = (&motor2_M->solverInfo);
  motor2_M->Timing.stepSize = (0.001);
  rtsiSetFixedStepSize(&motor2_M->solverInfo, 0.001);
  rtsiSetSolverMode(&motor2_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  motor2_M->blockIO = ((void *) &motor2_B);
  (void) memset(((void *) &motor2_B), 0,
                sizeof(B_motor2_T));

  /* parameters */
  motor2_M->defaultParam = ((real_T *)&motor2_P);

  /* states (continuous) */
  {
    real_T *x = (real_T *) &motor2_X;
    motor2_M->contStates = (x);
    (void) memset((void *)&motor2_X, 0,
                  sizeof(X_motor2_T));
  }

  /* states (dwork) */
  motor2_M->dwork = ((void *) &motor2_DW);
  (void) memset((void *)&motor2_DW, 0,
                sizeof(DW_motor2_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    motor2_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 33;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  motor2_M->Sizes.numContStates = (5); /* Number of continuous states */
  motor2_M->Sizes.numPeriodicContStates = (0);
                                      /* Number of periodic continuous states */
  motor2_M->Sizes.numY = (0);          /* Number of model outputs */
  motor2_M->Sizes.numU = (0);          /* Number of model inputs */
  motor2_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  motor2_M->Sizes.numSampTimes = (3);  /* Number of sample times */
  motor2_M->Sizes.numBlocks = (51);    /* Number of blocks */
  motor2_M->Sizes.numBlockIO = (12);   /* Number of block outputs */
  motor2_M->Sizes.numBlockPrms = (45); /* Sum of parameter "widths" */
  return motor2_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
