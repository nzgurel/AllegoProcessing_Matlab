%% Read & Parse data from Allego files
%% Nil Gurel - 2021.03.19 [ngurel@mednet.ucla.edu]
%% 
%% Uses allegoXDatFileReader.m functions for parsing
%% Download allegoXDatFileReader here: https://neuronexus.com/allego-software-downloads-page/

% with current folder set to C:\Users\SmartBox\radix\data\2021.03.17_NNX_data_collection, list available files
dir

% .                                         sbpro_1__uid0317-16-11-28_data.xdat       sbpro_4__uid0317-17-54-52.xdat.json       
% ..                                        sbpro_1__uid0317-16-11-28_timestamp.xdat  sbpro_4__uid0317-17-54-52_data.xdat       
% allegoXDatFileReader.m                    sbpro_2__uid0317-16-43-54.xdat.json       sbpro_4__uid0317-17-54-52_timestamp.xdat  
% read_data_20210317.m                      sbpro_2__uid0317-16-43-54_data.xdat       sbpro_5__uid0317-18-20-31.xdat.json       
% sbpro_0__uid0317-15-38-58.xdat.json       sbpro_2__uid0317-16-43-54_timestamp.xdat  sbpro_5__uid0317-18-20-31_data.xdat       
% sbpro_0__uid0317-15-38-58_data.xdat       sbpro_3__uid0317-17-12-19.xdat.json       sbpro_5__uid0317-18-20-31_timestamp.xdat  
% sbpro_0__uid0317-15-38-58_timestamp.xdat  sbpro_3__uid0317-17-12-19_data.xdat       
% sbpro_1__uid0317-16-11-28.xdat.json       sbpro_3__uid0317-17-12-19_timestamp.xdat  

% create the reader
reader = allegoXDatFileReader;

% choose the file to import. Just use the base name, not the extension or the '_data' or '_timestamp' portions
datasource = 'sbpro_5__uid0317-18-20-31';

% view the time range of the file
reader.getAllegoXDatTimeRange(datasource)

% ans =
%    1.0e+03 *
%     7.7560
%     9.3808

% % OPTION 1: PARTIAL IMPORT
% % import all the signals with timestamps from t1 through t2 seconds
% t1=7780;
% t2=7900;
% signalStruct = reader.getAllegoXDatAllSigs(datasource, [t1 t2]);

% OPTION 2: IMPORT ALL DATA
% import all the signals with all the timestamps (takes a little long..)
signalStruct = reader.getAllegoXDatAllSigs(datasource, [-1 -1]);

% analog channels
BPchan=257;
RSPchan=258;
ECGchan=259;
% sampling rate
fs=20000;
ts=1/fs;

% time for plotting & calculate # of samples to plot
time_sec_plot=150;
s1=1; %start sample (starting from beginning);
s2=time_sec_plot*fs; % end sample

% a subset of the data
time_s1s2=signalStruct.timeSamples(s1:s2);
BP_s1s2=signalStruct.signals(BPchan:BPchan, s1:s2);
RSP_s1s2=signalStruct.signals(RSPchan:RSPchan, s1:s2);
ECG_s1s2=signalStruct.signals(ECGchan:ECGchan, s1:s2);

% plot a subset of the data (s1 to s2)
figure();
subplot(311);
plot(time_s1s2, BP_s1s2); % BP
ylabel('BP');

subplot(312);
plot(time_s1s2, RSP_s1s2); % RSP
ylabel('RSP');

subplot(313);
plot(time_s1s2, ECG_s1s2); % ECG
ylabel('ECG');
xlabel('time (sec)');








