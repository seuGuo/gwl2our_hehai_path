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