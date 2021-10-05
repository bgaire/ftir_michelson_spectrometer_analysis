function [out_cm_raw, out_data_raw, out_wvl, out_data_fft] = full_analyze_michelson(in_scan, pso_const, in_wvl_excitation)

% fixed parameters that work OK
wvnum_filter_size = 20; % filter +/- 20 wvnum around each peak
cm_edge_cut = 0.025; % cut 0.25 mm from the edge of filtered data

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

% correction factor - measured wavelengths are slightly longer than
% Bristol wavelenghts
wvl_correction = 1.000454;

expect_excit_wvnum = 1E7/(in_wvl_excitation*wvl_correction);
expect_emiss_wvnum = 1E7/(1140*wvl_correction);

corrected_scan = plot_scan_phase_correct(z, pso_const, 2*expect_excit_wvnum, wvnum_filter_size, expect_emiss_wvnum, wvnum_filter_size, false);

symmetrized_scan = scan_symmetrize(corrected_scan, pso_const, cm_edge_cut, true);

[out_data_raw, out_cm_raw] = plot_scan_raw(symmetrized_scan, pso_const, true);
[~, out_wvnum] = plot_scan_fft(symmetrized_scan, pso_const, true);

out_data_fft = abs(fft(out_data_raw));
out_wvl = 1E7./out_wvnum/wvl_correction;
% figure(2);
% plot(out_wvl, out_data_fft);
% grid on;
% xlim([1139 1141.5]);