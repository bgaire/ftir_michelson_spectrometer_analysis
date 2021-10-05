function [all_exc_emiss] = process_michelson_data(complete_data,all_exc_emiss)
    if isempty(all_exc_emiss)
        all_exc_emiss={};
    end
    % For  supressing the excitation wavelength
    [exc_wvl,emis_wvl,emis_data] = open_data_file();
    
    h = plot(emis_wvl,emis_data,'b','LineWidth',1);
    hold on;
    y_max = round(max(emis_data));
    y_values = 0:1000:y_max+0.1*y_max;
    exc_xvalues = ones(size(y_values))*exc_wvl;
    
    plot(exc_xvalues,y_values,'g','LineWidth',1,'DisplayName','Excitation');
    title(['Excitation Wavelength: ',num2str(exc_wvl)]);
    xlabel('Wavelengths (nm)');
    xlim([1139.6,1140.6]);
    grid on;
    emission_wvl = [];
    while 1
        ew = input('Emission wavelengths: ');
        if ew ==0
            break;
        else
            emission_wvl(end+1,1) = ew;
            emis_xvalues = ones(size(y_values))*ew;
            plot(emis_xvalues,y_values,'LineWidth',1,'DisplayName',num2str(ew));
        end
    end
    legend();
    delete(h);
    plot_3d_data(complete_data);
    ylim([0,700]);
    xlim([1139.8,1140.3])
    hold off;
    all_exc_emiss{end+1} = {exc_wvl,emission_wvl};
      
end