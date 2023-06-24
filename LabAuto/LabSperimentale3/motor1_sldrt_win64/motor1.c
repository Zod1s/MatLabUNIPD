/*
 * motor1.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "motor1".
 *
 * Model version              : 2.139
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C source code generated on : Mon Jun  5 13:14:34 2023
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "motor1.h"
#include "rtwtypes.h"
#include "motor1_private.h"
#include <string.h>
#include "rt_nonfinite.h"
#include "motor1_dt.h"

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
B_motor1_T motor1_B;

/* Continuous states */
X_motor1_T motor1_X;

/* Block states (default storage) */
DW_motor1_T motor1_DW;

/* Real-time model */
static RT_MODEL_motor1_T motor1_M_;
RT_MODEL_motor1_T *const motor1_M = &motor1_M_;

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
  motor1_derivatives();

  /* f(:,2) = feval(odefile, t + hA(1), y + f*hB(:,1), args(:)(*)); */
  hB[0] = h * rt_ODE3_B[0][0];
  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[0]);
  rtsiSetdX(si, f1);
  motor1_output();
  motor1_derivatives();

  /* f(:,3) = feval(odefile, t + hA(2), y + f*hB(:,2), args(:)(*)); */
  for (i = 0; i <= 1; i++) {
    hB[i] = h * rt_ODE3_B[1][i];
  }

  for (i = 0; i < nXc; i++) {
    x[i] = y[i] + (f0[i]*hB[0] + f1[i]*hB[1]);
  }

  rtsiSetT(si, t + h*rt_ODE3_A[1]);
  rtsiSetdX(si, f2);
  motor1_output();
  motor1_derivatives();

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
void motor1_output(void)
{
  real_T rtb_AnalogInput[2];
  real_T rtb_Gain12;
  if (rtmIsMajorTimeStep(motor1_M)) {
    /* set solver stop time */
    if (!(motor1_M->Timing.clockTick0+1)) {
      rtsiSetSolverStopTime(&motor1_M->solverInfo,
                            ((motor1_M->Timing.clockTickH0 + 1) *
        motor1_M->Timing.stepSize0 * 4294967296.0));
    } else {
      rtsiSetSolverStopTime(&motor1_M->solverInfo, ((motor1_M->Timing.clockTick0
        + 1) * motor1_M->Timing.stepSize0 + motor1_M->Timing.clockTickH0 *
        motor1_M->Timing.stepSize0 * 4294967296.0));
    }
  }                                    /* end MajorTimeStep */

  /* Update absolute time of base rate at minor time step */
  if (rtmIsMinorTimeStep(motor1_M)) {
    motor1_M->Timing.t[0] = rtsiGetT(&motor1_M->solverInfo);
  }

  /* Step: '<Root>/Step' */
  if (motor1_M->Timing.t[0] < motor1_P.Step_Time) {
    /* Step: '<Root>/Step' */
    motor1_B.Step = motor1_P.Step_Y0;
  } else {
    /* Step: '<Root>/Step' */
    motor1_B.Step = motor1_P.Step_YFinal;
  }

  /* End of Step: '<Root>/Step' */

  /* S-Function (sldrtei): '<Root>/Encoder Input' */
  /* S-Function Block: <Root>/Encoder Input */
  {
    ENCODERINPARM parm;
    parm.quad = (QUADMODE) 2;
    parm.index = (INDEXPULSE) 0;
    parm.infilter = motor1_P.EncoderInput_InputFilter;
    RTBIO_DriverIO(0, ENCODERINPUT, IOREAD, 1, &motor1_P.EncoderInput_Channels,
                   &rtb_Gain12, &parm);
  }

  if (rtmIsMajorTimeStep(motor1_M)) {
    /* S-Function (sldrtai): '<Root>/Analog Input' */
    /* S-Function Block: <Root>/Analog Input */
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor1_P.AnalogInput_RangeMode;
      parm.rangeidx = motor1_P.AnalogInput_VoltRange;
      RTBIO_DriverIO(0, ANALOGINPUT, IOREAD, 2, motor1_P.AnalogInput_Channels,
                     &rtb_AnalogInput[0], &parm);
    }

    /* Delay: '<Root>/Delay' */
    motor1_B.Delay = motor1_DW.Delay_DSTATE[0];
  }

  /* Gain: '<Root>/Gain8' */
  motor1_B.Gain8 = motor1_P.sens.enc.pulse2deg * rtb_Gain12;

  /* MultiPortSwitch: '<Root>/Multiport Switch' incorporates:
   *  Constant: '<Root>/Constant'
   *  Gain: '<Root>/Gain7'
   *  Sum: '<Root>/Sum2'
   *  TransferFcn: '<Root>/Transfer Fcn4'
   *  TransferFcn: '<Root>/Transfer Fcn5'
   */
  switch ((int32_T)motor1_P.diff.type) {
   case 1:
    rtb_Gain12 = motor1_P.TransferFcn5_C * motor1_X.TransferFcn5_CSTATE +
      motor1_P.TransferFcn5_D * motor1_B.Gain8;
    break;

   case 2:
    rtb_Gain12 = motor1_P.TransferFcn4_C[0] * motor1_X.TransferFcn4_CSTATE[0] +
      motor1_P.TransferFcn4_C[1] * motor1_X.TransferFcn4_CSTATE[1];
    break;

   default:
    rtb_Gain12 = 1.0 / (motor1_P.diff.Ts * motor1_P.diff.N) * (motor1_B.Gain8 -
      motor1_B.Delay);
    break;
  }

  /* End of MultiPortSwitch: '<Root>/Multiport Switch' */

  /* Gain: '<Root>/Gain9' */
  motor1_B.Gain9 = motor1_P.degs2rpm * rtb_Gain12;

  /* Sum: '<Root>/Sum3' */
  motor1_B.Sum3 = motor1_B.Step - motor1_B.Gain9;

  /* Gain: '<Root>/Gain12' */
  rtb_Gain12 = motor1_P.rpm2rads * motor1_B.Sum3;

  /* Sum: '<Root>/Sum4' incorporates:
   *  Gain: '<Root>/Gain11'
   *  Integrator: '<Root>/Integrator1'
   */
  motor1_B.Sum4 = motor1_P.pid.Kp * rtb_Gain12 + motor1_X.Integrator1_CSTATE;

  /* Saturate: '<Root>/Saturation2' */
  if (motor1_B.Sum4 > motor1_P.dac.V) {
    /* Saturate: '<Root>/Saturation2' */
    motor1_B.Saturation2 = motor1_P.dac.V;
  } else if (motor1_B.Sum4 < -motor1_P.dac.V) {
    /* Saturate: '<Root>/Saturation2' */
    motor1_B.Saturation2 = -motor1_P.dac.V;
  } else {
    /* Saturate: '<Root>/Saturation2' */
    motor1_B.Saturation2 = motor1_B.Sum4;
  }

  /* End of Saturate: '<Root>/Saturation2' */

  /* S-Function (sldrtao): '<Root>/Analog Output' */
  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor1_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor1_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &motor1_P.AnalogOutput_Channels, ((real_T*)
        (&motor1_B.Saturation2)), &parm);
    }
  }

  if (rtmIsMajorTimeStep(motor1_M)) {
    /* Gain: '<Root>/Gain1' incorporates:
     *  Sum: '<Root>/Add'
     */
    motor1_B.Gain1 = 1.0 / motor1_P.sens.curr.Rs * (rtb_AnalogInput[0] -
      rtb_AnalogInput[1]);
  }

  /* Sum: '<Root>/Sum6' incorporates:
   *  Gain: '<Root>/Gain13'
   *  Gain: '<Root>/Gain14'
   *  Gain: '<Root>/Gain15'
   *  Sum: '<Root>/Sum5'
   */
  motor1_B.Sum6 = motor1_P.pid.Ki * rtb_Gain12 - (motor1_B.Sum4 -
    motor1_B.Saturation2) * motor1_P.awu.en * (1.0 / motor1_P.awu.Tw);
}

