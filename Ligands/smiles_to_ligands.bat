@echo off
echo **************************************
echo    Ligand Preparation (SMILES -> PDBQT)
echo    Powered by Open Babel
echo **************************************

:: 1. SETUP
set input_smiles="Smiles_final.smi"
set output_folder="prepared_pdbqt"

:: 2. CREATE FOLDER
if not exist %output_folder% mkdir %output_folder%

:: 3. RUN OPEN BABEL
:: Flags explained:
:: -i smi  : Input format is SMILES
:: -O      : Output format (pdbqt)
:: -m      : Split into multiple files (one per ligand)
:: --gen3d : Generate 3D coordinates (critical!)
:: -h      : Add hydrogens (pH 7.4 is default roughly)
:: --best  : slow but better conformation search

echo Converting %input_smiles% to 3D structures...
echo This may take a while for 1000 compounds.

obabel -i smi %input_smiles% -O %output_folder%\ligand_.pdbqt -m --gen3d -h --best

echo.
echo **************************************
echo           Preparation Complete
echo **************************************
pause