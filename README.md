Generating Minimum Free Energy Paths with Denoising Diffusion Probabilistic Models

OVERVIEW
========
Implementation of a method to generate minimum free energy paths using denoising 
diffusion probabilistic models for molecular dynamics simulations.

This repository contains code for applying diffusion models to the problem of 
finding minimum free energy paths between molecular configurations. The approach 
uses DDPMs to learn the underlying energy landscape and generate transition pathways.

INSTALLATION
============
git clone https://github.com/Grivov/Generating-Minimum-Free-Energy-Paths-With-Denoising-Diffusion-Probabilistic-Models.git
cd Generating-Minimum-Free-Energy-Paths-With-Denoising-Diffusion-Probabilistic-Models
pip install -r requirements.txt

USAGE
=====
Training the diffusion model:
python train.py --config configs/default.yaml

Generating paths:
python generate_paths.py --model_path checkpoints/model.pth --start_config start.xyz --end_config end.xyz

REQUIREMENTS
============
- Python 3.8+
- PyTorch
- NumPy
- SciPy
- matplotlib

STRUCTURE
=========
models/     - Diffusion model implementations
data/       - Data loading and preprocessing
utils/      - Utility functions for energy calculations
configs/    - Configuration files
examples/   - Example molecular systems

CITATION
========
If you use this code, please cite:

@article{author2023diffusion,
  title={Generating Minimum Free Energy Paths with Denoising Diffusion Probabilistic Models},
  author={Author Name},
  journal={Journal},
  year={2023}
}
