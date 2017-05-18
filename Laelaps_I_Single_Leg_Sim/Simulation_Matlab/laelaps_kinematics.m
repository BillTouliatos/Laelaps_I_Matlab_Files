% This script takes as inputs the 2 motor angles and plots the leg

clear all
figure(1)

% leg parameters
l1 = 0.25; 
d1 = 0.315; 
d2 = 0.035;
d3 = 0.04;
d5 = 0.08;
count_no = 2000;
gear_ratio_hip = 637/12;
gear_ratio_knee = 343/8;
belt_ratio = 1.846153846;

% virtual leg parameters
l2 = sqrt(d1^2+d2^2);
th2_offset = atan2(d2,l2);

% encoder measurements
pos1 = 0;
pos2 = 0;

% angles measured
% enc2th1 = pos1 *2*pi / (count_no*gear_ratio_hip * belt_ratio);
% enc2th2 = pos2 *2*pi / (count_no*gear_ratio_knee * belt_ratio);
enc2th1 = deg2rad(-30);
enc2th2 = deg2rad(30);
%enc2th2 = th2_offset;


% convert to virtual leg angles
th1_virtual = enc2th1;
th2_virtual = enc2th2 - th2_offset;

% real foot
x_1_temp = l1 * cos(enc2th1) + d2 * cos(enc2th2-deg2rad(90));
y_1_temp = l1 * sin(enc2th1) + d2 * sin(enc2th2-deg2rad(90));
x_2_temp = d3 * cos(enc2th2);
y_2_temp = d3 * sin(enc2th2);
x_3_temp = l1 * cos(enc2th1) + d3 * cos(enc2th2);
y_3_temp = l1 * sin(enc2th1) + d3 * sin(enc2th2);
x_4_temp = l1 * cos(enc2th1) + d3 * cos(enc2th2)+ d2 * cos(enc2th2-deg2rad(90));
y_4_temp = l1 * sin(enc2th1) + d3 * sin(enc2th2)+ d2 * sin(enc2th2-deg2rad(90));
x_5_temp = x_4_temp - d5 * cos(enc2th2);
y_5_temp = y_4_temp - d5 * sin(enc2th2);

% convert to the classic CS
x_1 = y_1_temp;
y_1 = -x_1_temp;
x_2 = y_2_temp;
y_2 = -x_2_temp;
x_3 = y_3_temp;
y_3 = -x_3_temp;
x_4 = y_4_temp;
y_4 = -x_4_temp;
x_5 = y_5_temp;
y_5 = -x_5_temp;



%-------------------------------------------------------------------------%
% actual trajectory
%-------------------------------------------------------------------------%
% data as measured
y_ankle1 = l1 * sin(th1_virtual);
x_ankle1 = l1 * cos(th1_virtual);
y_foot1 = l1 * sin(th1_virtual) + l2 * sin(th2_virtual);
x_foot1 = l1 * cos(th1_virtual) + l2 * cos(th2_virtual);

% convert to the classic CS
x_ankle = y_ankle1;
y_ankle = -x_ankle1;
x_foot = y_foot1;
y_foot = -x_foot1;


%FigHandle = figure('Position', [100, 100, 1049, 895]);
set(gcf,'color','w');
    

d1 = 0.2;
d2 = 0.07;
v1 = [-d1 , d2];  % up left corner
v2 = [d1 , d2];   % up right corner
v3 = [d1 , 0];  % down right corner
v4 = [-d1 , 0]; % down left corner
abcissas = [v1(1) v2(1) v3(1) v4(1)]; 
ordinates = [v1(2) v2(2) v3(2) v4(2)];
fill(abcissas, ordinates, [0.9 0.9 0.9],'EdgeColor','none');
hold on;
plot([-0.2 0.2],[0 0],'k')

    
% plot actual traj
plot(x_foot,y_foot,'LineWidth',1)

% plot real foot
%plot(x_1,y_1,'o','LineWidth',1)
%plot([x_ankle x_4],[y_ankle y_4],'k','LineWidth',4)
plot([x_ankle x_3],[y_ankle y_3],'k','LineWidth',6)
plot([x_4 x_foot],[y_4 y_foot],'k','LineWidth',5)
%plot([x_4 x_5],[y_4 y_5],'k','LineWidth',5)
plot([x_4 x_5],[y_4 y_5],'k','LineWidth',5)
plot([x_2 x_3],[y_2 y_3],'k','LineWidth',3)
plot([x_3 x_4],[y_3 y_4],'k','LineWidth',6)
plot([0 x_2],[0 y_2],'k','LineWidth',6)
    
% Plot segments
plot([0 x_ankle],[0 y_ankle],'k','LineWidth',7)
%plot([x_ankle(i) x_s2end(i)],[y_ankle(i) y_s2end(i)],'k','LineWidth',4)
%plot([x_ankle x_foot],[y_ankle y_foot],':','LineWidth',2)
%plot([x_s3start(i) x_foot(i)],[y_s3start(i) y_foot(i)],'k','LineWidth',2)

% Plot joints
plot(0,0,'ko','MarkerFaceColor','w','MarkerSize',10)
plot(x_ankle,y_ankle,'ko','MarkerFaceColor','w','MarkerSize',10)
plot(x_2,y_2,'ko','MarkerFaceColor','w','MarkerSize',10) 
plot(x_3,y_3,'ko','MarkerFaceColor','w','MarkerSize',10)
plot(x_4,y_4,'ko','MarkerFaceColor','k','MarkerSize',10)
%plot(x_5,y_5,'ko','MarkerFaceColor','k','MarkerSize',10)
%plot(x_1,y_1,'ko','MarkerFaceColor','k','MarkerSize',2) 
plot(x_foot,y_foot,'o','MarkerFaceColor','w','MarkerSize',6)   
      
   
% Axes
axis equal
axis([-0.4 +0.4 -0.6 0.1])
       

hold off
    
xlabel('x [m]')
ylabel('y [m]')
    
