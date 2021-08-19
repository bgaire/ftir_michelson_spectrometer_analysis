function [out_cm_raw, out_data_raw, out_wvl, out_data_fft] = load_analyze_michelson(in_filename, pso_const, in_wvl_excitation)

loaded_dat = load(in_filename);

[out_cm_raw, out_data_raw, out_wvl, out_data_fft] = full_analyze_michelson(loaded_dat.raw_counts, pso_const, in_wvl_excitation);
title(in_filename,'interpreter','none');