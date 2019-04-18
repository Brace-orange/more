'# MWS Version: Version 2015.0 - Jan 16 2015 - ACIS 24.0.2 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 50 fmax = 70
'# created = '[VERSION]2015.0|24.0.2|20150116[/VERSION]


'@ use template: withAR

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
'set the units
With Units
    .Geometry "mm"
    .Frequency "GHz"
    .Voltage "V"
    .Resistance "Ohm"
    .Inductance "NanoH"
    .TemperatureUnit  "Kelvin"
    .Time "ns"
    .Current "A"
    .Conductance "Siemens"
    .Capacitance "PikoF"
End With
'----------------------------------------------------------------------------
Plot.DrawBox True
With Background
     .Type "Normal"
     .Epsilon "1.0"
     .Mue "1.0"
     .XminSpace "0.0"
     .XmaxSpace "0.0"
     .YminSpace "0.0"
     .YmaxSpace "0.0"
     .ZminSpace "0.0"
     .ZmaxSpace "0.0"
End With
With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
End With
' switch on FD-TET setting for accurate farfields
FDSolver.ExtrudeOpenBC "True"
Mesh.FPBAAvoidNonRegUnite "True"
Mesh.ConsiderSpaceForLowerMeshLimit "False"
Mesh.MinimumStepNumber "5"
With MeshSettings
     .SetMeshType "Hex"
     .Set "RatioLimitGeometry", "20"
End With
With MeshSettings
     .SetMeshType "HexTLM"
     .Set "RatioLimitGeometry", "20"
End With
PostProcess1D.ActivateOperation "vswr", "true"
PostProcess1D.ActivateOperation "yz-matrices", "true"
'----------------------------------------------------------------------------
'set the frequency range
Solver.FrequencyRange "50", "70"
Dim sDefineAt As String
sDefineAt = "50;60;70"
Dim sDefineAtName As String
sDefineAtName = "50;60;70"
Dim sDefineAtToken As String
sDefineAtToken = "f="
Dim aFreq() As String
aFreq = Split(sDefineAt, ";")
Dim aNames() As String
aNames = Split(sDefineAtName, ";")
Dim nIndex As Integer
For nIndex = LBound(aFreq) To UBound(aFreq)
Dim zz_val As String
zz_val = aFreq (nIndex)
Dim zz_name As String
zz_name = sDefineAtToken & aNames (nIndex)
' Define E-Field Monitors
With Monitor
    .Reset
    .Name "e-field ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Efield"
    .Frequency zz_val
    .Create
End With
' Define H-Field Monitors
With Monitor
    .Reset
    .Name "h-field ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Hfield"
    .Frequency zz_val
    .Create
End With
' Define Power flow Monitors
With Monitor
    .Reset
    .Name "power ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Powerflow"
    .Frequency zz_val
    .Create
End With
' Define Power loss Monitors
With Monitor
    .Reset
    .Name "loss ("& zz_name &")"
    .Dimension "Volume"
    .Domain "Frequency"
    .FieldType "Powerloss"
    .Frequency zz_val
    .Create
End With
' Define Farfield Monitors
With Monitor
    .Reset
    .Name "farfield ("& zz_name &")"
    .Domain "Frequency"
    .FieldType "Farfield"
    .Frequency zz_val
    .ExportFarfieldSource "False"
    .Create
End With
Next
'----------------------------------------------------------------------------
With MeshSettings
     .SetMeshType "Hex"
     .Set "Version", 1%
End With
With Mesh
     .MeshType "PBA"
End With
'set the solver type
ChangeSolverType("HF Time Domain")

'@ define material: material1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Material 
     .Reset 
     .Name "material1"
     .Folder ""
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "Kelvin"
     .Epsilon "2.9"
     .Mue "1"
     .Sigma "0"
     .TanD "0.01"
     .TanDFreq "60"
     .TanDGiven "True"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "False"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .EnableUserConstTanDModelOrderMue "False"
     .ConstTanDModelOrderMue "1"
     .SetMagParametricConductivity "False"
     .DispModelEps "None"
     .DispModelMue "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMue "Nth Order"
     .MaximalOrderNthModelFitMue "10"
     .ErrorLimitNthModelFitMue "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMue "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMue "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Rho "0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .HeatCapacity "0"
     .MetabolicRate "0"
     .BloodFlow "0"
     .VoxelConvection "0"
     .MechanicsType "Unused"
     .Colour "1", "1", "0" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ new component: component1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Component.New "component1"

