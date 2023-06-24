    function targMap = targDataMap(),

    ;%***********************
    ;% Create Parameter Map *
    ;%***********************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 8;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc paramMap
        ;%
        paramMap.nSections           = nTotSects;
        paramMap.sectIdxOffset       = sectIdxOffset;
            paramMap.sections(nTotSects) = dumSection; %prealloc
        paramMap.nTotData            = -1;

        ;%
        ;% Auto data (motor2_P)
        ;%
            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% motor2_P.sens
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(1) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% motor2_P.dac
                    section.data(1).logicalSrcIdx = 1;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(2) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% motor2_P.step
                    section.data(1).logicalSrcIdx = 2;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(3) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% motor2_P.awu
                    section.data(1).logicalSrcIdx = 3;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(4) = section;
            clear section

            section.nData     = 1;
            section.data(1)  = dumData; %prealloc

                    ;% motor2_P.pid
                    section.data(1).logicalSrcIdx = 4;
                    section.data(1).dtTransOffset = 0;

            nTotData = nTotData + section.nData;
            paramMap.sections(5) = section;
            clear section

            section.nData     = 13;
            section.data(13)  = dumData; %prealloc

                    ;% motor2_P.degs2rpm
                    section.data(1).logicalSrcIdx = 5;
                    section.data(1).dtTransOffset = 0;

                    ;% motor2_P.dend
                    section.data(2).logicalSrcIdx = 6;
                    section.data(2).dtTransOffset = 1;

                    ;% motor2_P.numd
                    section.data(3).logicalSrcIdx = 7;
                    section.data(3).dtTransOffset = 4;

                    ;% motor2_P.rpm2rads
                    section.data(4).logicalSrcIdx = 8;
                    section.data(4).dtTransOffset = 7;

                    ;% motor2_P.AnalogOutput_FinalValue
                    section.data(5).logicalSrcIdx = 9;
                    section.data(5).dtTransOffset = 8;

                    ;% motor2_P.AnalogOutput_InitialValue
                    section.data(6).logicalSrcIdx = 10;
                    section.data(6).dtTransOffset = 9;

                    ;% motor2_P.EncoderInput_InputFilter
                    section.data(7).logicalSrcIdx = 11;
                    section.data(7).dtTransOffset = 10;

                    ;% motor2_P.EncoderInput_MaxMissedTicks
                    section.data(8).logicalSrcIdx = 12;
                    section.data(8).dtTransOffset = 11;

                    ;% motor2_P.AnalogInput_MaxMissedTicks
                    section.data(9).logicalSrcIdx = 13;
                    section.data(9).dtTransOffset = 12;

                    ;% motor2_P.AnalogOutput_MaxMissedTicks
                    section.data(10).logicalSrcIdx = 14;
                    section.data(10).dtTransOffset = 13;

                    ;% motor2_P.EncoderInput_YieldWhenWaiting
                    section.data(11).logicalSrcIdx = 15;
                    section.data(11).dtTransOffset = 14;

                    ;% motor2_P.AnalogInput_YieldWhenWaiting
                    section.data(12).logicalSrcIdx = 16;
                    section.data(12).dtTransOffset = 15;

                    ;% motor2_P.AnalogOutput_YieldWhenWaiting
                    section.data(13).logicalSrcIdx = 17;
                    section.data(13).dtTransOffset = 16;

            nTotData = nTotData + section.nData;
            paramMap.sections(6) = section;
            clear section

            section.nData     = 7;
            section.data(7)  = dumData; %prealloc

                    ;% motor2_P.EncoderInput_Channels
                    section.data(1).logicalSrcIdx = 18;
                    section.data(1).dtTransOffset = 0;

                    ;% motor2_P.AnalogInput_Channels
                    section.data(2).logicalSrcIdx = 19;
                    section.data(2).dtTransOffset = 1;

                    ;% motor2_P.AnalogOutput_Channels
                    section.data(3).logicalSrcIdx = 20;
                    section.data(3).dtTransOffset = 3;

                    ;% motor2_P.AnalogInput_RangeMode
                    section.data(4).logicalSrcIdx = 21;
                    section.data(4).dtTransOffset = 4;

                    ;% motor2_P.AnalogOutput_RangeMode
                    section.data(5).logicalSrcIdx = 22;
                    section.data(5).dtTransOffset = 5;

                    ;% motor2_P.AnalogInput_VoltRange
                    section.data(6).logicalSrcIdx = 23;
                    section.data(6).dtTransOffset = 6;

                    ;% motor2_P.AnalogOutput_VoltRange
                    section.data(7).logicalSrcIdx = 24;
                    section.data(7).dtTransOffset = 7;

            nTotData = nTotData + section.nData;
            paramMap.sections(7) = section;
            clear section

            section.nData     = 5;
            section.data(5)  = dumData; %prealloc

                    ;% motor2_P.Step_Y0
                    section.data(1).logicalSrcIdx = 25;
                    section.data(1).dtTransOffset = 0;

                    ;% motor2_P.DiscreteTransferFcn_InitialStates
                    section.data(2).logicalSrcIdx = 26;
                    section.data(2).dtTransOffset = 1;

                    ;% motor2_P.DiscreteTimeIntegrator_gainval
                    section.data(3).logicalSrcIdx = 27;
                    section.data(3).dtTransOffset = 2;

                    ;% motor2_P.DiscreteTimeIntegrator_IC
                    section.data(4).logicalSrcIdx = 28;
                    section.data(4).dtTransOffset = 3;

                    ;% motor2_P.UnitDelay_InitialCondition
                    section.data(5).logicalSrcIdx = 29;
                    section.data(5).dtTransOffset = 4;

            nTotData = nTotData + section.nData;
            paramMap.sections(8) = section;
            clear section


            ;%
            ;% Non-auto Data (parameter)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        paramMap.nTotData = nTotData;



    ;%**************************
    ;% Create Block Output Map *
    ;%**************************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 1;
        sectIdxOffset = 0;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc sigMap
        ;%
        sigMap.nSections           = nTotSects;
        sigMap.sectIdxOffset       = sectIdxOffset;
            sigMap.sections(nTotSects) = dumSection; %prealloc
        sigMap.nTotData            = -1;

        ;%
        ;% Auto data (motor2_B)
        ;%
            section.nData     = 11;
            section.data(11)  = dumData; %prealloc

                    ;% motor2_B.Step
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% motor2_B.Gain8
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 1;

                    ;% motor2_B.Gain9
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 2;

                    ;% motor2_B.Sum3
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 3;

                    ;% motor2_B.DiscreteTimeIntegrator
                    section.data(5).logicalSrcIdx = 4;
                    section.data(5).dtTransOffset = 4;

                    ;% motor2_B.Sum4
                    section.data(6).logicalSrcIdx = 5;
                    section.data(6).dtTransOffset = 5;

                    ;% motor2_B.Saturation2
                    section.data(7).logicalSrcIdx = 6;
                    section.data(7).dtTransOffset = 6;

                    ;% motor2_B.Gain1
                    section.data(8).logicalSrcIdx = 7;
                    section.data(8).dtTransOffset = 7;

                    ;% motor2_B.Gain14
                    section.data(9).logicalSrcIdx = 8;
                    section.data(9).dtTransOffset = 8;

                    ;% motor2_B.Sum5
                    section.data(10).logicalSrcIdx = 9;
                    section.data(10).dtTransOffset = 9;

                    ;% motor2_B.Sum6
                    section.data(11).logicalSrcIdx = 10;
                    section.data(11).dtTransOffset = 10;

            nTotData = nTotData + section.nData;
            sigMap.sections(1) = section;
            clear section


            ;%
            ;% Non-auto Data (signal)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        sigMap.nTotData = nTotData;



    ;%*******************
    ;% Create DWork Map *
    ;%*******************
    
        nTotData      = 0; %add to this count as we go
        nTotSects     = 2;
        sectIdxOffset = 1;

        ;%
        ;% Define dummy sections & preallocate arrays
        ;%
        dumSection.nData = -1;
        dumSection.data  = [];

        dumData.logicalSrcIdx = -1;
        dumData.dtTransOffset = -1;

        ;%
        ;% Init/prealloc dworkMap
        ;%
        dworkMap.nSections           = nTotSects;
        dworkMap.sectIdxOffset       = sectIdxOffset;
            dworkMap.sections(nTotSects) = dumSection; %prealloc
        dworkMap.nTotData            = -1;

        ;%
        ;% Auto data (motor2_DW)
        ;%
            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% motor2_DW.DiscreteTransferFcn_states
                    section.data(1).logicalSrcIdx = 0;
                    section.data(1).dtTransOffset = 0;

                    ;% motor2_DW.DiscreteTimeIntegrator_DSTATE
                    section.data(2).logicalSrcIdx = 1;
                    section.data(2).dtTransOffset = 2;

                    ;% motor2_DW.UnitDelay_DSTATE
                    section.data(3).logicalSrcIdx = 2;
                    section.data(3).dtTransOffset = 3;

                    ;% motor2_DW.DiscreteTransferFcn_tmp
                    section.data(4).logicalSrcIdx = 3;
                    section.data(4).dtTransOffset = 4;

            nTotData = nTotData + section.nData;
            dworkMap.sections(1) = section;
            clear section

            section.nData     = 4;
            section.data(4)  = dumData; %prealloc

                    ;% motor2_DW.EncoderInput_PWORK
                    section.data(1).logicalSrcIdx = 4;
                    section.data(1).dtTransOffset = 0;

                    ;% motor2_DW.AnalogInput_PWORK
                    section.data(2).logicalSrcIdx = 5;
                    section.data(2).dtTransOffset = 1;

                    ;% motor2_DW.AnalogOutput_PWORK
                    section.data(3).logicalSrcIdx = 6;
                    section.data(3).dtTransOffset = 2;

                    ;% motor2_DW.Scope_PWORK.LoggedData
                    section.data(4).logicalSrcIdx = 7;
                    section.data(4).dtTransOffset = 3;

            nTotData = nTotData + section.nData;
            dworkMap.sections(2) = section;
            clear section


            ;%
            ;% Non-auto Data (dwork)
            ;%


        ;%
        ;% Add final counts to struct.
        ;%
        dworkMap.nTotData = nTotData;



    ;%
    ;% Add individual maps to base struct.
    ;%

    targMap.paramMap  = paramMap;
    targMap.signalMap = sigMap;
    targMap.dworkMap  = dworkMap;

    ;%
    ;% Add checksums to base struct.
    ;%


    targMap.checksum0 = 3314338180;
    targMap.checksum1 = 445013070;
    targMap.checksum2 = 4022560708;
    targMap.checksum3 = 322691234;

