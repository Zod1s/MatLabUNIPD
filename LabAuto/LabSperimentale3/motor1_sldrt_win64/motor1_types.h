/*
 * motor1_types.h
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

#ifndef RTW_HEADER_motor1_types_h_
#define RTW_HEADER_motor1_types_h_
#include "rtwtypes.h"
#ifndef DEFINED_TYPEDEF_FOR_struct_zh0Jahtydja9slL4vn0KNB_
#define DEFINED_TYPEDEF_FOR_struct_zh0Jahtydja9slL4vn0KNB_

typedef struct {
  real_T Tc;
  real_T wc;
  real_T d;
  real_T N;
  real_T Ts;
  real_T type;
} struct_zh0Jahtydja9slL4vn0KNB;

#endif

#ifndef DEFINED_TYPEDEF_FOR_struct_vHPMdAr9HfDgWNbG6U3SfC_
#define DEFINED_TYPEDEF_FOR_struct_vHPMdAr9HfDgWNbG6U3SfC_

typedef struct {
  real_T Rs;
} struct_vHPMdAr9HfDgWNbG6U3SfC;

#endif

#ifndef DEFINED_TYPEDEF_FOR_struct_nZqFUEOh71pPhzsMP64FWD_
#define DEFINED_TYPEDEF_FOR_struct_nZqFUEOh71pPhzsMP64FWD_

typedef struct {
  real_T ppr;
  real_T pulse2deg;
  real_T pulse2rad;
  real_T deg2pulse;
  real_T rad2pulse;
} struct_nZqFUEOh71pPhzsMP64FWD;

#endif

#ifndef DEFINED_TYPEDEF_FOR_struct_DqRrFctOcoTwJhkxMXTGZG_
#define DEFINED_TYPEDEF_FOR_struct_DqRrFctOcoTwJhkxMXTGZG_

typedef struct {
  real_T R;
  real_T V;
  real_T th_deg;
  real_T th;
} struct_DqRrFctOcoTwJhkxMXTGZG;

#endif

#ifndef DEFINED_TYPEDEF_FOR_struct_t4jfYKvXkqvqbOrnXV9flF_
#define DEFINED_TYPEDEF_FOR_struct_t4jfYKvXkqvqbOrnXV9flF_

typedef struct {
  struct_DqRrFctOcoTwJhkxMXTGZG range;
  real_T deg2V;
  real_T rad2V;
  real_T V2deg;
  real_T V2rad;
} struct_t4jfYKvXkqvqbOrnXV9flF;

#endif

#ifndef DEFINED_TYPEDEF_FOR_struct_8LnTg2HasR61N4e63tMdJ_
#define DEFINED_TYPEDEF_FOR_struct_8LnTg2HasR61N4e63tMdJ_

typedef struct {
  struct_vHPMdAr9HfDgWNbG6U3SfC curr;
  struct_nZqFUEOh71pPhzsMP64FWD enc;
  struct_t4jfYKvXkqvqbOrnXV9flF pot1;
} struct_8LnTg2HasR61N4e63tMdJ;

#endif

#ifndef DEFINED_TYPEDEF_FOR_struct_xYTLf9xRBpYnquzooZvpnD_
#define DEFINED_TYPEDEF_FOR_struct_xYTLf9xRBpYnquzooZvpnD_

typedef struct {
  real_T Kp;
  real_T Ki;
} struct_xYTLf9xRBpYnquzooZvpnD;

#endif

#ifndef DEFINED_TYPEDEF_FOR_struct_vJJjEYOykwYuBPVflT2NUH_
#define DEFINED_TYPEDEF_FOR_struct_vJJjEYOykwYuBPVflT2NUH_

typedef struct {
  real_T Tw;
  real_T en;
} struct_vJJjEYOykwYuBPVflT2NUH;

#endif

#ifndef DEFINED_TYPEDEF_FOR_struct_tOQDypDRbFi5SWlJtRB3OB_
#define DEFINED_TYPEDEF_FOR_struct_tOQDypDRbFi5SWlJtRB3OB_

typedef struct {
  real_T Ts;
  real_T q;
  real_T V;
} struct_tOQDypDRbFi5SWlJtRB3OB;

#endif

/* Parameters (default storage) */
typedef struct P_motor1_T_ P_motor1_T;

/* Forward declaration for rtModel */
typedef struct tag_RTM_motor1_T RT_MODEL_motor1_T;

#endif                                 /* RTW_HEADER_motor1_types_h_ */
