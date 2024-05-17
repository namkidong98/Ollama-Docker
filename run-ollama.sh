#!/usr/bin/env bash

# Start ollama serve in the background
OLLAMA_HOST="0.0.0.0:11434" ollama serve &

# Wait for a few seconds to ensure that ollama serve starts properly
sleep 10

# List available models
ollama list

# Create the model
ollama create EEVE-Korean-10.8B -f Modelfile

# Keep the script running to keep the container alive
tail -f /dev/null