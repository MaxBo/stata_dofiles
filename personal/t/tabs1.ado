program define tabs1
syntax varlist [if], [BY(passthru)]

tabstat `varlist' `if', `by' statistics(count mean p5 p10 p25 median p75 p90 p95)

end
