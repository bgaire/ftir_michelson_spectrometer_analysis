function [pc_output, sh_demod] = plot_scan_phase_correct(in_scan, pso_const, sh_loc, sh_width, mp_loc, mp_width, make_plot)
% plot_scan_demod - demodulates the raw scan and plots it as a near-constant output
% in_scan - the scan, should be filtered first
% pso_const - the stage trigger settings, used to scale
% sh_loc - second harmonic peak location (cm^-1)
% sh_width - second harmonic peak width (cm^-1)
% mp_loc - main peak location (cm^-1)
% mp_width - main peak width (cm^-1)
% make_plot - actually do the plot or no (default yes)

if ~exist('make_plot', 'var')
    make_plot = true;
end

x_scale_fft = 1/(2E-6*4*pso_const);

% adjust for aliasing
sh_loc = mod(sh_loc,x_scale_fft);
mp_loc = mod(mp_loc,x_scale_fft);

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

sh_demod = plot_scan_demod(plot_scan_filt(z, pso_const, sh_loc, sh_width, false), pso_const, sh_loc, false);
mp_filt = plot_scan_filt(z, pso_const, mp_loc, mp_width, false);

sh_phase = phase_unwind(sh_demod);

mp_phase_corr = exp(-1i*sh_phase/2);

pc_output = mp_filt.*mp_phase_corr;
% plot_scan_fft(pc_output, pso_const, make_plot);