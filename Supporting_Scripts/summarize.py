import csv
from pathlib import Path

# --- Script to Parse AutoDock Vina Log Files ---

def summarize_vina_results():
    """
    Finds all Vina *_log.txt files in a user-specified directory,
    extracts the best binding affinity, and saves the sorted
    results to a CSV file.
    """
    print("--- AutoDock Vina Results Summarizer ---")
    
    # 1. Get the directory path from the user
    log_dir_path = input("Please enter the full path to the folder containing your Vina log files: ")
    
    log_directory = Path(log_dir_path)
    
    # 2. Validate the path
    if not log_directory.is_dir():
        print(f"\n❌ ERROR: Directory not found at '{log_dir_path}'")
        print("Please check the path and run the script again.")
        return # Exit the function
        
    print(f"\nScanning folder: {log_directory}\n")
    
    results = []
    
    # 3. Find and process every file ending with '_log.txt'
    #    This is the line that has been changed.
    log_files = list(log_directory.glob('*_log.txt'))
    
    if not log_files:
        print("❌ WARNING: No files ending with '_log.txt' were found in this directory.")
        return

    for log_file in log_files:
        try:
            with open(log_file, 'r', encoding='utf-8', errors='ignore') as f:
                for line in f:
                    # This finds the line for the best docking mode (mode 1)
                    if line.strip().startswith('1 '):
                        parts = line.split() # Splits the line by any whitespace
                        binding_affinity = parts[1]
                        
                        # Store the data in our results list
                        results.append({
                            'ligand': log_file.stem.replace('_log', ''), # Clean up filename
                            'affinity': float(binding_affinity)
                        })
                        
                        print(f"Processed '{log_file.name}': Found score {binding_affinity}")
                        break # Move to the next file once the best score is found
        except Exception as e:
            print(f"Could not process file {log_file.name} due to an error: {e}")

    # 4. Sort the results by binding affinity
    if results:
        sorted_results = sorted(results, key=lambda item: item['affinity'])
        
        # 5. Write the sorted results to a CSV file
        output_csv_path = log_directory / 'summary_sorted_vina.csv'
        
        try:
            with open(output_csv_path, 'w', newline='') as csvfile:
                fieldnames = ['ligand', 'affinity']
                writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
                
                writer.writeheader()
                writer.writerows(sorted_results)
            
            print(f"\n✅ Success! Results saved to:\n{output_csv_path}\n")
        except Exception as e:
            print(f"\n❌ ERROR: Could not write CSV file. Reason: {e}")
            
    else:
        print("\nCould not find any docking results in the provided log files.")

# --- Run the main function ---
if __name__ == "__main__":
    summarize_vina_results()
    input("Press Enter to exit.")