'@ define brick: component1:withAR

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "withAR" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "0", "1*x" 
     .Yrange "0", "1*x" 
     .Zrange "0", "center0" 
     .Create
End With

'@ define material: hole

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Material 
     .Reset 
     .Name "hole"
     .Folder ""
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "Kelvin"
     .Epsilon "1.7"
     .Mue "1"
     .Sigma "0"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstTanD"
     .EnableUserConstTanDModelOrderEps "False"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .EnableUserConstTanDModelOrderMue "False"
     .ConstTanDModelOrderMue "1"
     .SetMagParametricConductivity "False"
     .DispModelEps  "None"
     .DispModelMue "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMue "Nth Order"
     .MaximalOrderNthModelFitMue "10"
     .ErrorLimitNthModelFitMue "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMue "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMue "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Rho "0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .HeatCapacity "0"
     .MetabolicRate "0"
     .BloodFlow "0"
     .VoxelConvection "0"
     .MechanicsType "Unused"
     .Colour "0.752941", "0.752941", "0.752941" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ define brick: component1:hole

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "hole" 
     .Component "component1" 
     .Material "hole" 
     .Xrange "(x-m)/2", "(x-m)/2+m" 
     .Yrange "(x-m)/2", "(x-m)/2+m" 
     .Zrange "center0-n", "center0" 
     .Create
End With

'@ transform: translate component1:hole

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:hole" 
     .Vector "0", "0", "4" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ delete shape: component1:hole_1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Delete "component1:hole_1"

'@ define brick: component1:solid1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "hole" 
     .Xrange "(x-m)/2", "(x-m)/2+m" 
     .Yrange "(x-m)/2", "(x-m)/2+m" 
     .Zrange "0", "n" 
     .Create
End With

'@ pick face

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Pick.PickFaceFromId "component1:withAR", "1"

'@ define port: 1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "0", "2.5" 
     .Yrange "0", "2.5" 
     .Zrange "8", "8" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .Create 
End With

'@ pick face

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Pick.PickFaceFromId "component1:withAR", "2"

'@ define port: 2

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Port 
     .Reset 
     .PortNumber "2" 
     .Label "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "0", "2.5" 
     .Yrange "0", "2.5" 
     .Zrange "0", "0" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .Create 
End With

'@ define time domain solver parameters

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-30.0"
     .MeshAdaption "False"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ change solver type

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
ChangeSolverType "HF Time Domain"

'@ define time domain solver parameters

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Mesh.SetCreator "High Frequency" 
With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "1"
     .SteadyStateLimit "-30.0"
     .MeshAdaption "False"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ deactivate fast model update

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.FastModelUpdate "False"

'@ set parametersweep options

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With ParameterSweep
    .SetSimulationType "Transient" 
End With

'@ add parsweep sequence: Sequence 1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 1" 
End With

'@ add parsweep parameter: Sequence 1:length

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 1", "length", "1", "13", "6", "False" 
End With

'@ edit parsweep parameter: Sequence 1:length

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "length" 
     .AddParameter_Samples "Sequence 1", "length", "1", "13", "6", "False" 
End With

'@ delete parsweep parameter: Sequence 1:length

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 1", "length" 
End With

'@ add parsweep sequence: Sequence 2

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With ParameterSweep
     .AddSequence "Sequence 2" 
End With

'@ add parsweep parameter: Sequence 2:length

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With ParameterSweep
     .AddParameter_Samples "Sequence 2", "length", "1", "13", "6", "False" 
End With

'@ set parsweep options

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With ParameterSweep
     .ResetOptions
     .SetOptionResetParameterValuesAfterRun "False" 
     .SetOptionSkipExistingCombinations "False" 
     .SaveOptions
End With

'@ edit parsweep parameter: Sequence 2:length

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With ParameterSweep
     .DeleteParameter "Sequence 2", "length" 
     .AddParameter_Stepwidth "Sequence 2", "length", "1", "13", "1" 
End With

'@ delete port: port1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Port.Delete "1"

'@ delete port: port2

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Port.Delete "2"

