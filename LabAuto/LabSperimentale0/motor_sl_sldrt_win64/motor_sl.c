/*
 * motor_sl.c
 *
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * Code generation for model "motor_sl".
 *
 * Model version              : 1.9
 * Simulink Coder version : 9.8 (R2022b) 13-May-2022
 * C source code generated on : Mon May  8 15:16:30 2023
 *
 * Target selection: sldrt.tlc
 * Note: GRT includes extra infrastructure and instrumentation for prototyping
 * Embedded hardware selection: Intel->x86-64 (Linux 64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#include "motor_sl.h"
#include <string.h>
#include "rt_nonfinite.h"
#include "motor_sl_dt.h"

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
B_motor_sl_T motor_sl_B;

/* Block states (default storage) */
DW_motor_sl_T motor_sl_DW;

/* Real-time model */
static RT_MODEL_motor_sl_T motor_sl_M_;
RT_MODEL_motor_sl_T *const motor_sl_M = &motor_sl_M_;

/* Model output function */
void motor_sl_output(void)
{
  /* S-Function (sldrtao): '<Root>/Analog Output' incorporates:
   *  Constant: '<Root>/ '
   */
  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor_sl_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor_sl_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &motor_sl_P.AnalogOutput_Channels, ((real_T*)
        (&motor_sl_P._Value)), &parm);
    }
  }

  /* S-Function (sldrtai): '<Root>/Analog Input' */
  /* S-Function Block: <Root>/Analog Input */
  {
    ANALOGIOPARM parm;
    parm.mode = (RANGEMODE) motor_sl_P.AnalogInput_RangeMode;
    parm.rangeidx = motor_sl_P.AnalogInput_VoltRange;
    RTBIO_DriverIO(0, ANALOGINPUT, IOREAD, 2, motor_sl_P.AnalogInput_Channels,
                   &motor_sl_B.AnalogInput[0], &parm);
  }

  /* S-Function (sldrtei): '<Root>/Encoder Input' */
  /* S-Function Block: <Root>/Encoder Input */
  {
    ENCODERINPARM parm;
    parm.quad = (QUADMODE) 2;
    parm.index = (INDEXPULSE) 0;
    parm.infilter = motor_sl_P.EncoderInput_InputFilter;
    RTBIO_DriverIO(0, ENCODERINPUT, IOREAD, 1, &motor_sl_P.EncoderInput_Channels,
                   &motor_sl_B.EncoderInput, &parm);
  }
}

/* Model update function */
void motor_sl_update(void)
{
  /* Update absolute time for base rate */
  /* The "clockTick0" counts the number of times the code of this task has
   * been executed. The absolute time is the multiplication of "clockTick0"
   * and "Timing.stepSize0". Size of "clockTick0" ensures timer will not
   * overflow during the application lifespan selected.
   * Timer of this task consists of two 32 bit unsigned integers.
   * The two integers represent the low bits Timing.clockTick0 and the high bits
   * Timing.clockTickH0. When the low bit overflows to 0, the high bits increment.
   */
  if (!(++motor_sl_M->Timing.clockTick0)) {
    ++motor_sl_M->Timing.clockTickH0;
  }

  motor_sl_M->Timing.t[0] = motor_sl_M->Timing.clockTick0 *
    motor_sl_M->Timing.stepSize0 + motor_sl_M->Timing.clockTickH0 *
    motor_sl_M->Timing.stepSize0 * 4294967296.0;
}

/* Model initialize function */
void motor_sl_initialize(void)
{
  /* Start for S-Function (sldrtao): '<Root>/Analog Output' incorporates:
   *  Constant: '<Root>/ '
   */

  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor_sl_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor_sl_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &motor_sl_P.AnalogOutput_Channels,
                     &motor_sl_P.AnalogOutput_InitialValue, &parm);
    }
  }

  /* InitializeConditions for S-Function (sldrtei): '<Root>/Encoder Input' */

  /* S-Function Block: <Root>/Encoder Input */
  {
    ENCODERINPARM parm;
    parm.quad = (QUADMODE) 2;
    parm.index = (INDEXPULSE) 0;
    parm.infilter = motor_sl_P.EncoderInput_InputFilter;
    RTBIO_DriverIO(0, ENCODERINPUT, IORESET, 1,
                   &motor_sl_P.EncoderInput_Channels, NULL, &parm);
  }
}

/* Model terminate function */
void motor_sl_terminate(void)
{
  /* Terminate for S-Function (sldrtao): '<Root>/Analog Output' incorporates:
   *  Constant: '<Root>/ '
   */

  /* S-Function Block: <Root>/Analog Output */
  {
    {
      ANALOGIOPARM parm;
      parm.mode = (RANGEMODE) motor_sl_P.AnalogOutput_RangeMode;
      parm.rangeidx = motor_sl_P.AnalogOutput_VoltRange;
      RTBIO_DriverIO(0, ANALOGOUTPUT, IOWRITE, 1,
                     &motor_sl_P.AnalogOutput_Channels,
                     &motor_sl_P.AnalogOutput_FinalValue, &parm);
    }
  }
}

/*========================================================================*
 * Start of Classic call interface                                        *
 *========================================================================*/
void MdlOutputs(int_T tid)
{
  motor_sl_output();
  UNUSED_PARAMETER(tid);
}

void MdlUpdate(int_T tid)
{
  motor_sl_update();
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
  motor_sl_initialize();
}

