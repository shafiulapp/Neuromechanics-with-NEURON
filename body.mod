NEURON {
    SUFFIX body
    POINTER V1Pointer, V2Pointer
}

PARAMETER {
 L1 L2
 tau = 2.45
 beta = 0.703
 a0 = 0.165
 g = 2
 F0 = 10
 b = 4000
 F_ell = 2
 kappa = 1
 Ethresh = 15     : threshold used to conditionally apply extra load
}

ASSIGNED {
 V1Pointer V2Pointer
 u1 u2 U1 U2 LT1 LT2
 a1 F1 a2 F2
 r
}

STATE { A1 A2 x y1 }

INITIAL {
 A1 = 0.0000
 A2 = 0.5349
 x = 2.6749
 y1 = 0
}

BREAKPOINT {
   if (V1Pointer > Ethresh) {
    r = 1
    } else {
        r = 0
    }
   SOLVE states METHOD derivimplicit
}

DERIVATIVE states {
   
    L1 = 10 + x
    L2 = 10 - x
    

    u1 = 0.5 * V1Pointer
    u2 = 0.5 * V2Pointer
    
    U1 = (1.03 - 4.31 * exp(-0.198 * u1)) * (u1 >= 8)
    U2 = (1.03 - 4.31 * exp(-0.198 * u2)) * (u2 >= 8)
    
   
    LT1 = -3 * sqrt(3) * (L1 - 1) * (L1 - 5) * (L1 - 15) / (2 * 625)
    LT2 = -3 * sqrt(3) * (L2 - 1) * (L2 - 5) * (L2 - 15) / (2 * 625)
   
    a1 = g * (A1 - a0)
    a2 = g * (A2 - a0)
    
    F1 = (F0 * a1 * LT1) * (u1 >= 8) * (a1 >= 0)
    F2 = (F0 * a2 * LT2) * (u2 >= 8) * (a2 >= 0)
    
    
    A1' = (1/tau) * ( U1 - (beta + (1 - beta)*U1)*A1 )
    A2' = (1/tau) * ( U2 - (beta + (1 - beta)*U2)*A2 )
    x' = (1/b) * (F2 - F1 + kappa * F_ell)
    
    y1' = - r * x'
}
