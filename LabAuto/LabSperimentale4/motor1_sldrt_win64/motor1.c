/*
 * motor1.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "motor1".
 *
 * Model version              : 2.163
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C source code generated on : Mon Jun  5 14:06:21 2023
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "motor1.h"
#include "rtwtypes.h"
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
  0.02, 0.0,
};

/* list of Simulink Desktop Real-Time boards */
const int SLDRTBoardCount = 1;
SLDRTBOARD SLDRTBoards[1] = {
  { "National_Instruments/PCIe-6321", 4294967295U, 7, SLDRTBoardOptions0 },
};

/* Block signals (default storage) */
B_motor1_T motor1_B;

/* Block states (default storage) */
DW_motor1_T motor1_DW;

/* Real-time model */
static RT_MODEL_motor1_T motor1_M_;
RT_MODEL_motor1_T *const motor1_M = &motor1_M_;

/* Model output function */
void motor1_output(void)
{
  real_T rtb_AnalogInput[2];
  real_T rtb_Add;

  /* Step: '<Root>/Step' */
  if (motor1_M->Timing.t[0] < motor1_P.step.t) {
    /* Step: '<Root>/Step' */
    motor1_B.Step = motor1_P.Step_Y0;
  } else {
    /* Step: '<Root>/Step' */
    motor1_B.Step = motor1_P.step.A;
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
                   &rtb_Add, &parm);
  }

  /* S-Function (sldrtai): '<Root>/Analog Input' */
  /* S-Function Block: <Root>/Analog Input */
  {
    ANALOGIOPARM parm;
    parm.mode = (RANGEMODE) motor1_P.AnalogInput_RangeMode;
    parm.rangeidx = motor1_P.AnalogInput_VoltRange;
    RTBIO_DriverIO(0, ANALOGINPUT, IOREAD, 2, motor1_P.AnalogInput_Channels,
                   &rtb_AnalogInput[0], &parm);
  }

  /* Gain: '<Root>/Gain8' */
  motor1_B.Gain8 = motor1_P.sens.enc.pulse2deg * rtb_Add;

  /* DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn' */
  rtb_Add = motor1_B.Gain8;
  motor1_DW.DiscreteTransferFcn_tmp = ((rtb_Add -
    motor1_DW.DiscreteTransferFcn_states[0] * motor1_P.dend[1]) -
    motor1_DW.DiscreteTransferFcn_states[1] * motor1_P.dend[2]) / motor1_P.dend
    [0];
  rtb_Add = motor1_P.numd[0] * motor1_DW.DiscreteTransferFcn_tmp;

  /* Gain: '<Root>/Gain9' incorporates:
   *  DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn'
   */
  motor1_B.Gain9 = ((motor1_DW.DiscreteTransferFcn_states[0] * motor1_P.numd[1]
                     + rtb_Add) + motor1_DW.DiscreteTransferFcn_states[1] *
                    motor1_P.numd[2]) * motor1_P.degs2rpm;

  /* Sum: '<Root>/Sum3' */
  motor1_B.Sum3 = motor1_B.Step - motor1_B.Gain9;

  /* Gain: '<Root>/Gain12' */
  rtb_Add = motor1_P.rpm2rads * motor1_B.Sum3;

  /* Gain: '<Root>/Gain14' incorporates:
   *  Gain: '<Root>/Gain15'
   *  UnitDelay: '<Root>/Unit Delay'
   */
  motor1_B.Gain14 = 1.0 / motor1_P.awu.Tw * (motor1_P.awu.en *
    motor1_DW.UnitDelay_DSTATE);

  /* Sum: '<Root>/Sum6' incorporates:
   *  Gain: '<Root>/Gain13'
   */
  motor1_B.Sum6 = motor1_P.pid.Ki * rtb_Add - motor1_B.Gain14;

  /* DiscreteIntegrator: '<Root>/Discrete-Time Integrator' */
  motor1_B.DiscreteTimeIntegrator = motor1_P.DiscreteTimeIntegrator_gainval *
    motor1_B.Sum6 + motor1_DW.DiscreteTimeIntegrator_DSTATE;

  /* Sum: '<Root>/Sum4' incorporates:
   *  Gain: '<Root>/Gain11'
   */
  motor1_B.Sum4 = motor1_P.pid.Kp * rtb_Add + motor1_B.DiscreteTimeIntegrator;

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

  /* Sum: '<Root>/Add' */
  rtb_Add = rtb_AnalogInput[0] - rtb_AnalogInput[1];

  /* Gain: '<Root>/Gain1' */
  motor1_B.Gain1 = 1.0 / motor1_P.sens.curr.Rs * rtb_Add;

  /* Sum: '<Root>/Sum5' */
  motor1_B.Sum5 = motor1_B.Sum4 - motor1_B.Saturation2;
}

