TITLE Brain module for CPG dynamics with feedback

NEURON {
    SUFFIX braina
    POINTER L1Pointer, L2Pointer
    RANGE gfb,gsyn
}


PARAMETER {
    Iapp = 0.8
    Vk = -80 
    Vl = -50 
    Vca = 100 
    gk = 0.02
    gl = 0.005
    gca = 0.015
    c = 1

    E1 = 0
    E2 = 15
    E3 = 0
    E4 = 15
    Eslope = 2
    phi = 0.0005
    Esyn = -80
    :Conductance
    gsyn = 0.005  
    gfb = 0.001  


    Ethresh = 15
  
    
    Efb = -80

    L0 = 10
    Lslope = 1
    t0=0
    tF=6110
}

ASSIGNED {
    L1Pointer L2Pointer 
    minf1 minf2 winf1 winf2 tauw1 tauw2
    sinffw1 sinffw2 sinffb1 sinffb2
    Isyn1 Isyn2 Ifb1 Ifb2
}

STATE { V1 V2 N1 N2 }

INITIAL {
    V1 = 15.0000
    V2 = 19.8248
    N1 = 0.3010
    N2 = 0.7832
}

BREAKPOINT {
    SOLVE states METHOD derivimplicit
}

DERIVATIVE states {
    : Compute activation and inactivation functions for the CPG
    minf1 = 0.5*(1 + tanh((V1 - E1)/E2))
    minf2 = 0.5*(1 + tanh((V2 - E1)/E2))
    winf1 = 0.5*(1 + tanh((V1 - E3)/E4))
    winf2 = 0.5*(1 + tanh((V2 - E3)/E4))
    tauw1 = 1/cosh((V1 - E3)/(2*E4))
    tauw2 = 1/cosh((V2 - E3)/(2*E4))
    
    : Synaptic functions for feedforward excitation
    sinffw1 = 0.5*(1 + tanh((V1 - Ethresh)/Eslope))
    sinffw2 = 0.5*(1 + tanh((V2 - Ethresh)/Eslope))
    
    : Feedback functions computed from muscle lengths provided via pointers
    sinffb1 = 0.5*(1 - tanh((L1Pointer - L0)/Lslope))
    sinffb2 = 0.5*(1 - tanh((L2Pointer - L0)/Lslope))
    
    : Synaptic currents (chemical synapses and feedback)
    Isyn1 = gsyn * sinffw2 * (V1 - Esyn)
    Isyn2 = gsyn * sinffw1 * (V2 - Esyn)
    Ifb1  = gfb * sinffb2 * (V1 - Efb)
    Ifb2  = gfb * sinffb1 * (V2 - Efb)
    
    : Differential equations for neural dynamics
    V1' = (Iapp - gca*minf1*(V1 - Vca) - gk*N1*(V1 - Vk) - gl*(V1 - Vl) - Isyn1 - Ifb1)/c
    V2' = (Iapp - gca*minf2*(V2 - Vca) - gk*N2*(V2 - Vk) - gl*(V2 - Vl) - Isyn2 - Ifb2)/c
    N1' = phi*(winf1 - N1)/tauw1
    N2' = phi*(winf2 - N2)/tauw2
}
