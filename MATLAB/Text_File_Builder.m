 %% This functino output two text files called input and output which will serves us later the purpose of testbenching the IIR on VHDL 
 
 function Text_File_Builder(file_name, original_signal, filtered_signal)

input_file = fopen(strcat('C:\IIR_AUDIO_FILTER\MATLAB\Stimuli\', file_name, '_in.txt'), 'w'); %% Locate the text files (change to the absolute path)
output_file = fopen(strcat('C:\IIR_AUDIO_FILTER\MATLAB\Stimuli\', file_name, '_out.txt'), 'w');

for i=1:max(size(original_signal)) %% Recording of all samples into the input and output files
   fprintf(input_file, '%s\n', bin(original_signal(i)));
   fprintf(output_file, '%s\n', bin(filtered_signal(i)));
end
end
