function symmetric_scan = scan_symmetrize(in_raw_scan, pso_const, edge_buffer, make_plot)
% scan_symmetrize - attempt to create a symmetric scan from an off-center
% one
% in_raw_scan - a filtered, corrected scan
% pco_const - stage parameter to get the units right
% edge_buffer - distance in cm to leave off the edges
% center_guess - guess at where the zero-path length position is
% make_plot - actually make the plot (default: yes)

if ~exist('make_plot', 'var')
    make_plot = true;
end

% x_scale is in cm^-1, pathlength not physical length
% encoder length is 20 nm = 2E-8 m = 2E-6 cm
% times 2 for alternating encoder (half are rising edges)
% times 2 for path length
% times pso_const based on how you program the stage
x_scale = 2E-6*4*pso_const;

% this is built to handle n-by-2 arrays of real and imaginary parts
% but we can work with more flexible options as needed
if size(in_raw_scan,1) <= 2
    in_raw_scan = in_raw_scan';
end
if size(in_raw_scan,2) > 1
    z = in_raw_scan(:,1) + 1i*in_raw_scan(:,2);
else
    z = in_raw_scan;
end
n = numel(z);

x = (-n/2:(n/2)-1)*x_scale;

x_min = min(x);
x_max = max(x);

x_good = (x > x_min + edge_buffer) & (x < x_max - edge_buffer);

z_cut = z(x_good);

n_cut = numel(z_cut);

big_n = 2*n_cut + 1;

z_big = zeros(big_n,1);
z_big(1:n_cut) = z_cut;

z_fft = fft(z_big);
z_afft = fft(abs(z_big));

z_opt = ifft(z_fft.^2);
z_aopt = ifft(z_afft.^2);

% try to find a balance between phase sensitive overlap and absolute overlap
[~, max_loc] = max(abs(z_opt)+abs(z_aopt));

max_phase = z_opt(max_loc)/abs(z_opt(max_loc));
phase_corr = max_phase^(-1/2);

z_big_final = nan(big_n,1);
z_big_final(1:n_cut) = z_cut*phase_corr;
z_big_final_flip = circshift(conj(flipud(z_big_final)),max_loc);

z_big_final_mean = mean([z_big_final z_big_final_flip],2,'omitnan');

symmetric_scan = z_big_final_mean(~isnan(z_big_final_mean));
symmetric_scan = circshift(symmetric_scan,-floor(max_loc/2));
plot_scan_fft(symmetric_scan,pso_const, make_plot);
