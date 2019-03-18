# 将nanoscribe产生的txt文件转换为河海院使用的打印格式20190318创建

## 关于命名

  .m文件命名为：功能+日期

## 1.根据河海院打印机的语法规则绘出打印路径

  文件：draw18_12_17.m

```matlab
tic
data = importdata('D:\333.txt');	%此处更换文件路径

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
    

​```
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
​```

end

toc
```



```

```

  效果

![MATLAB-1](E:\学习\顾老师\3D打印\nanoscribe\OB1x1y1_1_files\fig1.bmp)

## 2.忽略nanoscribe的初始控制字符串，只单纯地进行路径规划操作

  文件：nano2our_print19_03_15.m

```matlab
tic

%将nanoscribe生成的gwl文件转换为河海可用的txt文件
fid = fopen('E:\学习\顾老师\3D打印\nanoscribe\OB1x1y1_1_files\OB1x1y1_1_0_0_0.gwl');
str_1 = fgetl(fid);     %str_0和str_1分别代表当前行和下一行
str_char_orginal_1 = char(str_1);
str_char_1 = strtrim(str_char_orginal_1);

txt_path = 'D:\333.gwl'; %生成新的文件路径
speed = 50;
table = 1;
delete(txt_path);

while ~feof(fid)
    str_0 = str_1;
    str_1 = fgetl(fid);
    str_char_orginal_0 = str_char_orginal_1;
    str_char_0 = str_char_1;
%     str_char_orginal_0 = char(str_0);
%     str_char_0 = strtrim(str_char_orginal_0);
    str_char_orginal_1 = char(str_1);
    str_char_1 = strtrim(str_char_orginal_1);
    str_num = sscanf(str_char_0,'%f%f%f');
    

​```
%如果第一个字符是数字，放入待转换数组str中
if(~isempty(str_num))
​```

%         write_in_notes_0315_1(txt_path,1,str,speed,table);
        %查看下一个字符是不是write
        if(strcmp(str_char_1,'Write'))
            write_in_notes_0315_1(txt_path,0,str_char_0,speed,table);
            str_0 = str_1;
            str_1 = fgetl(fid);
        else
            write_in_notes_0315_1(txt_path,1,str_char_0,speed,table);
        end
    end
end

toc



  文件：write_in_notes0315_1.m

```

```matlab
function write_in_notes_0315_1(txt_path,state,str,speed,table)
%实现将新的路径写入新的txt，新txt路径为字符串txt_path,state==1为数字,state==0为write
%输入欲添加的字符串str,输出形成的路径notes_string,str为cell型,speed为移动台速度,talbe为移动台序号

%delete(txt_path);
fid = fopen(txt_path,'at');
% new_notes_string = '';
Is_laser = 0;
str_table = num2str(table);
str_speed = num2str(speed);
str_state = num2str(state);

fprintf(fid,'%s\t',str_table,'%s\t',str,'%s\t',str_state,'%s\r\n',str_speed);
% fprintf(fid,'%s\t',str);
% fprintf(fid,'%s\t',str_state);
% fprintf(fid,'%s\r\n',str_speed);

fclose(fid);

end
```



 与之前代码相比有所改进，运行时间大幅度提高，测试2M的文件转换约80s。

 改进如下：

1. 从gwl文件中逐行获取信息，不再将其拼接为一个长字符串再写文件操作，而是读取一行字符串，进行一次txt的写文件操作。因为合成长字符串的过程中字符串会不断调用自己，使得运行速度指数增长。

2. 以追加方式写文件时，只使用一个fprintf ()，这样文件一次只会被打开一次，关闭一次。

