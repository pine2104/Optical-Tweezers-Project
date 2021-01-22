% This example demonstrates the two-side DFT of a sinusoidal function
% (���d�Үi�ܤ@��²�楿���i���ť߸��ഫ�A�H�����W�Ш����)
% Since the sinusoidal function has a frequency to be a multiple of fs/N, the two-side DFT have only two nonzero terms.
% (�������i���W�v�ꥩ�O freqStep ����ƭ��A�ҥH�����W�����ӥu����ӫD�s�I)

N = 256;			% length of vector (�I��)
fs = 8000;			% sample rate (�����W�v)
freqStep = fs/N;		% freq resolution in spectrum (�W�쪺�W�v���ѪR��)
f = 10*freqStep;		% freq of the sinusoid (�����i���W�v�A��O freqStep ����ƭ�)
time = (0:N-1)/fs;		% time resolution in time-domain (�ɰ쪺�ɶ����)
y = cos(2*pi*f*time);		% signal to analyze
Y = fft(y);			% spectrum
Y = fftshift(Y);		% put zero freq at the center (�N�W�v�b���s�I�m��)

% Plot time data
subplot(3,1,1);
plot(time, y, '.-');
title('Sinusoidal signals');
xlabel('Time (seconds)'); ylabel('Amplitude');
axis tight

% Plot spectral magnitude
freq = freqStep*(-N/2:N/2-1);	% freq resolution in spectrum (�W�쪺�W�v���ѪR��)
subplot(3,1,2);
plot(freq, abs(Y), '.-b'); grid on
xlabel('Frequency)'); 
ylabel('Magnitude (Linear)');

% Plot phase
subplot(3,1,3);
plot(freq, angle(Y), '.-b'); grid on
xlabel('Frequency)'); 
ylabel('Phase (Radian)');