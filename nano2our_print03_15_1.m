
tic

%��nanoscribe���ɵ�gwl�ļ�ת��Ϊ�Ӻ����õ�txt�ļ�
fid = fopen('E:\ѧϰ\����ʦ\3D��ӡ\nanoscribe\stride30_0_0_0.gwl');
str_1 = fgetl(fid);     %str_0��str_1�ֱ����ǰ�к���һ��
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
    
    %�����һ���ַ������֣������ת������str��
    if(~isempty(str_num))
%         write_in_notes_0315_1(txt_path,1,str,speed,table);
        %�鿴��һ���ַ��ǲ���write
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