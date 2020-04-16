M1 = 10;
M2 = 20;
Ks = 40;
A = [ 0 1 0 0; 0 0 1 0; 0 0 0 1;0 0 (-Ks* (M1+M2)/M1*M2) 0]
B = [0 0; 0 0; 0 0; 1/M1 Ks/(M1*M2)]
C = [1 0 0 0]
D = [0]
Sistem=ss(A,B,C,D)
% Sistem simulasyonu
step(Sistem)
%Sistemin modelini buraya çizmen laz?m.

%%SYSTEM L?NEAR?ZED OUTPUT W?TH KALMAN
model = sim('KALMAN1.slx')
figure()
out = model.out
plot(out)
title('System Output for step function')

%% REGULAT?ON SYSTEM:
Q =1* eye(4);
R = 1;
K = lqr(Sistem,1,1)
Am = Sistem.A
Bm = Sistem.B
Cm = Sistem.C
Dm = Sistem.D
%% Kapal? çevrim ile regulasyon
%To make our system short we made our system like A =Am-Bm*K 
% B=0 C=Am-Bm*K D=0
% Otherwise it take a lot of time
G= ss(Am-Bm*K , zeros(size(Bm)) ,Cm-Dm*K ,zeros(size(Dm)));
initial(G,[5 5 5 5])
ylabel('Location')
xlabel('t(s)')
title('closed loop lqr regulator result in script')
model = sim('REGULATORSYSTEM')
regulatorsystemout = model.Yout;
figure()
plot(regulatorsystemout)
title('close loop lqr REGULATOR result in simulink')
