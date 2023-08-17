# QGP
This is my undergraduate scientific training in the Physics Department of Sichuan University, where I had the opportunity to work alongside my classmates and roommates. I am grateful for the guidance and advice provided by Lilin Zhu (SCU) and Hua Zheng (SNNU) during this training period.

***The study of quark-gluon-plasma (QGP) by recombination model (RM) contains two phases. The first is the work on production of 7 hadrons in the Au+Au collisions of BES region (7.7-62.4 GeV) at RHIC. And another is the research on production of charmed mesons in the Pb+Pb collisions of LHC region (2.76 and 5.02 TeV).***

Here are the details in term of files.
### 1. Reference
Including mainly reference of initial `prerequisites`, `valon mdel`, `BES` work and `charm` quark work.

### 2. Data
Including the required data of BES and LHC work.

### 3. Latex
Including the two papers of our works by myself (`BES` and `charm_paper_stu`), and articles on intermediate processes (`charm formulae` for final RM, and `charmed meson at LHC progress` for my exploration on the last work).

### 4. Numerical program
In chronological order, v15 is the first program I studied, delivered by my supervisor in the `Fortran RM` and `v16/v15`. During this time, we studied valon mdel due to some flaw on RM and `valon model` was created by Zhizhen Ye and me based on *mathematica*. Thanks to Z.Z.Y, I learned much more tips on *mathematica* from him during undergraduate period. Then the final work on BES `MATLAB RM` only includes TT component of RM and the algorithm varying parameters. The work on charmed mesons includes `charmed meson by ghj` and `v16` wrote by me. The former was the first numerical program I wrote according to fluid-like RM by R.Peng, including thousands of lines of code. After solving countless issues, the model seemed too simply to fit data. Therefore, based on v15, I developed `v16` based on v15 and succeeeded to get reasonable results. More details are ignored and I focus on introducing the `v16/v16_release` here.

Usage of `v16/v16_release`: Note v16 remains all functions in v15. All you may change are in the main program `recomb_product_v16`. The system of collisions is determined in `lines 133-148` And `lines 149-156, 220-256, 309-319` includes fitted parameters, T<sub>c</sub>, C<sub>c</sub>, &gamma;<sub>0</sub>, q<sub>0</sub>, g<sub>M</sub>. More details are shown in program and paper.

### 5. Publishment
*PRC.107.064907 pushished in 21 June 2023.*


Finally, I would like to express my gratitude sincerely to my advisors Lilin Zhu, Hua Zheng, and my partners Tingjun Chen, Guiqi Liu, and Zhizhen Ye. I truly cherish and will always look back with nostalgia on the days we spent together during our scientific training in SCU.
