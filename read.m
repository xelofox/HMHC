%Made by Nicolas Testard if there is any question

fclose("all");
f=fopen('slowArm.drf');
ind_time=1;
char='azerty';
while ~isempty(char)
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
            Time(ind_time)=str2double(time);

            ind_segment=1;
            while ind_segment<=17
                pos=zeros(17,6);
                ind=0;
                while ind<1
                    char3=fread(f,1, 'uint8=>char');
                    if char3=='['
                        ind=ind+1;
                    end
                end
                for ind_vec=1:6
                    char3=fread(f,1, 'uint8=>char');
                    val='';
                    while (char3~=' ')&&(char3~=']')
                        val=strcat(val,char3);
                        char3=fread(f,1, 'uint8=>char');
                    end
                    vec(ind_vec)=str2double(val);
                end
                pos(ind_segment,:)=vec;
                ind_segment=ind_segment+1;
            end
            first{ind_time}=pos;
            ind_time=ind_time+1;
        else
        char=char2;
        end               
    end
end

fclose("all");

clear char char2 char3 ind ind_segment ind_time pos time val vec f ind_vec