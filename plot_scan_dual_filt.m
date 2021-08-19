function out_scan = plot_scan_dual_filt(in_scan, pso_const, filt_cent_main, filt_cent_side, filt_half_width)

x_scale = 1/(2E-6*4*pso_const);
z = in_scan(:,1) + 1i*in_scan(:,2);
out_scan = zeros(size(in_scan));
n = numel(z);
wv_number = (-n/2:(n/2)-1)/n*x_scale;
data_ft = fftshift(fft(z));
my_filt = exp(-(wv_number-filt_cent_main).^2./(2*filt_half_width.^2));
filt_mid = mean([filt_cent_main, filt_cent_side]);
if filt_cent_side < filt_cent_main
    my_filt(wv_number < filt_mid) = 0;
else
    my_filt(wv_number > filt_mid) = 0;
end
len_scale = 2E-6*4*pso_const;
len_vals = (-n/2:(n/2)-1)*len_scale;
data_filt = ifft(ifftshift(data_ft.*my_filt(:)));
data_filt = data_filt.*exp(-len_vals(:)*2i*pi*filt_cent_main);
data_filt = data_filt./abs(data_filt);

out_z = z .* conj(data_filt);
out_scan(:,1) = real(out_z);
out_scan(:,2) = imag(out_z);
plot(len_vals,angle(data_filt)/pi,len_vals,abs(data_filt)/max(abs(data_filt)));
