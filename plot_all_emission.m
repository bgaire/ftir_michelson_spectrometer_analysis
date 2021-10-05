function [] = plot_all_emission(emission_data,absorption_data)
    plot_colors={'#0072BD','#D95319','#EDB120','#7E2F8E','#77AC30'};
    figure(10);
    for ctr = 43:46
        
        cctr=ctr-42;
        pc=plot_colors{cctr};
        dti = emission_data{ctr};
        exc_wvl=dti{1};
        emis_wvl=dti{2};
        y_values=0:725;
        exc_vals=ones(size(y_values))*exc_wvl;
        plot(exc_vals,y_values,'--','linewidth',1,'color',pc,'displayname',num2str(exc_wvl));
        text(1139.85+(cctr-1)*0.1,750,num2str(exc_wvl),...
            'color',pc,'fontsize',12,'fontweight','bold');
        hold on;
        for aa = 1:length(emis_wvl)
            ems_vals=ones(size(y_values))*emis_wvl(aa);
            plot(ems_vals,y_values,'linewidth',1,'color',pc);
        end
    end
    plot_3d_data(absorption_data);
    %text(1140.15,700,'Dashed lines: Excitation, Solid lines: Emission','fontsize',12,'fontweight','bold');
    xlim([1139.8,1140.3]);
    
    hold off;
    grid on;
    
end