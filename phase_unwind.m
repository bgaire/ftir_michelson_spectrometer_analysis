function unwound = phase_unwind(complex_data)

raw_angle = angle(complex_data);

diff_angle = diff(raw_angle);
phase_breaks = -sign(diff_angle).*(abs(diff_angle) > pi)*2*pi;

unwound = raw_angle(:) + [0; cumsum(phase_breaks(:))];