/* Model update function */
void motor1_update(void)
{
  int_T idxDelay;
  if (rtmIsMajorTimeStep(motor1_M)) {
    /* Update for Delay: '<Root>/Delay' */
    for (idxDelay = 0; idxDelay < 9; idxDelay++) {
      motor1_DW.Delay_DSTATE[idxDelay] = motor1_DW.Delay_DSTATE[idxDelay + 1];
    }

    motor1_DW.Delay_DSTATE[9] = motor1_B.Gain8;

    /* End of Update for Delay: '<Root>/Delay' */
  }

  if (rtmIsMajorTimeStep(motor1_M)) {
    rt_ertODEUpdateContinuousStates(&motor1_M->solverInfo);
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
  if (!(++motor1_M->Timing.clockTick0)) {
    ++motor1_M->Timing.clockTickH0;
  }

  motor1_M->Timing.t[0] = rtsiGetSolverStopTime(&motor1_M->solverInfo);

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
    if (!(++motor1_M->Timing.clockTick1)) {
      ++motor1_M->Timing.clockTickH1;
    }

    motor1_M->Timing.t[1] = motor1_M->Timing.clockTick1 *
      motor1_M->Timing.stepSize1 + motor1_M->Timing.clockTickH1 *
      motor1_M->Timing.stepSize1 * 4294967296.0;
  }
}

