#!/bin/bash

echo "--- converting pdb file ---"
gmx_mpi pdb2gmx -f ala2.pdb -water tip3p -ff amber03 || exit 1

echo "--- setting box size ---"
gmx_mpi editconf -o box.gro -f conf.gro -bt cubic -d 1.2 || exit 1

echo "--- creating water molecules ---"
gmx_mpi solvate -cp box.gro -cs spc216.gro -o sol.gro -p topol.top || exit 1

echo "--- adding NaCl in physiologial concentration ---"
gmx_mpi grompp -o iongen.tpr -c sol.gro -f em.mdp || exit 1
echo "13\n" | gmx_mpi genion -o ionized.gro -s iongen.tpr -p topol.top -conc 0.15 || exit 1

echo "--- running energy minimization ----"
gmx_mpi grompp -o em.tpr -f em.mdp -c ionized.gro || exit 1
mpirun -np 8 gmx_mpi mdrun -deffnm em || exit 1

echo "--- init temperature ----"
gmx_mpi grompp -o nvt.tpr -f nvt.mdp -c em.gro -r em.gro || exit 1
mpirun -np 8 gmx_mpi mdrun -deffnm nvt || exit 1

echo "--- init pressure ----"
gmx_mpi grompp -o npt.tpr -f npt.mdp -c nvt.gro -r nvt.gro || exit 1
mpirun -np 8 gmx_mpi mdrun -deffnm npt || exit 1

gmx_mpi grompp -o md.tpr -f md.mdp -c npt.gro -r npt.gro || exit 1
mpirun -np 8 gmx_mpi mdrun -v -deffnm md || exit 1
