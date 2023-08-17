# QGP
This is my undergraduate scientific training in the Physics Department of Sichuan University, where I had the opportunity to work alongside my classmates and roommates. I am grateful for the guidance and advice provided by Lilin Zhu (SCU) and Hua Zheng (SNNU) during this training period.

***The study of Quark-Gluon Plasma (QGP) using the Recombination Model (RM) involves two phases. The first phase focuses on the production of 7 hadrons in Au+Au collisions within the BES region (7.7-62.4 GeV) at RHIC. The second phase involves research on the production of charmed mesons in Pb+Pb collisions within the LHC region (2.76 and 5.02 TeV).***

Here is a breakdown of the details in terms of files:
### 1. Reference
- Contains main references to initial `prerequisites`, `valon mdel`, `BES` work and `charm` quark work.

### 2. Data
- Includes the required data for the BES and LHC work.

### 3. Latex
- Contains two papers on our work, (namely `BES` and `charm_paper_stu`), and articles on intermediate processes (`charm formulae` for final RM, and `charmed meson at LHC progress` for my exploration on charmed mesons work).

### 4. Numerical program
- Presented in chronological order, v15 is the initial program I studied, delivered by my supervisor in the `Fortran RM` and `v16/v15`. During this period, we studied valon mdel due to some flaw on RM and `valon model` was created by Zhizhen Ye and me based on *mathematica*. Thanks to Z.Z.Y, I learned much more tips on *mathematica* from him during undergraduate period. Then the final work on BES `MATLAB RM` only includes TT component of RM and the algorithm varying parameters. The work on charmed mesons includes `charmed meson by ghj` and `v16` written by me. The former was the first numerical program written by me, following fluid-like RM mode by R.Peng, including thousands of lines of code. After solving countless issues, t became apparent that the model was too simple to fit the data. Therefore, based on v15, I developed `v16`, which successfully produced reasonable results. I will focus on introducing the `v16/v16_release` here, while ignoring more details.

- Usage of `v16/v16_release`: Please note that v16 retains all the functions of v15.  The only changes you need to make are in the main program `recomb_product_v16`. The system of collisions is determined in `lines 133-148` And `lines 149-156, 220-256, 309-319` includes fitted parameters, T<sub>c</sub>, C<sub>c</sub>, &gamma;<sub>0</sub>, q<sub>0</sub>, g<sub>M</sub>. More details are provided in the program and paper.

### 5. Publishment
- *PRC.107.064907 pushished in 21 June 2023.*


Finally, I would like to express my gratitude sincerely to my advisors Lilin Zhu, Hua Zheng, and my partners Tingjun Chen, Guiqi Liu, and Zhizhen Ye. I truly cherish and will always look back with nostalgia on the days we spent together during our scientific training in SCU.