/* Derivatives for root system: '<Root>' */
void motor1_derivatives(void)
{
  XDot_motor1_T *_rtXdot;
  _rtXdot = ((XDot_motor1_T *) motor1_M->derivs);

  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn5' */
  _rtXdot->TransferFcn5_CSTATE = motor1_P.TransferFcn5_A *
    motor1_X.TransferFcn5_CSTATE;
  _rtXdot->TransferFcn5_CSTATE += motor1_B.Gain8;

  /* Derivatives for TransferFcn: '<Root>/Transfer Fcn4' */
  _rtXdot->TransferFcn4_CSTATE[0] = motor1_P.TransferFcn4_A[0] *
    motor1_X.TransferFcn4_CSTATE[0];
  _rtXdot->TransferFcn4_CSTATE[0] += motor1_P.TransferFcn4_A[1] *
    motor1_X.TransferFcn4_CSTATE[1];
  _rtXdot->TransferFcn4_CSTATE[1] = motor1_X.TransferFcn4_CSTATE[0];
  _rtXdot->TransferFcn4_CSTATE[0] += motor1_B.Gain8;

  /* Derivatives for Integrator: '<Root>/Integrator1' */
  _rtXdot->Integrator1_CSTATE = motor1_B.Sum6;
}

/* Model initialize function */
void motor1_initialize(void)
{
  /* Start for S-Function (sldrtao): '<Root>/Analog Output' */

  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor1_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor1_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &motor1_P.AnalogOutput_Channels,
                     &motor1_P.AnalogOutput_InitialValue, &parm);
    }
  }

  {
    int32_T i;

    /* InitializeConditions for S-Function (sldrtei): '<Root>/Encoder Input' */

    /* S-Function Block: <Root>/Encoder Input */
    {
      ENCODERINPARM parm;
      parm.quad = (QUADMODE) 2;
      parm.index = (INDEXPULSE) 0;
      parm.infilter = motor1_P.EncoderInput_InputFilter;
      RTBIO_DriverIO(0, ENCODERINPUT, IORESET, 1,
                     &motor1_P.EncoderInput_Channels, NULL, &parm);
    }

    /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn5' */
    motor1_X.TransferFcn5_CSTATE = 0.0;

    /* InitializeConditions for TransferFcn: '<Root>/Transfer Fcn4' */
    motor1_X.TransferFcn4_CSTATE[0] = 0.0;
    motor1_X.TransferFcn4_CSTATE[1] = 0.0;

    /* InitializeConditions for Delay: '<Root>/Delay' */
    for (i = 0; i < 10; i++) {
      motor1_DW.Delay_DSTATE[i] = motor1_P.Delay_InitialCondition;
    }

    /* End of InitializeConditions for Delay: '<Root>/Delay' */

    /* InitializeConditions for Integrator: '<Root>/Integrator1' */
    motor1_X.Integrator1_CSTATE = motor1_P.Integrator1_IC;
  }
}

/* Model terminate function */
void motor1_terminate(void)
{
  /* Terminate for S-Function (sldrtao): '<Root>/Analog Output' */

  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor1_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor1_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &motor1_P.AnalogOutput_Channels,
                     &motor1_P.AnalogOutput_FinalValue, &parm);
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
  motor1_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  motor1_update();
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
  motor1_initialize();
}

void MdlTerminate(void)
{
  motor1_terminate();
}

