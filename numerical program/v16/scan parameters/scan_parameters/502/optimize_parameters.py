#!/usr/bin/env python
# -*- coding: utf-8 -*-
#

import subprocess
import os

def modify_fortran_parameters(par1, par2, par3, isu, file0="recomb_product_v16.f90"):
    # 打开 Fortran 文件并将内容读入列表
    with open(file0, "r") as file:
        lines = file.readlines()

    # 修改指定行的参数值
    lines[139] = f"      Isu={isu}\n"
 
    #Tc, Cc
    #2.76
    #lines[237] = f"      Tc = {par1}d0\n"
    #lines[238] = f"      cc = {par2}d0\n"
    #5.02
    lines[251] = f"      Tc = {par1}d0\n"
    lines[252] = f"      cc = {par2}d0\n"
    #gamma0, q0
    #2.76 TeV
    #lines[150] = f"      PAR(1)={par3}d0\n"
    #lines[151] = f"      PAR(2)={par2}d0\n"
    #5.02 TeV
    lines[153] = f"      PAR(1)={par3}d0\n"
    #lines[154] = f"      PAR(2)={par2}d0\n"

    # 将修改后的内容写回文件
    with open(file0, "w") as file:
        file.writelines(lines)


def run_fortran(file0="recomb_product_v16.f90"):
    # 调用Fortran程序并传入参数
    sys_run_str = '''
ifort -c -O vegas.f90
ifort -c -O recomb_product_v16.f90
ifort  {0} -o exe.out
./exe.out > run.$SLURM_JOB_ID.log
'''.format(file0)
    subprocess.run( [sys_run_str, "--login"], shell=True, text=True)
    
    # 解析输出文件 chisq.dat 中的误差值
    with open("chisq.dat", "r") as file:
        lines = file.readlines()
        last_line = lines[-1].strip()
        data = last_line.split()
    if len(data) >= 1:
        error = float(data[-1])
    else:
        print("Invalid format")
    
    return error

#目前只支持精确到2位小数
def scan_parameters(p1_low,p1_high,p1_interval, p2_low,p2_high,p2_interval, p3_low,p3_high,p3_interval, Isu=[8, 9, 10]):
    global SLURM_JOB_ID
    best_error = float("inf")
    best_par1 = 0
    best_par2 = 0
    best_par3 = 0
    
    for par3 in range(int(p3_low*100), int((p3_high+0.01)*100), int(p3_interval * 100)):
        for par1 in range(int(p1_low*100), int((p1_high+0.01)*100), int(p1_interval * 100)):  # 精确到小数点后一位
            for par2 in range(int(p2_low*100), int((p2_high+0.01)*100), int(p2_interval * 100)):  # 精确到小数点后一位
                error_sum = 0.0
                
                for i in Isu:
                    print(par1/100,par2/100,par3/100)
                    modify_fortran_parameters(par1/100, par2/100, par3/100, i)
                    error_sum += run_fortran()  # Isu=10 的误差
                
                if error_sum < best_error:
                    best_error = error_sum
                    best_par1 = par1/100
                    best_par2 = par2/100
                    best_par3 = par3/100
                
                with open("output."+SLURM_JOB_ID+".txt", "a") as file:
                    file.write(f"Parameters(Tc, Cc, gamma0): {par1 / 100}, {par2 / 100}, {par3 / 100} | Error: {error_sum}\n")
    
    return best_par1, best_par2, best_par3, best_error

global SLURM_JOB_ID
SLURM_JOB_ID=os.environ["SLURM_JOB_ID"]
# 执行参数扫描和求最优值
#Tc
p1_low = 0.8
p1_high= 0.9
p1_interval= 0.01
#Cc
p2_low = 2.0
p2_high= 3.0
p2_interval= 0.1
#gamma0
p3_low = 3.0
p3_high= 4.2
p3_interval= 0.1

with open("output."+SLURM_JOB_ID+".txt", "a") as file:
    file.write(f"Scan:\n Tc:{p1_low}-{p1_high}({p1_interval}),\n Cc:{p2_low}-{p2_high}({p2_interval}),\n gamma0:{p3_low}-{p3_high}({p3_interval}).\n")

best_par1, best_par2, best_par3, best_error = scan_parameters(p1_low,p1_high,p1_interval, p2_low,p2_high,p2_interval, p3_low,p3_high,p3_interval, Isu=[8, 9, 10])#目前只支持精确到1位小数

# 输出结果
with open("output."+SLURM_JOB_ID+".txt", "a") as file:
    file.write("The best parameters:\n")
    file.write(f"Tc     = {best_par1}\n")
    file.write(f"Cc     = {best_par2}\n")
    file.write(f"PAR(1) = {best_par3}\n")
    #file.write(f"PAR(2) = {best_par2}\n")
    file.write(f"Minimal chisq: {best_error}\n")
