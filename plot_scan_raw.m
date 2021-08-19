function [z, x] = plot_scan_raw(in_scan, pso_const, make_plot)
% plot_scan_raw - shows a scan in real space
% in_scan - the scan data (can by n-by-2 for real/imag)
% pso_const - the trig settings used with the translation stage
% make_plot - actually show the plot (default: yes)

if ~exist('make_plot', 'var')
    make_plot = true;
end

% x_scale is in cm, pathlength not physical length
% encoder length is 20 nm = 2E-8 m = 2E-6 cm
% times 2 for alternating encoder (half are rising edges)
% times 2 for path length
% times pso_const based on how you program the stage
x_scale = 2E-6*4*pso_const;

% this is built to handle n-by-2 arrays of real and imaginary parts
% but we can work with more flexible options as needed
if size(in_scan,1) <= 2
    in_scan = in_scan';
end
if size(in_scan,2) > 1
    z = in_scan(:,1) + 1i*in_scan(:,2);
else
    z = in_scan;
end
n = numel(z);

x = (-n/2:(n/2)-1)*x_scale;
if (make_plot)
    figure(2);
    plot(x,real(z),'.',x,imag(z),'.');
end