/* Registration function */
RT_MODEL_motor1_T *motor1(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* non-finite (run-time) assignments */
  motor1_P.EncoderInput_InputFilter = rtInf;

  /* initialize real-time model */
  (void) memset((void *)motor1_M, 0,
                sizeof(RT_MODEL_motor1_T));

  {
    /* Setup solver object */
    rtsiSetSimTimeStepPtr(&motor1_M->solverInfo, &motor1_M->Timing.simTimeStep);
    rtsiSetTPtr(&motor1_M->solverInfo, &rtmGetTPtr(motor1_M));
    rtsiSetStepSizePtr(&motor1_M->solverInfo, &motor1_M->Timing.stepSize0);
    rtsiSetdXPtr(&motor1_M->solverInfo, &motor1_M->derivs);
    rtsiSetContStatesPtr(&motor1_M->solverInfo, (real_T **)
                         &motor1_M->contStates);
    rtsiSetNumContStatesPtr(&motor1_M->solverInfo,
      &motor1_M->Sizes.numContStates);
    rtsiSetNumPeriodicContStatesPtr(&motor1_M->solverInfo,
      &motor1_M->Sizes.numPeriodicContStates);
    rtsiSetPeriodicContStateIndicesPtr(&motor1_M->solverInfo,
      &motor1_M->periodicContStateIndices);
    rtsiSetPeriodicContStateRangesPtr(&motor1_M->solverInfo,
      &motor1_M->periodicContStateRanges);
    rtsiSetErrorStatusPtr(&motor1_M->solverInfo, (&rtmGetErrorStatus(motor1_M)));
    rtsiSetRTModelPtr(&motor1_M->solverInfo, motor1_M);
  }

  rtsiSetSimTimeStep(&motor1_M->solverInfo, MAJOR_TIME_STEP);
  motor1_M->intgData.y = motor1_M->odeY;
  motor1_M->intgData.f[0] = motor1_M->odeF[0];
  motor1_M->intgData.f[1] = motor1_M->odeF[1];
  motor1_M->intgData.f[2] = motor1_M->odeF[2];
  motor1_M->contStates = ((real_T *) &motor1_X);
  rtsiSetSolverData(&motor1_M->solverInfo, (void *)&motor1_M->intgData);
  rtsiSetIsMinorTimeStepWithModeChange(&motor1_M->solverInfo, false);
  rtsiSetSolverName(&motor1_M->solverInfo,"ode3");

  /* Initialize timing info */
  {
    int_T *mdlTsMap = motor1_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;
    mdlTsMap[1] = 1;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "motor1_M points to
       static memory which is guaranteed to be non-NULL" */
    motor1_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    motor1_M->Timing.sampleTimes = (&motor1_M->Timing.sampleTimesArray[0]);
    motor1_M->Timing.offsetTimes = (&motor1_M->Timing.offsetTimesArray[0]);

    /* task periods */
    motor1_M->Timing.sampleTimes[0] = (0.0);
    motor1_M->Timing.sampleTimes[1] = (0.001);

    /* task offsets */
    motor1_M->Timing.offsetTimes[0] = (0.0);
    motor1_M->Timing.offsetTimes[1] = (0.0);
  }

  rtmSetTPtr(motor1_M, &motor1_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = motor1_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    mdlSampleHits[1] = 1;
    motor1_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(motor1_M, 10.0);
  motor1_M->Timing.stepSize0 = 0.001;
  motor1_M->Timing.stepSize1 = 0.001;

  /* External mode info */
  motor1_M->Sizes.checksums[0] = (2926885492U);
  motor1_M->Sizes.checksums[1] = (3451647470U);
  motor1_M->Sizes.checksums[2] = (3024741962U);
  motor1_M->Sizes.checksums[3] = (4263998205U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[2];
    motor1_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    systemRan[1] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(motor1_M->extModeInfo,
      &motor1_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(motor1_M->extModeInfo, motor1_M->Sizes.checksums);
    rteiSetTPtr(motor1_M->extModeInfo, rtmGetTPtr(motor1_M));
  }

  motor1_M->solverInfoPtr = (&motor1_M->solverInfo);
  motor1_M->Timing.stepSize = (0.001);
  rtsiSetFixedStepSize(&motor1_M->solverInfo, 0.001);
  rtsiSetSolverMode(&motor1_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  motor1_M->blockIO = ((void *) &motor1_B);
  (void) memset(((void *) &motor1_B), 0,
                sizeof(B_motor1_T));

  /* parameters */
  motor1_M->defaultParam = ((real_T *)&motor1_P);

  /* states (continuous) */
  {
    real_T *x = (real_T *) &motor1_X;
    motor1_M->contStates = (x);
    (void) memset((void *)&motor1_X, 0,
                  sizeof(X_motor1_T));
  }

  /* states (dwork) */
  motor1_M->dwork = ((void *) &motor1_DW);
  (void) memset((void *)&motor1_DW, 0,
                sizeof(DW_motor1_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    motor1_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 32;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  motor1_M->Sizes.numContStates = (4); /* Number of continuous states */
  motor1_M->Sizes.numPeriodicContStates = (0);
                                      /* Number of periodic continuous states */
  motor1_M->Sizes.numY = (0);          /* Number of model outputs */
  motor1_M->Sizes.numU = (0);          /* Number of model inputs */
  motor1_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  motor1_M->Sizes.numSampTimes = (2);  /* Number of sample times */
  motor1_M->Sizes.numBlocks = (28);    /* Number of blocks */
  motor1_M->Sizes.numBlockIO = (9);    /* Number of block outputs */
  motor1_M->Sizes.numBlockPrms = (36); /* Sum of parameter "widths" */
  return motor1_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
