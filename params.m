clear all;
clc;
close all;

goal_x = 1000;
m = 1;
M = 10 + m;
l = 0.2;
I = m * l^2;
L = (I + m*l^2) / m / l;
g = 9.86;


model = "Wagon";

what_now = 1;

for what_now = 1:4

count = 1;

if what_now == 1

kp_1_arr = [0.5, 1, 2];
kd_1_arr = [5];
kp_2_arr = [15];
kd_2_arr = [17];

elseif what_now == 2

kp_1_arr = [1];
kd_1_arr = [2, 3, 5];
kp_2_arr = [15];
kd_2_arr = [17];

elseif what_now == 3

kp_1_arr = [1];
kd_1_arr = [5];
kp_2_arr = [2, 7, 15];
kd_2_arr = [17];

else

kp_1_arr = [1];
kd_1_arr = [5];
kp_2_arr = [15];
kd_2_arr = [3, 8, 17];

end

leg_kp_1 = [];
leg_kd_1 = [];
leg_kp_2 = [];
leg_kd_2 = [];

for kp_1 = kp_1_arr
   for kd_1 = kd_1_arr
       for kp_2 = kp_2_arr
           for kd_2 = kd_2_arr

               leg_kp_1(end + 1) = kp_1;
               leg_kd_1(end + 1) = kd_1;
               leg_kp_2(end + 1) = kp_2;
               leg_kd_2(end + 1) = kd_2;

               open_system(model);
               simIn = Simulink.SimulationInput(model);
               out = sim(simIn);

               theta = out.theta.Data;
               x = out.x.Data;
               time = out.x.Time;


               figure(1)
               plot(time, x)
               hold on;
               
               xlabel("time, с")
               ylabel("x, м")

               title("График положения тележки")

               if count == 3
                    grid on;
                    grid minor;

                   legend("kp = " + num2str(leg_kp_1(1)) + " kd = " + num2str(leg_kd_1(1)), ...
                       "kp = " + num2str(leg_kp_1(2)) + " kd = " + num2str(leg_kd_1(2)), ...
                       "kp = " + num2str(leg_kp_1(3)) + " kd = " + num2str(leg_kd_1(3)))

                   saveas(gcf, "График положения тележки_" + num2str(what_now) + ".png")
               end


               figure(2)
               plot(time, theta)
               hold on;
               grid on;
               grid minor;

               xlabel("time, с")
               ylabel("{\theta}, рад/с")

               title("График отклонения маятника от положения равновесия")

               if count == 3
                    grid on;
                    grid minor;

                   legend("kp = " + num2str(leg_kp_2(1)) + " kd = " + num2str(leg_kd_2(1)), ...
                       "kp = " + num2str(leg_kp_2(2)) + " kd = " + num2str(leg_kd_2(2)), ...
                       "kp = " + num2str(leg_kp_2(3)) + " kd = " + num2str(leg_kd_2(3)))

                   saveas(gcf, "График отклонения маятника от положения равновесия_" + num2str(what_now) + ".png")
               end

               count = count + 1;

           end
       end
   end 
end

close all;
count = 1;

leg_kp_1 = [];
leg_kd_1 = [];
leg_kp_2 = [];
leg_kd_2 = [];

end