@echo off
setlocal enabledelayedexpansion

echo **************************************
echo    Batch Ligand Preparation (ADT)
echo    PDB -to- PDBQT
echo **************************************
echo.

:: --- 1. CONFIGURATION (CHECK THESE PATHS!) ---

:: Path to the Python executable inside MGLTools (Found in C:\Program Files (x86)\MGLTools...)
set python_exe="C:\Program Files (x86)\MGLTools-1.5.6\python.exe"

:: Path to the prepare_ligand4.py script inside MGLTools utilities
set script_path="C:\Program Files (x86)\MGLTools-1.5.6\MGLToolsPckgs\AutoDockTools\Utilities24\prepare_ligand4.py"

:: Input folder (Where your 3D .pdb files are)
set input_folder="pdb_3d"

:: Output folder (Where .pdbqt files will go)
set output_folder="prepared_pdbqt"

:: --- 2. VERIFICATION ---
if not exist %python_exe% (
    echo [ERROR] MGLTools python.exe not found.
    echo Please edit the 'set python_exe' line in this script.
    pause
    exit /b
)

if not exist %input_folder% (
    echo [ERROR] Input folder '%input_folder%' does not exist.
    echo Run Open Babel first to generate 3D PDB files.
    pause
    exit /b
)

if not exist %output_folder% mkdir %output_folder%

:: --- 3. PROCESSING LOOP ---
echo Processing ligands...
echo ---------------------

for %%f in ("%input_folder%\*.pdb") do (
    echo Converting: %%~nxf
    
    :: COMMAND EXPLANATION:
    :: -l : Input ligand file
    :: -o : Output PDBQT file
    :: -A hydrogens : Repair hydrogens (add missing polar H)
    :: -U nphs_lps_waters : Cleanup (Merge Non-Polar H, Remove Lone Pairs, Remove Waters)
    
    %python_exe% %script_path% -l "%%f" -o "%output_folder%\%%~nf.pdbqt" -A hydrogens -U nphs_lps_waters
)

echo.
echo **************************************
echo           Preparation Complete
echo **************************************
pause