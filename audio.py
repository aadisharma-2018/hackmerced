import librosa
import numpy as np

# Load audio file
audio_file = "test1.mp3"  # Change this to your music file path
y, sr = librosa.load(audio_file)

# Constants
CHUNK = 1024

try:
    for i in range(0, len(y), CHUNK):
        # Extract audio chunk
        audio_chunk = y[i:i+CHUNK]
        
        # Calculate intensity
        intensity = np.mean(np.abs(audio_chunk))
        
        # Map intensity to haptic feedback (simplified example)
        vibration_intensity = intensity / 1000.0  # Adjust as needed
        
        # Output vibration intensity (this part depends on the platform)
        print("Vibration intensity:", vibration_intensity)
        
except KeyboardInterrupt:
    print("* done")
