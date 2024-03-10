import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import butter, lfilter
from pydub import AudioSegment
import soundfile as sf
import librosa

def butter_lowpass(cutoff, fs, order=5):
    nyquist = 0.5 * fs
    normal_cutoff = cutoff / nyquist
    b, a = butter(order, normal_cutoff, btype='low', analog=False)
    return b, a

def butter_lowpass_filter(data, cutoff, fs, order=5):
    b, a = butter_lowpass(cutoff, fs, order=order)
    y = lfilter(b, a, data)
    return y

# Load the audio file
file_path = 'test2.mp3'
y, sr = librosa.load(file_path)

# Apply the lowpass filter
cutoff_frequency = 500  # Adjust this as needed
order = 6  # Adjust this as needed
y_filtered = butter_lowpass_filter(y, cutoff_frequency, sr, order)

# Save the filtered audio as a WAV file
sf.write('output.mp3', y_filtered, sr)

# Load the filtered audio as a WAV file using pydub (optional)
filtered_audio = AudioSegment.from_wav('output.mp3')

# Save the filtered audio as an MP3 file (optional)
#filtered_audio.export('output.mp3', format="mp3")
