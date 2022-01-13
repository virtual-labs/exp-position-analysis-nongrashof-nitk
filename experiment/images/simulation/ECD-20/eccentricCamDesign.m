% ECCENTRIC CIRCULAR CAM SIMULATION WITH SVAJ DIAGRAM %
n=menu('SELECT YOUR OPTION ','INPUT VALUES','TAKE DEFAULT VALUES');
if(n==1)
    r=input('Enter the radius of the circle: ');
    e=input('Enter the value of eccentricity: ');
    w=input('Enter the angular velocity: ');
else
    e=5;
    r=10;
    w=300;
end
fprintf('Radius of circle : %f \n',r);
fprintf('Value of eccentricity : %f \n',e);
fprintf('Angular velocity : %f \n',w);
fprintf('\n');
f=w/(2*pi);
syms th;
a2=(0.5*pi)-th;
a1=asin(e*sin(a2)/r);
a3=pi-a1-a2;
l=sin(a3)*e/sin(a1);
s=l+10;
pos=inline(s);
v=diff(s);
vel=inline(v);
a=diff(v);
acc=inline(a);
j=diff(a);
je=inline(j);

for th=0:0.1:2*pi;
    
    % CAM SIMULATION %
    subplot(4,2,[1 3 5 7]);
    cla;
    title('SIMULATION');
    x=e*cos(th);
    y=e*sin(th);
    for th1=0:0.1:2*pi;
        plot(cos(th1),sin(th1));
    end
    hold on;
    for phi=0:0.06:2*pi;
        x1=r*cos(phi)+x;
        y1=r*sin(phi)+y;
        plot(x1,y1,'.');
    end
    a2=(0.5*pi)-th;
    a1=asin(e*sin(a2)/r);
    a3=pi-a1-a2;
    l=sin(a3)*e/sin(a1);
    line([0 0],[l l+10],'color','red','linewidth',3);
    axis([-30 30 -30 30]);
    
    % SVAJ DIAGRAM %
    
    % POSITION VS ANGLE PLOT %
    subplot(4,2,2);
    title('POSITION (S)');
    hold on
    grid on
    plot(th,pos(th),'r.');
    axis([0 2*pi -r+e 4*r+e]);  
    fprintf('Position : %f \n',pos(th));
    
    % VELOCITY VS ANGLE PLOT %
    subplot(4,2,4);
    title('VELOCITY (V)');
    hold on
    grid on
    plot(th,vel(th),'b.');
    axis([0 2*pi -r-e r+e]);
    fprintf('Velocity : %f \n',vel(th));
  
    % ACCELERATION VS ANGLE PLOT %
    subplot(4,2,6);
    title('ACCELERATION (A)');
    hold on
    grid on
    plot(th,acc(th),'g.');
    axis([0 2*pi -r-e r+e]);
    fprintf('Acceleration : %f \n',acc(th));
    fprintf('\n');
      
    % JERK VS ANGLE PLOT %
    subplot(4,2,8);
    title('JERK (J)');
    hold on
    grid on
    plot(th,je(th),'y.');
    axis([0 2*pi -r-e r+e]);
    
    pause(1/f);
end
    