'@ boolean subtract shapes: component1:withAR, component1:solid1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Subtract "component1:withAR", "component1:solid1"

'@ boolean subtract shapes: component1:withAR, component1:hole

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Subtract "component1:withAR", "component1:hole"

'@ define boundaries

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Boundary
     .Xmin "electric" 
     .Xmax "electric" 
     .Ymin "magnetic" 
     .Ymax "magnetic" 
     .Zmin "expanded open" 
     .Zmax "expanded open" 
     .Xsymmetry "none" 
     .Ysymmetry "none" 
     .Zsymmetry "none" 
     .XminThermal "isothermal" 
     .XmaxThermal "isothermal" 
     .YminThermal "isothermal" 
     .YmaxThermal "isothermal" 
     .ZminThermal "isothermal" 
     .ZmaxThermal "isothermal" 
     .XsymmetryThermal "none" 
     .YsymmetryThermal "none" 
     .ZsymmetryThermal "none" 
     .ApplyInAllDirections "False" 
     .ApplyInAllDirectionsThermal "False" 
     .XminTemperature "" 
     .XminTemperatureType "None" 
     .XmaxTemperature "" 
     .XmaxTemperatureType "None" 
     .YminTemperature "" 
     .YminTemperatureType "None" 
     .YmaxTemperature "" 
     .YmaxTemperatureType "None" 
     .ZminTemperature "" 
     .ZminTemperatureType "None" 
     .ZmaxTemperature "" 
     .ZmaxTemperatureType "None" 
End With

'@ define pml specials

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Boundary
     .ReflectionLevel "0.0001" 
     .MinimumDistanceType "Fraction" 
     .MinimumDistancePerWavelengthNewMeshEngine "4" 
     .MinimumDistanceReferenceFrequencyType "Center" 
     .FrequencyForMinimumDistance "60" 
     .SetAbsoluteDistance "0.0" 
End With

'@ define boundaries

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Boundary
     .Xmin "electric" 
     .Xmax "electric" 
     .Ymin "magnetic" 
     .Ymax "magnetic" 
     .Zmin "expanded open" 
     .Zmax "expanded open" 
     .Xsymmetry "none" 
     .Ysymmetry "none" 
     .Zsymmetry "none" 
     .XminThermal "isothermal" 
     .XmaxThermal "isothermal" 
     .YminThermal "isothermal" 
     .YmaxThermal "isothermal" 
     .ZminThermal "isothermal" 
     .ZmaxThermal "isothermal" 
     .XsymmetryThermal "none" 
     .YsymmetryThermal "none" 
     .ZsymmetryThermal "none" 
     .ApplyInAllDirections "False" 
     .ApplyInAllDirectionsThermal "False" 
     .XminTemperature "" 
     .XminTemperatureType "None" 
     .XmaxTemperature "" 
     .XmaxTemperatureType "None" 
     .YminTemperature "" 
     .YminTemperatureType "None" 
     .YmaxTemperature "" 
     .YmaxTemperatureType "None" 
     .ZminTemperature "" 
     .ZminTemperatureType "None" 
     .ZmaxTemperature "" 
     .ZmaxTemperatureType "None" 
End With

'@ define pml specials

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Boundary
     .ReflectionLevel "0.0001" 
     .MinimumDistanceType "Fraction" 
     .MinimumDistancePerWavelengthNewMeshEngine "4" 
     .MinimumDistanceReferenceFrequencyType "Center" 
     .FrequencyForMinimumDistance "60" 
     .SetAbsoluteDistance "0.0" 
End With

'@ define background

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Background 
     .ResetBackground 
     .XminSpace "0.0" 
     .XmaxSpace "0.0" 
     .YminSpace "0.0" 
     .YmaxSpace "0.0" 
     .ZminSpace "0.0" 
     .ZmaxSpace "0.0" 
     .ApplyInAllDirections "False" 
