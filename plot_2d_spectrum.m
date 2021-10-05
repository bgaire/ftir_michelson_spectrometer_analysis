function [exwv,sorted_data] = plot_2d_spectrum(michelson_data)
   sz = length(michelson_data.excitation_wavelengths);
   excitation_wvl = michelson_data.excitation_wavelengths;
   good_data = [];
   for ctr = 1:56
       emis_wvl = michelson_data.combined_data(1,:,ctr);
       emis_wvl = fliplr(emis_wvl);
       emis_dt = michelson_data.combined_data(2,:,ctr);
       emis_dt = fliplr(emis_dt);
       good_range = emis_wvl>1139 & emis_wvl < 1141;
       good_wvl = emis_wvl(good_range);
       good_wvl = good_wvl(1:180);
       good_dt = emis_dt(good_range);
       good_dt = good_dt(1:180);
       good_data(end+1,:) = good_dt;
   end
   [exwv,sortIdx] = sort(excitation_wvl);
   sorted_data = ones(size(good_data));
   b=1;
   for a = sortIdx       
       sorted_data(b,:) = good_data(a,:);
       b=b+1;
   end
   % Remove repeated items
   [wvex_un,un_idx] = unique(exwv);
   sorted_data_un = sorted_data(un_idx,:);
   
   % Suppress the excitation wavelength
   [~,~,bgwv,bgdt]=load_analyze_michelson('sept29_1140.577nmExc_neon_data8.mat',10,1140.577);
   ftvals = supress_excitation_wavelength(bgwv,bgdt);
   
   emission_data = ones(size(sorted_data_un));
   for cts = 1:length(wvex_un)
       srtd = sorted_data_un(cts,:);
       wvcln_pk = wvex_un(cts);
       ex_cln = good_wvl >(wvcln_pk - 2*ftvals(4)) & good_wvl < (wvcln_pk + 2*ftvals(4));
       srtd(ex_cln) = mean(srtd);
       emission_data(cts,:) = srtd;
   end
   
   %
    [wvex,wvem] = meshgrid(wvex_un,good_wvl);
    ed = log(emission_data)';
    surf(wvex,wvem,zeros(size(wvex)),ed,'facecolor','interp','edgecolor','interp');
    colorbar();
    view(2);
    xlim([1139.6,1140.3]);
    ylim([1139.8,1140.2]);
end