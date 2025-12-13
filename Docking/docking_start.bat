@echo off
setlocal enableextensions

echo **************************************
echo      BACE-1 Virtual Screening 
echo      Automated Docking Pipeline
echo **************************************
echo.

:: --- 1. SET RELATIVE PATHS (Works on any computer) ---
:: Assumes this script is running from inside the 'docking' folder
:: and ligands are in '../ligands/prepared_pdbqt'

set config="config.txt"
set ligand_folder="..\ligands\prepared_pdbqt"
set output_folder="vina_results"

:: --- 2. VERIFICATION ---
echo Verifying Configuration and Folder Paths:
echo ----------------------------------------
echo Config file target:   %config%
if exist %config% (echo [OK] Config file found.) else (echo [ERROR] Config file NOT FOUND. Check path!)

echo Ligand folder target: %ligand_folder%
if exist %ligand_folder% (echo [OK] Ligand folder found.) else (echo [ERROR] Ligand folder NOT FOUND. Check path!)

echo Output folder target: %output_folder%
echo.

if not exist %output_folder% (
    echo Creating output directory...
    mkdir %output_folder%
)

:: --- 3. DOCKING LOOP ---
echo.
echo Starting Batch Docking...
echo ----------------------------------------

set LIGAND_COUNT=0
for %%f in ("%ligand_folder%\*.pdbqt") do (
    set /a LIGAND_COUNT+=1
    
    :: %%~nxf gets the filename with extension (e.g., ligand1.pdbqt)
    :: %%~nf gets just the filename (e.g., ligand1)
    
    echo [%time%] Docking Ligand: %%~nxf
    
    :: Run Vina using relative paths
    vina --ligand "%%f" --config %config% --out "%output_folder%\%%~nf_docked.pdbqt" > "%output_folder%\%%~nf_log.txt"
)

echo.
echo **************************************
echo        Screening Completed!
echo **************************************
echo Total ligands processed: %LIGAND_COUNT%
echo Results saved to:        docking/%output_folder%
pause
endlocal