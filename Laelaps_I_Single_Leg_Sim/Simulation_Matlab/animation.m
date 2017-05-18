figure(1)
%FigHandle = figure('Position', [100, 200, 1000, 700]);
clf;

n = size(xoutE,1);

th1 = xoutE(:,1);
th2 = xoutE(:,3);
l = xoutE(:,5);


% m1 coordinates
x_m1 = d1.*sin(th1);
y_m1 = -d1*cos(th1);

% m2 coordinates
x_m2 = 2*d1.*sin(th1) + d2*sin(th2);
y_m2 = -2*d1*cos(th1) - d2*cos(th2);

% m3 coordinates
x_m3 = 2*d1.*sin(th1) + d2*sin(th2) + l.*sin(th2);
y_m3 = -2*d1*cos(th1) - d2*cos(th2) - l.*cos(th2);

% ankle coordinates
x_ankle=2*d1.*sin(th1);
y_ankle=-2*d1*cos(th1);

% segment 2 end
x_s2end = 2*d1.*sin(th1) + 2*d2*sin(th2);
y_s2end = -2*d1*cos(th1) - 2*d2*cos(th2);

% segment 3 start
x_s3start = 2*d1.*sin(th1) + d2*sin(th2) + l.*sin(th2) - d3*sin(th2);
y_s3start = -2*d1*cos(th1) - d2*cos(th2) - l.*cos(th2) + d3*cos(th2);

% foot coordinates
x_foot = 2*d1.*sin(th1) + d2*sin(th2) + l.*sin(th2) + d3*sin(th2);
y_foot = -2*d1*cos(th1) - d2*cos(th2) - l.*cos(th2) - d3*cos(th2);


% Animation Step
step = 400;


for i = 1:step:n-1

    % Plot ground
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

    % Plot segments
    plot([0 x_ankle(i)],[0 y_ankle(i)],'k','LineWidth',7)
    plot([x_ankle(i) x_s2end(i)],[y_ankle(i) y_s2end(i)],'k','LineWidth',4)
    plot([x_ankle(i) x_foot(i)],[y_ankle(i) y_foot(i)],':k','LineWidth',2)
    plot([x_s3start(i) x_foot(i)],[y_s3start(i) y_foot(i)],'k','LineWidth',2)
    
    % Plot joints
    plot(0,0,'o','MarkerFaceColor','w','MarkerSize',10)
    plot(x_ankle(i),y_ankle(i),'o','MarkerFaceColor','w','MarkerSize',10)    
    plot(x_foot(i),y_foot(i),'ko','MarkerFaceColor','w','MarkerSize',3)   
    
    % Plot CoMs (uncomment to plot)
    % plot(x_m1(i),y_m1(i),'ko','MarkerFaceColor','r')
    % plot(x_m2(i),y_m2(i),'ko','MarkerFaceColor','r')
    % plot(x_m3(i),y_m3(i),'ko','MarkerFaceColor','r')
    
    % Plot Force Vectors from the Ground
    force_scale = 20;
    quiver(x_foot(i),y_foot(i), FxE(i)/force_scale, FyE(i)/force_scale,'r')

    %-------------------------------------------------------------------------%
    % Print Time
    %-------------------------------------------------------------------------%
    x_time = -0.8;
    y_time = 0.05;

    label = num2str(toutE(i));
    text(x_time, y_time, 'Time (s):', 'Color', 'k', 'FontSize', 12,...
        'fontWeight', 'normal');
    text(x_time + 0, y_time-0.12, label, 'Color', 'k', 'FontSize', 12);
    
    
    % Axes
    axis equal
    axis([-0.9 +0.9 -0.8 0.2])
       
    drawnow
    

    
    hold off
    toutE(i)
end
% % If stop button is unpressed
% if get(stop,'value')==0
    
% Background color (in+out plot)
% whitebg([1 1 1])

% % Rotation matrix for theta
% R=[cos(thb(i)) sin(thb(i));sin(thb(i)) -cos(thb(i))];   
% 
% % Body dimensions
% d1 = 0.3;
% d2 = 0.07;
% 
% % Rectangle corners v1vectors
% v1 = [-d1 , d2];  % up left corner
% v2 = [d1 , d2];   % up right corner
% v3 = [d1 , -d2];  % down right corner
% v4 = [-d1 , -d2]; % down left corner
% 
% % Corners in global system
% v1_gl = [xb(i) , yb(i)] + v1 * R; 
% v2_gl = [xb(i) , yb(i)] + v2 * R;
% v3_gl = [xb(i) , yb(i)] + v3 * R;
% v4_gl = [xb(i) , yb(i)] + v4 * R;
% 
% % Plot body
% abcissas = [v1_gl(1) v2_gl(1) v3_gl(1) v4_gl(1)]; 
% ordinates = [v1_gl(2) v2_gl(2) v3_gl(2) v4_gl(2)];
% fill(abcissas, ordinates, 'w');
% hold on;
% 
% % % Plot body ellipse (not working)
% % tt=0:.05:2*pi; radius=0.5;
% % % abcissas = 2*radius*sin(tt)+xb(i); 
% % % ordinates = radius*cos(tt)+yb(i);
% % vector = [2*radius*sin(tt)+xb(i) , radius*cos(tt)+yb(i)];
% % fill(vector(1),vector(2),[1,1,1])
% % % fill(2*radius*sin(tt)+xb(i),radius*cos(tt)+yb(i),[1,1,1])
% 
% % Plot leg spring
% v_fore_leg_1 = [xb(i) , yb(i)];
% v_fore_leg_2 = [xf(i) , yf(i)];
% plot([v_fore_leg_1(1) v_fore_leg_2(1)],[v_fore_leg_1(2) v_fore_leg_2(2)]...
%     ,':k','LineWidth',1)
% 
% % % Plot leg upper part
% % v_fore_leg_1 = [xb(i) , yb(i)];
% % v_fore_leg_2 = [];
% % plot([v_fore_leg_1(1) v_fore_leg_2(1)],[v_fore_leg_1(2) v_fore_leg_2(2)]...
% %     ,'k','LineWidth',1)
% % 
% % % Plot leg lower part
% % v_fore_leg_1 = [xb(i) , yb(i)];
% % v_fore_leg_2 = [];
% % plot([v_fore_leg_1(1) v_fore_leg_2(1)],[v_fore_leg_1(2) v_fore_leg_2(2)]...
% %     ,'k','LineWidth',1)
% 
% 
% % Plot Force Vector from the Ground
% force_scale = 1500;
% quiver(xf(i), yf(i), ...
%     FForce(i,1)/(force_scale), NForce(i,1)/(force_scale),'r')
% 
% 
% % Plot ground
% plot([xb(i)-2 xb(i)+2],[0 0],'k','LineWidth',1)
% 
% % Moving axis
% axis([xb(i)-2 xb(i)+2 -1 3])
% axis square
% 
% hold off
% 
% % Pause between frames
% if i < length(tout)
%     pause(anim_speed*(tout(i+1) -tout(i)));
% end
% 
% % Break if Stop button is pressed
% elseif get(stop,'value')==1 
%         break
% end
% 
% 
% end
% 
% % Turn the stop button into close button
% set(stop,'style','pushbutton','string','close','callback','close(gcf)');

% end