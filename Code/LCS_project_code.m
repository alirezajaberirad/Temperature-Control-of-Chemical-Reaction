freq=[0.01 0.02 0.1 0.2 0.5 1 2 5 10 20];
amp=[6.984 6.938 5.773 3.917 1.286 0.3498 6.781e-2 5.333e-3 6.912e-4 8.723e-5];
phase=[-0.09292 -0.18534 -0.8613 -1.4812 -2.467 -3.177 -3.778 -4.3 -4.5 -4.6];
ampdB=20*log10(amp);
phaseDeg=180/pi*phase;
close all;
s=tf('s');
subplot(2,1,1);
semilogx(freq,ampdB);
subplot(2,1,2);
semilogx(freq,phaseDeg);
G1=7/(8.3*s+1);
G2=0.3559/(s^2+0.2857*s+0.05084);
a=0.162; b=0.4; c=1.53; k=0.7;
G3=k/((s+a)*(s+b)*(s+c));
H=0.5/(s+0.5);


%% %step response of closed loop systems%
figure; step(feedback(G1,H));title('step response:G1(s)');
figure; step(feedback(G2,H));title('step response:G2(s)');
figure; step(feedback(G3,H));title('step response:G3(s)');


%% %Root Locus plot of systems%
figure; rlocus(G1/(1+(H-1)*G1));title('Root Locus:G1(s)');
figure; rlocus(G2/(1+(H-1)*G2));title('Root Locus:G2(s)');
figure; rlocus(G3/(1+(H-1)*G3));title('Root Locus:G3(s)');


%% %Bode plot of systems%
figure; bode(G1/(1+(H-1)*G1));title('Bode plot:G1(s)');
figure; bode(G2/(1+(H-1)*G2));title('Bode plot:G2(s)');
figure; bode(G3/(1+(H-1)*G3));title('Bode plot:G3(s)');

%% %Bandwidths
BW1=bandwidth(G1/(1+(H-1)*G1));
BW2=bandwidth(G2/(1+(H-1)*G2));
BW3=bandwidth(G3/(1+(H-1)*G3));

%% %PID for G1
Kp1=21.1;
Ki1=6.57;
Kd1=0;

C1=pid(Kp1,Ki1,Kd1);
step(feedback(C1*G1/(1+(H-1)*G1),1));

%% %PID for G2
Kp2=78.8;
Ki2=27.6;
Kd2=56.2;

C2=pid(Kp2,Ki2,Kd2);
step(feedback(C2*G2/(1+(H-1)*G2),1));

%% %PID for G3
Kp3=0.325;
Ki3=0.00455;
Kd3=5.82;

C3=pid(Kp3,Ki3,Kd3);
step(feedback(C3*G3/(1+(H-1)*G3),1));

%% %Root Locus plot of optimized systems%
figure; rlocus(C1*G1/(1+(H-1)*G1));title('Root Locus:G1(s)');
figure; rlocus(C2*G2/(1+(H-1)*G2));title('Root Locus:G2(s)');
figure; rlocus(C3*G3/(1+(H-1)*G3));title('Root Locus:G3(s)');

%% %Bode plot of optimized systems%
figure; bode(C1*G1/(1+(H-1)*G1));title('Bode plot:G1(s)');
figure; bode(C2*G2/(1+(H-1)*G2));title('Bode plot:G2(s)');
figure; bode(C3*G3/(1+(H-1)*G3));title('Bode plot:G3(s)');

%% %Bandwidths of optimized systems
BW1=bandwidth(C1*G1/(1+(H-1)*G1));
BW2=bandwidth(C2*G2/(1+(H-1)*G2));
BW3=bandwidth(C3*G3/(1+(H-1)*G3));
