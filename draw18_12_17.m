%����txt
tic
data = importdata('D:\333.txt');

%��m�ļ�Ϊ�����ļ�,����ΪĳЩ����
a1 = 1;      %1��̨positionȨֵ
a2 = 1000;         %2��̨positionȨֵ
displacement = [0,0,0]; %Сλ��̨����,1��̨
base = [0,0,0];     %��λ��̨���꣬2��̨
position0 = [0,0,0];  %�ϴε�����
position1 = [0,0,0];  %���ε�����
Is_on = 0;      %����
% b1 = 1;        %��㾫��
% b2 = 1000;


%beginning
[xm,ym] = size(data);   %data��С   

if(data(1,1) == 1)
    displacement = data(1,2:4);         %1��̨
else if(data(1,1) == 2)
        base = data(1,2:4);
    end
end

if(data(1,5))       %�жϵ�һ���Ƿ�������
    Is_on = 1;
else
    Is_on = 0;
end

position1 = a1*displacement + a2*base;     %��������
x = position1(1);
y = position1(2);
z = position1(3);

%drawing
for i = 2:xm
%     %���þ���
%     if(data(i,1) == 1)
%         b = b1;
%     else if(data(i,1) == 2)
%             b = b2;
%          end
%     end
    
    %position��λ
    if(data(i,1) == 1)
        displacement = data(i,2:4);         %1��̨
    else if(data(i,1) == 2)
            base = data(i,2:4);         %2��̨
         end
    end
    position0 = position1;
    position1 = a1*displacement + a2*base;
    
    %�ж��Ƿ���������������ͼ
    draw_x = [position0(1),position1(1)];
    draw_y = [position0(2),position1(2)];
    draw_z = [position0(3),position1(3)];
    
    if(Is_on)
        plot3(draw_x,draw_y,draw_z,'b-');
        hold on;
    end
    
    %�жϿ�����־λ
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