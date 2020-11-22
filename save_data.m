fid = fopen('full_data.txt', 'wt');

for k = 1:size(full_data,1)
    fprintf(fid, '%20.18f;', full_data(k,:));
    fprintf(fid, '\n');
end

fclose(fid)