void MdlTerminate(void)
{
  motor_sl_terminate();
}

/* Registration function */
RT_MODEL_motor_sl_T *motor_sl(void)
{
  /* Registration code */

  /* initialize non-finites */
  rt_InitInfAndNaN(sizeof(real_T));

  /* non-finite (run-time) assignments */
  motor_sl_P.EncoderInput_InputFilter = rtInf;

  /* initialize real-time model */
  (void) memset((void *)motor_sl_M, 0,
                sizeof(RT_MODEL_motor_sl_T));

  /* Initialize timing info */
  {
    int_T *mdlTsMap = motor_sl_M->Timing.sampleTimeTaskIDArray;
    mdlTsMap[0] = 0;

    /* polyspace +2 MISRA2012:D4.1 [Justified:Low] "motor_sl_M points to
       static memory which is guaranteed to be non-NULL" */
    motor_sl_M->Timing.sampleTimeTaskIDPtr = (&mdlTsMap[0]);
    motor_sl_M->Timing.sampleTimes = (&motor_sl_M->Timing.sampleTimesArray[0]);
    motor_sl_M->Timing.offsetTimes = (&motor_sl_M->Timing.offsetTimesArray[0]);

    /* task periods */
    motor_sl_M->Timing.sampleTimes[0] = (0.001);

    /* task offsets */
    motor_sl_M->Timing.offsetTimes[0] = (0.0);
  }

  rtmSetTPtr(motor_sl_M, &motor_sl_M->Timing.tArray[0]);

  {
    int_T *mdlSampleHits = motor_sl_M->Timing.sampleHitArray;
    mdlSampleHits[0] = 1;
    motor_sl_M->Timing.sampleHits = (&mdlSampleHits[0]);
  }

  rtmSetTFinal(motor_sl_M, -1);
  motor_sl_M->Timing.stepSize0 = 0.001;

  /* External mode info */
  motor_sl_M->Sizes.checksums[0] = (1782005169U);
  motor_sl_M->Sizes.checksums[1] = (3947431751U);
  motor_sl_M->Sizes.checksums[2] = (220718544U);
  motor_sl_M->Sizes.checksums[3] = (4118409340U);

  {
    static const sysRanDType rtAlwaysEnabled = SUBSYS_RAN_BC_ENABLE;
    static RTWExtModeInfo rt_ExtModeInfo;
    static const sysRanDType *systemRan[1];
    motor_sl_M->extModeInfo = (&rt_ExtModeInfo);
    rteiSetSubSystemActiveVectorAddresses(&rt_ExtModeInfo, systemRan);
    systemRan[0] = &rtAlwaysEnabled;
    rteiSetModelMappingInfoPtr(motor_sl_M->extModeInfo,
      &motor_sl_M->SpecialInfo.mappingInfo);
    rteiSetChecksumsPtr(motor_sl_M->extModeInfo, motor_sl_M->Sizes.checksums);
    rteiSetTPtr(motor_sl_M->extModeInfo, rtmGetTPtr(motor_sl_M));
  }

  motor_sl_M->solverInfoPtr = (&motor_sl_M->solverInfo);
  motor_sl_M->Timing.stepSize = (0.001);
  rtsiSetFixedStepSize(&motor_sl_M->solverInfo, 0.001);
  rtsiSetSolverMode(&motor_sl_M->solverInfo, SOLVER_MODE_SINGLETASKING);

  /* block I/O */
  motor_sl_M->blockIO = ((void *) &motor_sl_B);
  (void) memset(((void *) &motor_sl_B), 0,
                sizeof(B_motor_sl_T));

  /* parameters */
  motor_sl_M->defaultParam = ((real_T *)&motor_sl_P);

  /* states (dwork) */
  motor_sl_M->dwork = ((void *) &motor_sl_DW);
  (void) memset((void *)&motor_sl_DW, 0,
                sizeof(DW_motor_sl_T));

  /* data type transition information */
  {
    static DataTypeTransInfo dtInfo;
    (void) memset((char_T *) &dtInfo, 0,
                  sizeof(dtInfo));
    motor_sl_M->SpecialInfo.mappingInfo = (&dtInfo);
    dtInfo.numDataTypes = 23;
    dtInfo.dataTypeSizes = &rtDataTypeSizes[0];
    dtInfo.dataTypeNames = &rtDataTypeNames[0];

    /* Block I/O transition table */
    dtInfo.BTransTable = &rtBTransTable;

    /* Parameters transition table */
    dtInfo.PTransTable = &rtPTransTable;
  }

  /* Initialize Sizes */
  motor_sl_M->Sizes.numContStates = (0);/* Number of continuous states */
  motor_sl_M->Sizes.numY = (0);        /* Number of model outputs */
  motor_sl_M->Sizes.numU = (0);        /* Number of model inputs */
  motor_sl_M->Sizes.sysDirFeedThru = (0);/* The model is not direct feedthrough */
  motor_sl_M->Sizes.numSampTimes = (1);/* Number of sample times */
  motor_sl_M->Sizes.numBlocks = (6);   /* Number of blocks */
  motor_sl_M->Sizes.numBlockIO = (2);  /* Number of block outputs */
  motor_sl_M->Sizes.numBlockPrms = (18);/* Sum of parameter "widths" */
  return motor_sl_M;
}

/*========================================================================*
 * End of Classic call interface                                          *
 *========================================================================*/
