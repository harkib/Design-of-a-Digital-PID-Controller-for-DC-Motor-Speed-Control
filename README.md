# Design-of-a-Digital-PID-Controller-for-DC-Motor-Speed-Control
In this project, the aim is design and simulation of a DC motor closed-loop control system to meet the following criteria for a 1 rad/sec step reference: 
- Settling time less than 2 seconds 
- Overshoot less than 5% 
- Steady-state error less than 1%

We will assume that the input of the system is the voltage source (V) applied to the motor's armature, while the output is the rotational speed of the shaft 𝑑𝜃/𝑑𝑡. Then, the open-loop transfer function for the DC motor is as follows:

𝜃(s)/𝑉(𝑠)=𝐾/((𝐽𝑠 + 𝑏)(𝐿𝑠 + 𝑅) + 𝐾^2)

where the physical parameters for the DC motor under consideration are:
J = 0.01 kg.m2; b = 0.1 N.m.s; K = 0.01 V/rad.sec; R = 1ohm; L = 0.5 H;