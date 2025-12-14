# Structure-Based Virtual Screening of Flavonoid Compounds Against BACE-1

![Status](https://img.shields.io/badge/Status-Completed-success)
![Method](https://img.shields.io/badge/Method-Molecular_Docking-blue)
![Target](https://img.shields.io/badge/Target-BACE1-red)
![Library](https://img.shields.io/badge/Library-Flavonoids-green)

## 📌 Project Overview

This repository presents an *in silico* structure-based drug discovery workflow employed to identify potential inhibitors of **β-site amyloid precursor protein cleaving enzyme-1 (BACE-1)** from a flavonoid compound library.

The study integrates targeted molecular docking using **AutoDock Vina** with post-docking drug-likeness screening based on **Lipinski’s Rule of Five**, enabling prioritization of compounds with favorable binding affinity and physicochemical properties.

The overall computational strategy follows a workflow commonly reported in flavonoid-based virtual screening studies, where docking results are combined with Lipinski filtering to shortlist lead-like molecules prior to further *in silico* or experimental validation.

---

## 🧬 Target Protein

![BACE-1 Protein Structure](figures/bace1_structure.png)

*Figure 1: Overall three-dimensional structure of BACE-1 (PDB ID: 2ZJIN).The central cavity represents the substrate-binding cleft.*

* **Protein:** β-site amyloid precursor protein cleaving enzyme-1 (BACE-1)
* **PDB ID:** `2ZJIN`
* **Biological Relevance:** Key enzyme involved in amyloid-β peptide generation in Alzheimer’s disease.
* **Catalytic Residues:** **Asp32** and **Asp228** (aspartyl protease dyad).

---

## 🧪 Ligand Library

* **Library Size:** 1000 compounds
* **Compound Class:** Flavonoids
* **Initial Representation:** SMILES
* **Docking Format:** PDBQT

---

## ⚙️ Computational Workflow

### 1️⃣ Protein Preparation
* Protein structure retrieved from the Protein Data Bank (PDB).
* Removal of crystallographic water molecules.
* Addition of polar hydrogens.
* Assignment of Gasteiger charges.
* Protein saved in PDBQT format using **AutoDock Tools**.

### 2️⃣ Active-Site Identification and Grid Validation
Docking was performed using a targeted (active-site) approach. The search space was defined to encompass the catalytic dyad (**Asp32** and **Asp228**), which is essential for BACE-1 proteolytic activity.

**Visual Verification:**
The grid box center and dimensions were visually inspected in PyMOL relative to the crystallographic ligand and catalytic residues.

![Active Site Validation](figures/active_site_validation.png)
*Figure 2: Visualization of the docking grid box (Red) centered on the BACE-1 active site. The catalytic aspartyl residues (Asp32, Asp228) are highlighted in stick representation, confirming their inclusion within the search space.*

**Grid Parameters:**
* **Center:** `x=74.44`, `y=32.979`, `z=28.979`
* **Size:** `30 x 30 x 30 Å`

> **Validation Outcome:** The grid box successfully covers the substrate-binding cleft without being excessively large, reducing the false-positive rate from non-specific surface binding.

### 3️⃣ Ligand Preparation
* SMILES converted to three-dimensional structures.
* Energy minimization performed.
* Partial charges assigned.
* Ligands saved individually in PDBQT format.
* *Ligand preparation was performed consistently across the entire library.*

### 4️⃣ Molecular Docking
* **Software:** AutoDock Vina
* **Method:** Docking performed individually for each ligand.
* **Ranking:** Poses ranked based on binding affinity; the lowest binding energy pose was retained.

**AutoDock Vina Configuration (`config.txt`):**
```bash
receptor = protein/BACE1_prepared.pdbqt

center_x = 74.44
center_y = 32.979
center_z = 28.979

size_x = 30
size_y = 30
size_z = 30

exhaustiveness = 8
num_modes = 9
log = vina_log.txt

```
### 5️⃣ Drug-Likeness & Toxicity Screening

A multi-stage screening pipeline was implemented to evaluate the drug-likeness and safety profile of the docked flavonoid compounds.



### 🔹 Step A: Physicochemical Descriptors (Open Babel)

Key molecular descriptors required for drug-likeness evaluation were calculated using **Open Babel**:

- **Molecular Weight (MW)**
- **LogP** (Octanol/Water Partition Coefficient)
- **Hydrogen Bond Donors (HBD)**
- **Hydrogen Bond Acceptors (HBA)**

---

### 🔹 Step B: Toxicity & Drug Scores (OSIRIS Property Explorer)

**OSIRIS Property Explorer** was used to predict toxicity risks and overall drug potential:

- **Drug-Likeness Score**
- **Molar Refractivity (MR)**
- **Toxicity Risks (TR):**
  - Mutagenicity  
  - Tumorigenicity  
  - Irritancy  
- **Reproductive Effects (RE)**

---

### 🔹 Step C: Data Integration & Filtering (Microsoft Excel)

- Docking scores, Lipinski descriptors, and OSIRIS predictions were merged into a master dataset  
- Logical filters were applied using **Excel formulas** to automate compound classification  

---

### 🧪 Lipinski’s Rule of Five Criteria

A compound was considered **PASS** if it violated **no more than one** of the following conditions:

1. \( MW <=500 \)  
2. \( LogP <=5 \)  
3. \( HBD <=5 \)  
4. \( HBA <=10 \)  

---

### 🏆 Final Shortlisting Criteria

Compounds were prioritized based on the intersection of:

- Strong docking affinity  
- Lipinski **PASS** status  
- Positive OSIRIS drug-likeness score  
- Absence of high-risk toxicity alerts  

---

### 📊 Results Summary

- ✅ **Docking:** Several flavonoids demonstrated favorable binding affinities within the BACE-1 active site  
- ⚠️ **Lipinski Analysis:** Violations were primarily associated with high molecular weight or excessive hydrogen bonding capacity  
- 🚫 **Toxicity Screening:** OSIRIS predictions eliminated high-affinity compounds with potential toxicity risks  
- 🏆 **Outcome:** A refined subset of flavonoids was shortlisted as potential lead candidates for further investigation  

---

### 🛠️ Software Used

| Software | Purpose |
| :--- | :--- |
| **AutoDock Vina** | Molecular docking |
| **AutoDock Tools** | Protein & ligand preparation |
| **Open Babel v3.1.1** | Physicochemical descriptor calculation |
| **OSIRIS Property Explorer** | Toxicity & drug-likeness prediction |
| **PyMOL** | Structural visualization |
| **Microsoft Excel** | Data integration & logical filtering |

---

### 📜 License

This project is intended **solely for academic and research purposes**.
