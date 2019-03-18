
tic

%将nanoscribe生成的gwl文件转换为河海可用的txt文件
fid = fopen('E:\学习\顾老师\3D打印\nanoscribe\stride30_0_0_0.gwl');
str_1 = fgetl(fid);     %str_0和str_1分别代表当前行和下一行
str_char_orginal_1 = char(str_1);
str_char_1 = strtrim(str_char_orginal_1);

txt_path = 'D:\333.txt';  
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
    
    %如果第一个字符是数字，放入待转换数组str中
    if(~isempty(str_num))
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