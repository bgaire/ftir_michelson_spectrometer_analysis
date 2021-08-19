function data_filt = plot_scan_filt(in_scan, pso_const, filt_cent, filt_half_width, make_plot)

if ~exist('make_plot', 'var')
    make_plot = true;
end

% x_scale is in cm^-1, pathlength not physical length
% encoder length is 20 nm = 2E-8 m = 2E-6 cm
% times 2 for alternating encoder (half are rising edges)
% times 2 for path length
% times pso_const based on how you program the stage
x_scale = 1/(2E-6*4*pso_const);

% this is built to handle n-by-2 arrays of real and imaginary parts
% but we can work with more flexible options as needed
if size(in_scan,1) <= 2
    in_scan = in_scan';
end
if size(in_scan,2) == 1
    z = in_scan;
else
    z = in_scan(:,1) + 1i*in_scan(:,2);
end
n = numel(z);

% scale for fft
wv_number = (0:(n-1))/n*x_scale;
data_ft = fft(z);
my_filt = exp(-(wv_number-filt_cent).^2./(2*filt_half_width.^2));

len_scale = 2E-6*4*pso_const;
len_vals = (-n/2:(n/2)-1)*len_scale;
data_filt = ifft(data_ft.*my_filt(:));
if (make_plot)
    plot(len_vals,real(data_filt),'.',len_vals,imag(data_filt),'.');
end