function [ex_wvl,out_wvl,out_data]=open_data_file()
    filename = uigetfile('*.mat','Select the data file');
    fprintf([filename,'\n']);
    split_title = split(filename,'_');
    ex_wvl = sscanf(split_title{2},'%f');
    [~,~,out_wvl,out_data]= load_analyze_michelson(filename,10,ex_wvl);
    close(2);
    out_wvl(1)=[];
    out_data(1)=[];
    [out_wvl,idx] = sort(out_wvl);
    out_data=out_data(idx);
    good_range = out_wvl>1139 & out_wvl  < 1141;
    out_wvl=out_wvl(good_range);
    out_data = out_data(good_range);
end