function [] = stitch_with_absorption(complete_data)
    
    [exc_wvl,emiss_wvl] = process_michelson_data();
%     close all;

    
    y_values = 0:10:800;
    emis_yvalues = ones(size(emiss_wvl)).*y_values;
    emis_xvalues = ones(size(emis_yvalues)).*emiss_wvl;
    figure(5);hold on;
    plot(emis_xvalues',emis_yvalues','r','linewidth',1);
    
    exic_xvalues = ones(size(y_values)).*exc_wvl;
    plot(exic_xvalues',y_values','r','linewidth',1);
    text(exc_wvl,500,num2str(exc_wvl),'fontsize',14,'color','r');
    [w,d]=plot_3d_data(complete_data);
    plot(w,d,'b.');
    hold off;
    grid on;
    xlabel('Wavelength (nm)');
end