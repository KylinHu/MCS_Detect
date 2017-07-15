data_path='/Users/hcq/workspace/MCS/Result/MCS_dataset02/';
data_name = 'MCS_*.mat';

all_file = dir(fullfile(data_path, data_name));
monnum = length(all_file);
for mnum = 1:monnum
    load (fullfile(data_path, all_file(mnum).name));
    age = [MCS_record.frames].';
    record = MCS_record(age >= 3);
    fname = strfind (all_file(monnum).name, 'MCS_');
    rec_time = all_file(monnum).name(fname+4:11);

%% 
file_name = strcat('MCS_',rec_time,'.txt');
fid = fopen(fullfile(data_path, file_name),'w');
fprintf(fid, '%s\t',...
'ID','Lifetime(hour)',...
'gLat(N)','gLon(E)','wLat(N)','wLon(E)',...
'Size(km^2)','Eccentricity',...
'BTavg(K)','BTmin(K)',...
'Time(UTC)','Speed(km/h)');
fprintf(fid, '\n');
for i = 1:length(record)
    track = record(i);
    for j = 1:track.frames
        %id = track.id;
        id = i;
        life = (track.frames-1)*3;
        gLat = track.glat(j);
        gLon = track.glon(j);
        wLat = track.wlat(j);
        wLon = track.wlon(j);
        size = track.size(j);
        eccen = Fit_eccen(track.list_grid{j}(:,1),track.list_grid{j}(:,2));
        tpavg = track.avg_temp(j);
        tpmin = track.min_temp(j);   
        time = datestr(track.list_time(j),'yyyy-mm-dd-HH');
        if j >=2 
        speed = (distance(track.wlat(j),track.wlon(j),track.wlat(j-1),track.wlon(j-1))/180*pi*6371)/3;            
        else 
            speed = NaN;
        end
        fprintf(fid, '%i %i %.4f %.4f %.4f %.4f %i %.2f %.2f %.2f %s %.2f\t',....
                id,life,gLat,gLon,wLat,wLon,size,eccen,tpavg,tpmin,time,speed);
        fprintf(fid, '\n');
    end
end
end