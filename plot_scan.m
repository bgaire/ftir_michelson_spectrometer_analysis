function plot_scan(in_scan, pso_const)

x_scale = 1/(2E-6*4*pso_const);
z = in_scan(:,1) + 1i*in_scan(:,2);
n = numel(z);
plot((-n/2:(n/2)-1)/n*x_scale,abs(fftshift(fft(z)))/n);