End With 
With Material 
     .Reset 
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "Hz"
     .MaterialUnit "Geometry", "m"
     .MaterialUnit "Time", "s"
     .MaterialUnit "Temperature", "Kelvin"
     .Epsilon "1.0"
     .Mue "1.0"
     .Sigma "0.0"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstSigma"
     .EnableUserConstTanDModelOrderEps "False"
     .ConstTanDModelOrderEps "1"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstSigma"
     .EnableUserConstTanDModelOrderMue "False"
     .ConstTanDModelOrderMue "1"
     .SetMagParametricConductivity "False"
     .DispModelEps  "None"
     .DispModelMue "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMue "Nth Order"
     .MaximalOrderNthModelFitMue "10"
     .ErrorLimitNthModelFitMue "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMue "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMue "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0.0"
     .HeatCapacity "0.0"
     .MetabolicRate "0"
     .BloodFlow "0"
     .VoxelConvection "0"
     .MechanicsType "Unused"
     .Colour "0.6", "0.6", "0.6" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .ChangeBackgroundMaterial
End With

'@ rename block: component1:withAR to: component1:center

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Rename "component1:withAR", "center"

'@ define brick: component1:solid1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "x", "2*x" 
     .Yrange "0", "x" 
     .Zrange "0", "r1" 
     .Create
End With

'@ define brick: component1:solid2

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "hole" 
     .Xrange "x+(x-m)/2", "x+(x-m)/2+m" 
     .Yrange "(x-m)/2", "(x-m)/2+m" 
     .Zrange "r1-n", "r1" 
     .Create
End With

'@ boolean subtract shapes: component1:solid1, component1:solid2

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Subtract "component1:solid1", "component1:solid2"

'@ define brick: component1:solid2

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "x+(x-m)/2", "x+(x-m)/2+m" 
     .Yrange "(x-m)/2", "(x-m)/2+m" 
     .Zrange "0", "n" 
     .Create
End With

'@ boolean subtract shapes: component1:solid1, component1:solid2

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Subtract "component1:solid1", "component1:solid2"

'@ define brick: component1:solid2

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "2*x", "3*x" 
     .Yrange "0", "x" 
     .Zrange "0", "r2" 
     .Create
End With

'@ define brick: component1:solid3

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid3" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "5.3", "6.2" 
     .Yrange "0.3", "2.1" 
     .Zrange "0", "0.95" 
     .Create
End With

'@ define brick: component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid4" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "2*x+(x-m)/2", "2*x+(x-m)/2+m" 
     .Yrange "(x-m)/2", "(x-m)/2+m" 
     .Zrange "0", "n" 
     .Create
End With

'@ delete shape: component1:solid3

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Delete "component1:solid3"

'@ boolean subtract shapes: component1:solid2, component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Subtract "component1:solid2", "component1:solid4"

'@ define brick: component1:solid3

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid3" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "2*x+ab", "2*x+ab+m" 
     .Yrange "ab", "ab+m" 
     .Zrange "r2-n", "r2" 
     .Create
End With

'@ boolean subtract shapes: component1:solid2, component1:solid3

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Subtract "component1:solid2", "component1:solid3"

'@ transform: translate component1:solid1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid1" 
     .Vector "-5", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid2

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid2" 
     .Vector "-10", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid1" 
     .Vector "-2.5", "-2.5", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid1_1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid1_1" 
     .Vector "2.5", "2.5", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid2

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid2" 
     .Vector "-5", "5", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid2

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid2" 
     .Vector "-5", "-5", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ define brick: component1:solid3

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid3" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "x", "2*x" 
     .Yrange "x", "x*2" 
     .Zrange "0", "r3" 
     .Create
End With

'@ define brick: component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid4" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "x+ab", "x+ab+m" 
     .Yrange "x+ab", "x+ab+m" 
     .Zrange "0", "n" 
     .Create
End With

'@ boolean subtract shapes: component1:solid3, component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Subtract "component1:solid3", "component1:solid4"

'@ define brick: component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid4" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "x+ab", "x+ab+m" 
     .Yrange "x+ab", "x+ab+m" 
     .Zrange "r3-n", "r3" 
     .Create
End With

'@ boolean subtract shapes: component1:solid3, component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Subtract "component1:solid3", "component1:solid4"

'@ transform: translate component1:solid3

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid3" 
     .Vector "0", "-5", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid3

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid3" 
     .Vector "-5", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid3

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid3" 
     .Vector "-5", "-5", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ define brick: component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid4" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "2*x", "3*x" 
     .Yrange "x", "2*x" 
     .Zrange "0", "r4" 
     .Create
End With

'@ define brick: component1:solid5

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid5" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "2*x+ab", "2*x+ab+m" 
     .Yrange "x+ab", "x+ab+m" 
     .Zrange "0", "n" 
     .Create
