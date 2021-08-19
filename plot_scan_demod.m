function demod_output = plot_scan_demod(in_scan, pso_const, demod_offset, make_plot)
% plot_scan_demod - demodulates the raw scan and plots it as a near-constant output
% in_scan - the scan, should be filtered first
% pso_const - the stage trigger settings, used to scale
% demod_offset - the center around which you filtered
% make_plot - actually show the plot (default: yes)

if ~exist('make_plot', 'var')
    make_plot = true;
end

x_scale = 2E-6*4*pso_const;
x_scale_fft = 1/(2E-6*4*pso_const);

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

zfft = fft(z);
zfft = circshift(zfft, -round(demod_offset*n/(x_scale_fft)));
demod_output = ifft(zfft);
if (make_plot)
    plot((-n/2:(n/2)-1)*x_scale,real(demod_output),(-n/2:(n/2)-1)*x_scale,imag(demod_output),(-n/2:(n/2)-1)*x_scale,abs(demod_output));
end
