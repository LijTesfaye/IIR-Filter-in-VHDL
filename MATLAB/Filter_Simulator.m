%% This Matlab script serves the purpose of simulating an IIR FILTER of the following difference equation : y[n] = y[n - 1] - 1/4 x[n] + 1/4 x[n - 4]
%% In addition to that this script allows filtering a Wav files and outputing the result of it.
%% Through the textFileBuilder function you can get the two text files that presents all of the samples of the original and filtered WAV files in a 16 bit binary sequences.



%% ---------------------------- FILTER SIMULATION ---------------------------- %%

num_coeff = [-1/4 0 0 0 1/4];
den_coeff = [1 -1 0 0 0];

iir = dfilt.df2;
set(iir, 'arithmetic', 'fixed', ...
    'OutputMode', 'SpecifyPrecision', ...
    'Numerator', num_coeff, ...
    'Denominator', den_coeff, ...
    'InputWordLength',16, ...            
    'InputFracLength', 0, ...            
    'OutputWordLength', 16, ...           
    'OutputFracLength', 2, ...
    'StateWordLength', 16, ...        
    'StateFracLength', 0, ...
    'ProductMode', 'SpecifyPrecision', ...
    'ProductWordLength', 18, ...
    'NumProdFracLength', 2, ...
    'DenProdFracLength', 2, ...
    'AccumMode', 'SpecifyPrecision', ...
    'AccumWordLength', 18, ...
    'NumAccumFracLength', 2, ...
    'DenAccumFracLength', 2, ...
    'CastBeforeSum', false);




%% This command launches the Matlab fvtool which allows to monitor the magnitude and phase response of the filter in addition to its impulse reponse.

fvtool(iir); % filter behaviour in Matlab
impulse_in=[1 0 0 0 0];
impulse_in_fixed_point=fi(impulse_in,true,16,0);
impulse_response=filter(iir,impulse_in_fixed_point);

%% ---------------------------- READING AUDIO WAV FILES SAMPLES ---------------------------- %%

%% The absolute path for the audio files directory has to be specified

[siren_original, samplerate_siren] = audioread('C:\IIR_AUDIO_FILTER\WAV_Originals\siren.wav', 'native');
[trafficjam_original,samplerate_trafficjam] = audioread('C:\IIR_AUDIO_FILTER\WAV_Originals\trafficjam.wav', 'native');
[thunder_original,samplerate_thunder]=audioread('C:\IIR_AUDIO_FILTER\WAV_Originals\thunder.wav','native');




%% ---------------------------- CONVERTING AUDIO SAMPLES INTO 16 BIT FIXED VALUES ---------------------------- %%

siren_fixed_point = fi(siren_original, true, 16, 0);
trafficjam_fixed_point = fi(trafficjam_original, true, 16, 0);
thunder_fixed_point=fi(thunder_original,true,16,0);





%% ---------------------------- FILTERING THE AUDIO SAMPLES ---------------------------- %%

siren_filtered_fixed_point = filter(iir, siren_fixed_point);
trafficjam_filterd_fixed_point = filter(iir, trafficjam_fixed_point);
thunder_filtered_fixed_point=filter(iir,thunder_fixed_point);




%% ---------------------------- FILTERED AUDIO WAV FILES CREATION ---------------------------- %%

%% The absolute path for the audio files directory has to be specified

audiowrite('C:\IIR_AUDIO_FILTER\MATLAB\Wav_Filtered\filtered_siren_wav.wav', int16(siren_filtered_fixed_point), samplerate_siren);
audiowrite('C:\IIR_AUDIO_FILTER\MATLAB\Wav_Filtered\filtered_trafficjam_wav.wav', int16(trafficjam_filterd_fixed_point), samplerate_trafficjam);
audiowrite('C:\IIR_AUDIO_FILTER\MATLAB\Wav_Filtered\filtered_thunder_wav.wav',int16(thunder_filtered_fixed_point),samplerate_thunder);

%% ---------------------------- CREATING THE INPUT/OUTPUT TEXT FILES OF SAMPLES ---------------------------- %%

Text_File_Builder('impulse',impulse_in_fixed_point ,impulse_response);
Text_File_Builder('siren',siren_fixed_point , siren_filtered_fixed_point);
Text_File_Builder('trafficjam',trafficjam_fixed_point,trafficjam_filterd_fixed_point);
Text_File_Builder('thunder',thunder_fixed_point,thunder_filtered_fixed_point);
