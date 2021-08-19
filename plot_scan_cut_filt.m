function plot_scan_cut_filt(in_scan, pso_const, filt_cent, filt_half_width, cut_value, cut_sign)

x_scale = 1/(2E-6*4*pso_const);
z = in_scan(:,1) + 1i*in_scan(:,2);
n = numel(z);
wv_number = (-n/2:(n/2)-1)/n*x_scale;
data_ft = fftshift(fft(z));
my_filt = exp(-(wv_number-filt_cent).^2./(2*filt_half_width.^2));
my_filt(wv_number*cut_sign > cut_value*cut_sign) = 0;
len_scale = 2E-6*4*pso_const;
len_vals = (-n/2:(n/2)-1)*len_scale;
data_filt = ifft(ifftshift(data_ft.*my_filt(:)));
%data_filt = data_filt.*exp(-len_vals(:)*2i*pi*filt_cent);
plot(len_vals,real(data_filt),len_vals,imag(data_filt));
