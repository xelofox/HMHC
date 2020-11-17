%Made by Nicolas Testard if there is any question

fclose("all");
f=fopen('slowArm.drf');
i=1;
for k=1:1000
    char=fread(f,1, 'uint8=>char');
    if char=='t'
        char2=fread(f,1, 'uint8=>char');
        if char2=='s'
            char3=fread(f,1, 'uint8=>char');
            time='';
            while (char3 ~='d')
                time=strcat(time,char3);
                char3=fread(f,1, 'uint8=>char');
            end
            time=time(1:end-1);
        else
        char=char2;
        end               
    end
end
