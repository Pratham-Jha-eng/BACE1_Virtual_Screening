@echo off

set INPUT_DIR= Ligands
set OUTPUT_DIR= Logands_prepped_for_lipinski

if not exist %OUTPUT_DIR% mkdir %OUTPUT_DIR%

for /f %%i in (obabeipinski.txt) do (
    obabel %INPUT_DIR%\%%i.sdf -O %OUTPUT_DIR%\%%i.mol	-d
)

echo Conversion complete!
pause
