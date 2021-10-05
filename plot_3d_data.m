function [abs_wavelength,abs_data] = plot_3d_data(complete_data)
% Function to plot the absorption data, generated and put together as 3
% dimensional array
%figure(1);
%hold on;
    data_size = size(complete_data);
    total_scans = data_size(3);
    all_wavelengths = ones([1,96*data_size(3)]);
    for a = 1:total_scans
        %plot(complete_data(1,:,a),complete_data(2,:,a),'.','MarkerSize',10);
        all_wavelengths(96*(a-1)+1:a*96) = complete_data(1,:,a);
        all_data(96*(a-1)+1:a*96) = complete_data(2,:,a);
    end
%     xlim([1139.6,1140.4]);
    [all_wavelengths_sorted,idx] = sort(all_wavelengths);
    all_data_sorted = all_data(idx);
%     figure(3);
%     plot(all_wavelengths_sorted,all_data_sorted,'.');
%     
%     grid on;
%     xlabel('Wavelengths (nm)');
    abs_wavelength = all_wavelengths_sorted;
    abs_data = all_data_sorted;
    
end

    
    