End With

'@ boolean subtract shapes: component1:solid4, component1:solid5

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Subtract "component1:solid4", "component1:solid5"

'@ define brick: component1:solid5

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid5" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "2*x+ab", "2*x+ab+m" 
     .Yrange "x+ab", "x+ab+m" 
     .Zrange "r4-n", "r4" 
     .Create
End With

'@ boolean subtract shapes: component1:solid4, component1:solid5

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Subtract "component1:solid4", "component1:solid5"

'@ transform: translate component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid4" 
     .Vector "0", "-5", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid4" 
     .Vector "-10", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid4" 
     .Vector "-10", "-5", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid4" 
     .Vector "-2.5", "2.6", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid4_4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid4_4" 
     .Vector "-5", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ delete shape: component1:solid4_4_1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Delete "component1:solid4_4_1"

'@ delete shape: component1:solid4_4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Delete "component1:solid4_4"

'@ transform: translate component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid4" 
     .Vector "-2.5", "2.5", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid4" 
     .Vector "-7.5", "2.5", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid4" 
     .Vector "-2.5", "-7.5", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid4

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid4" 
     .Vector "-7.5", "-7.5", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ define brick: component1:solid5

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid5" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "2*x", "3*x" 
     .Yrange "2*x", "3*x" 
     .Zrange "0", "r5" 
     .Create
End With

'@ define brick: component1:solid6

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid6" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "2*x+ab", "2*x+ab+m" 
     .Yrange "2*x+ab", "2*x+ab+m" 
     .Zrange "0", "n" 
     .Create
End With

'@ boolean subtract shapes: component1:solid5, component1:solid6

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Subtract "component1:solid5", "component1:solid6"

'@ define brick: component1:solid6

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid6" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "2*x+ab", "2*x+ab+m" 
     .Yrange "2*x+ab", "2*x+ab+m" 
     .Zrange "r5-n", "r5" 
     .Create
End With

'@ boolean subtract shapes: component1:solid5, component1:solid6

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Subtract "component1:solid5", "component1:solid6"

'@ transform: translate component1:solid5

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid5" 
     .Vector "-10", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid5

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid5" 
     .Vector "10", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid5

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid5" 
     .Vector "0", "-10", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid5

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid5" 
     .Vector "10", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With

'@ transform: translate component1:solid5

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid5" 
     .Vector "0", "10", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With 

'@ define brick: component1:11

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "11" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "-0.6296", "3.1296" 
     .Yrange "0.3102", "0.3102 " 
     .Zrange "-5.25", "-8" 
     .Create
End With


'@ transform: translate component1:11

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:11" 
     .Vector "0", "1.8796", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With 


'@ define brick: component1:solid6

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Brick
     .Reset 
     .Name "solid6" 
     .Component "component1" 
     .Material "PEC" 
     .Xrange "-0.6296", "-0.6296" 
     .Yrange "0.3102", "0.3102 + 1.8796" 
     .Zrange "-5.25", "-8" 
     .Create
End With


'@ transform: translate component1:solid6

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Transform 
     .Reset 
     .Name "component1:solid6" 
     .Vector "3.7592", "0", "0" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "True" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Destination "" 
     .Material "" 
     .Transform "Shape", "Translate" 
End With 


'@ boolean add shapes: component1:11, component1:11_1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Add "component1:11", "component1:11_1" 


'@ boolean add shapes: component1:11, component1:solid6

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Add "component1:11", "component1:solid6" 


'@ boolean add shapes: component1:11, component1:solid6_1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Solid.Add "component1:11", "component1:solid6_1" 


'@ pick edge

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Pick.PickEdgeFromId "component1:11", "12", "12" 


'@ pick edge

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Pick.PickEdgeFromId "component1:11", "1", "16" 


'@ pick edge

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Pick.PickEdgeFromId "component1:11", "16", "16" 


'@ pick edge

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Pick.PickEdgeFromId "component1:11", "5", "13" 