/* Model update function */
void motor1_update(void)
{
  /* Update for DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn' */
  motor1_DW.DiscreteTransferFcn_states[1] =
    motor1_DW.DiscreteTransferFcn_states[0];
  motor1_DW.DiscreteTransferFcn_states[0] = motor1_DW.DiscreteTransferFcn_tmp;

  /* Update for UnitDelay: '<Root>/Unit Delay' */
  motor1_DW.UnitDelay_DSTATE = motor1_B.Sum5;

  /* Update for DiscreteIntegrator: '<Root>/Discrete-Time Integrator' */
  motor1_DW.DiscreteTimeIntegrator_DSTATE =
    motor1_P.DiscreteTimeIntegrator_gainval * motor1_B.Sum6 +
    motor1_B.DiscreteTimeIntegrator;

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

  motor1_M->Timing.t[0] = motor1_M->Timing.clockTick0 *
    motor1_M->Timing.stepSize0 + motor1_M->Timing.clockTickH0 *
    motor1_M->Timing.stepSize0 * 4294967296.0;

  {
    /* Update absolute timer for sample time: [0.02s, 0.0s] */
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

  /* InitializeConditions for S-Function (sldrtei): '<Root>/Encoder Input' */

  /* S-Function Block: <Root>/Encoder Input */
  {
    ENCODERINPARM parm;
    parm.quad = (QUADMODE) 2;
    parm.index = (INDEXPULSE) 0;
    parm.infilter = motor1_P.EncoderInput_InputFilter;
    RTBIO_DriverIO(0, ENCODERINPUT, IORESET, 1, &motor1_P.EncoderInput_Channels,
                   NULL, &parm);
  }

  /* InitializeConditions for DiscreteTransferFcn: '<Root>/Discrete Transfer Fcn' */
  motor1_DW.DiscreteTransferFcn_states[0] =
    motor1_P.DiscreteTransferFcn_InitialStates;
  motor1_DW.DiscreteTransferFcn_states[1] =
    motor1_P.DiscreteTransferFcn_InitialStates;

  /* InitializeConditions for UnitDelay: '<Root>/Unit Delay' */
  motor1_DW.UnitDelay_DSTATE = motor1_P.UnitDelay_InitialCondition;

  /* InitializeConditions for DiscreteIntegrator: '<Root>/Discrete-Time Integrator' */
  motor1_DW.DiscreteTimeIntegrator_DSTATE = motor1_P.DiscreteTimeIntegrator_IC;
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
    rtsiSetErrorStatusPtr(&motor1_M->solverInfo, (&rtmGetErrorStatus(motor1_M)));
    rtsiSetRTModelPtr(&motor1_M->solverInfo, motor1_M);
  }

  rtsiSetSimTimeStep(&motor1_M->solverInfo, MAJOR_TIME_STEP);
  rtsiSetSolverName(&motor1_M->solverInfo,"FixedStepDiscrete");

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
    motor1_M->Timing.sampleTimes[1] = (0.02);

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

  rtmSetTFinal(motor1_M, 6.0);
  motor1_M->Timing.stepSize0 = 0.02;
  motor1_M->Timing.stepSize1 = 0.02;

  /* External mode info */
  motor1_M->Sizes.checksums[0] = (585271098U);
  motor1_M->Sizes.checksums[1] = (4110264194U);
  motor1_M->Sizes.checksums[2] = (3670977174U);
  motor1_M->Sizes.checksums[3] = (3178895664U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[1];
    motor1_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(motor1_M->extModeInfo,
      &motor1_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(motor1_M->extModeInfo, motor1_M->Sizes.checksums);
    rteiSetTPtr(motor1_M->extModeInfo, rtmGetTPtr(motor1_M));
  }

  motor1_M->solverInfoPtr = (&motor1_M->solverInfo);
  motor1_M->Timing.stepSize = (0.02);
  rtsiSetFixedStepSize(&motor1_M->solverInfo, 0.02);
  rtsiSetSolverMode(&motor1_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  motor1_M->blockIO = ((void *) &motor1_B);
  (void) memset(((void *) &motor1_B), 0,
                sizeof(B_motor1_T));

  /* parameters */
  motor1_M->defaultParam = ((real_T *)&motor1_P);

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
    dtInfo.numDataTypes = 33;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  motor1_M->Sizes.numContStates = (0); /* Number of continuous states */
  motor1_M->Sizes.numY = (0);          /* Number of model outputs */
  motor1_M->Sizes.numU = (0);          /* Number of model inputs */
  motor1_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  motor1_M->Sizes.numSampTimes = (2);  /* Number of sample times */
  motor1_M->Sizes.numBlocks = (22);    /* Number of blocks */
  motor1_M->Sizes.numBlockIO = (11);   /* Number of block outputs */
  motor1_M->Sizes.numBlockPrms = (35); /* Sum of parameter "widths" */
  return motor1_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
