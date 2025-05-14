#Read the instructions for using the codes


For reproducing the HCO model's typical solution from the paper "Zhuojun Yu and Peter J Thomas. Variational analysis of sensory feedback mechanisms
in powerstroke{recovery systems. Biological Cybernetics, 118(5):277{309, 2024.", first compile body.mod and brain.mod files , then using python code trialf.ipynb , one can reproduce the solutions. Even by loading HCO2024.ses in NEURON GUI one can also visualize the same solution.



For the following tasks:

# 1. Numerically vary gfb (the feedback conductance). Currently in brain .mod, gfb is  set to 0.001. Try varying it and see if you can get an increase in Q. Can you  find an optimum?

#2. Numerically vary gsyn (the synaptic conductance). Currently in brain.mod, gsyn is set to 0.005. Try varying it and see if you can get an increase in Q. Can you  find an optimum?

#3. See if you can improve Q by varying both gfb and gsyn. Can you  find an optimum for varying them both together?

One need to compile braina.mod and bodya.mod first using nrnivmodl , then using python code varying.ipynb , one can get the outputs for the above tasks.


Finally for the following tasks: 

#4. Since the load introduces an asymmetry between the two muscles, it might be a
plausible hypothesis that the best feedback parameters would be asymmetrical as
well. To test this, modify brain.mod so that lines 76-79 change from
Isyn1 = gsyn * sinffw2 * (V1 - Esyn)
Isyn2 = gsyn * sinffw1 * (V2 - Esyn)
Ifb1 = gfb * sinffb2 * (V1 - Efb)
Ifb2 = gfb * sinffb1 * (V2 - Efb)
to
Isyn1 = gsyn12 * sinffw2 * (V1 - Esyn)
Isyn2 = gsyn21 * sinffw1 * (V2 - Esyn)
Ifb1 = gfb12 * sinffb2 * (V1 - Efb)
Ifb2 = gfb21 * sinffb1 * (V2 - Efb)

Then try varying gsyn12 and gsyn21 separately to see if you can improve performance.

#5. Similarly, try varying gfb12 and gfb21 separately to see if you can improve performance.

#6. See if you can  nd an optimum for all four parameters at once.


One need to compile brainb.mod and bodyb.mod first using nrnivmodl , then using python code assymetric.ipynb , one can get the outputs for the above tasks.
