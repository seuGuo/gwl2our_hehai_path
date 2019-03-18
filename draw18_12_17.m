%导入txt
tic
data = importdata('D:\333.txt');

%本m文件为测试文件,以下为某些参数
a1 = 1;      %1号台position权值
a2 = 1000;         %2号台position权值
displacement = [0,0,0]; %小位移台坐标,1号台
base = [0,0,0];     %大位移台坐标，2号台
position0 = [0,0,0];  %上次的坐标
position1 = [0,0,0];  %本次的坐标
Is_on = 0;      %开关
% b1 = 1;        %描点精度
% b2 = 1000;


%beginning
[xm,ym] = size(data);   %data大小   

if(data(1,1) == 1)
    displacement = data(1,2:4);         %1号台
else if(data(1,1) == 2)
        base = data(1,2:4);
    end
end

if(data(1,5))       %判断第一句是否开启激光
    Is_on = 1;
else
    Is_on = 0;
end

position1 = a1*displacement + a2*base;     %调整坐标
x = position1(1);
y = position1(2);
z = position1(3);

%drawing
for i = 2:xm
%     %设置精度
%     if(data(i,1) == 1)
%         b = b1;
%     else if(data(i,1) == 2)
%             b = b2;
%          end
%     end
    
    %position移位
    if(data(i,1) == 1)
        displacement = data(i,2:4);         %1号台
    else if(data(i,1) == 2)
            base = data(i,2:4);         %2号台
         end
    end
    position0 = position1;
    position1 = a1*displacement + a2*base;
    
    %判断是否开启，若开启，绘图
    draw_x = [position0(1),position1(1)];
    draw_y = [position0(2),position1(2)];
    draw_z = [position0(3),position1(3)];
    
    if(Is_on)
        plot3(draw_x,draw_y,draw_z,'b-');
        hold on;
    end
    
    %判断开启标志位
    if(data(i,5) == 1)
        Is_on = 1;
    else
        Is_on = 0;
    end
end

toc
%end
% plot3(x,y,z,'.');
% x=0:0.1:20;
% y=0:0.1:20;
% z=0:0.1:20;
% plot3(x, y, z, '.');