gen ek = 1 if  wegkm_k <=1
replace ek = 2 if wegkm_k>1 & wegkm_k <=2
replace ek = 5 if wegkm_k>2 & wegkm_k <=5
replace ek = 10 if wegkm_k>5 & wegkm_k <=10
replace ek = 25 if wegkm_k>10 & wegkm_k <=25
replace ek = 50 if wegkm_k>25 & wegkm_k <=50
replace ek = 51 if wegkm_k>50 & wegkm_k < 9000