'@ define port: 1

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label "" 
     .NumberOfModes "1" 
     .AdjustPolarization "False" 
     .PolarizationAngle "0.0" 
     .ReferencePlaneDistance "0" 
     .TextSize "50" 
     .Coordinates "Picks" 
     .Orientation "positive" 
     .PortOnBound "False" 
     .ClipPickedPortToBound "False" 
     .Xrange "-0.6296", "3.1296" 
     .Yrange "0.3102", "2.1898" 
     .Zrange "-8", "-8" 
     .XrangeAdd "0.0", "0.0" 
     .YrangeAdd "0.0", "0.0" 
     .ZrangeAdd "0.0", "0.0" 
     .SingleEnded "False" 
     .Create 
End With 


'@ change solver type

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
ChangeSolverType "HF Frequency Domain" 


'@ define frequency domain solver parameters

'[VERSION]2015.0|24.0.2|20150116[/VERSION]
Mesh.SetCreator "High Frequency" 

With FDSolver
     .Reset 
     .SetMethod "Tetrahedral", "General purpose" 
     .OrderTet "Second" 
     .OrderSrf "First" 
     .Stimulation "1", "1" 
     .ResetExcitationList 
     .AutoNormImpedance "False" 
     .NormingImpedance "50" 
     .ModesOnly "False" 
     .ConsiderPortLossesTet "True" 
     .SetShieldAllPorts "False" 
     .AccuracyHex "1e-6" 
     .AccuracyTet "1e-4" 
     .AccuracySrf "1e-3" 
     .LimitIterations "False" 
     .MaxIterations "0" 
     .SetCalculateExcitationsInParallel "True", "False", "" 
     .StoreAllResults "False" 
     .StoreResultsInCache "False" 
     .UseHelmholtzEquation "True" 
     .LowFrequencyStabilization "True" 
     .Type "Auto" 
     .MeshAdaptionHex "False" 
     .MeshAdaptionTet "True" 
     .AcceleratedRestart "True" 
     .FreqDistAdaptMode "Distributed" 
     .NewIterativeSolver "True" 
     .TDCompatibleMaterials "False" 
     .ExtrudeOpenBC "True" 
     .SetOpenBCTypeHex "Default" 
     .SetOpenBCTypeTet "Default" 
     .AddMonitorSamples "True" 
     .CalcStatBField "False" 
     .CalcPowerLoss "True" 
     .CalcPowerLossPerComponent "False" 
     .StoreSolutionCoefficients "True" 
     .UseDoublePrecision "False" 
     .UseDoublePrecision_ML "True" 
     .MixedOrderSrf "False" 
     .MixedOrderTet "False" 
     .PreconditionerAccuracyIntEq "0.15" 
     .MLFMMAccuracy "Default" 
     .MinMLFMMBoxSize "0.20" 
     .UseCFIEForCPECIntEq "true" 
     .UseFastRCSSweepIntEq "false" 
     .UseSensitivityAnalysis "False" 
     .SweepErrorThreshold "True", "0.01" 
     .SweepErrorChecks "2" 
     .SweepMinimumSamples "3" 
     .SweepConsiderAll "True" 
     .SweepConsiderReset 
     .SetNumberOfResultDataSamples "1001" 
     .SweepWeightEvanescent "1.0" 
     .AccuracyROM "1e-4" 
     .AddSampleInterval "", "", "1", "Automatic", "True" 
     .AddSampleInterval "", "", "", "Automatic", "False" 
     .MPIParallelization "False"
     .UseDistributedComputing "False"
     .NetworkComputingStrategy "RunRemote"
     .NetworkComputingJobCount "3"
     .LimitCPUs "True"
     .MaxCPUs "48"
End With

With IESolver
     .Reset 
     .UseFastFrequencySweep "True" 
     .UseIEGroundPlane "False" 
     .SetRealGroundMaterialName "" 
     .PreconditionerType "Auto" 
End With

With IESolver
     .SetFMMFFCalcStopLevel "0" 
     .SetFMMFFCalcNumInterpPoints "6" 
     .UseFMMFarfieldCalc "True" 
     .SetCFIEAlpha "0.500000" 
     .LowFrequencyStabilization "False" 
     .LowFrequencyStabilizationML "True" 
     .Multilayer "False" 
     .SetiMoMACC_I "0.0001" 
     .SetiMoMACC_M "0.0001" 
     .DeembedExternalPorts "True" 
     .SetOpenBC_XY "True" 
     .OldRCSSweepDefintion "False" 
     .SetAccuracySetting "Custom" 
     .CalculateSParaforFieldsources "True" 
End With


