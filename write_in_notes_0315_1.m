function write_in_notes_0315_1(txt_path,state,str,speed,table)
%ʵ�ֽ��µ�·��д���µ�txt����txt·��Ϊ�ַ���txt_path,state==1Ϊ����,state==0Ϊwrite
%��������ӵ��ַ���str,����γɵ�·��notes_string,strΪcell��,speedΪ�ƶ�̨�ٶ�,talbeΪ�ƶ�̨���

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