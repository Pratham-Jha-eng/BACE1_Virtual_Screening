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



* **Protein:** β-site amyloid precursor protein cleaving enzyme-1 (BACE-1)
* **PDB ID:** `2ZJIN`
* **Biological Relevance:** Key enzyme involved in amyloid-β peptide generation in Alzheimer’s disease.
* **Catalytic Residues:** **Asp32** and **Asp228** (aspartyl protease dyad).

---

## 🧪 Ligand Library



[Image of flavonoid chemical structure]


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
Docking was performed using a targeted (active-site) approach. The grid center was visually validated in PyMOL to ensure it lies within the catalytic cleft between **Asp32** and **Asp228**.

**Grid Center Coordinates:**
```text
x = 74.44
y = 32.979
z = 28.979