********** Program zur Generierung des Resteinkommens ************+
*! version 1.0  06jun2009
program define soep_genvar_rinc

syntax varlist

*** Einkommen in Anlehnung an Ben-Akiva 1976
*** hier geschätzt: + 400 € fixer Haushalts-Grundbedarf + 230 € je Erwachsenen + 200 € je Kind***
*** (entspricht in etwa dem Mindesrückbehalt bei der Wohnungsbauförderung in NRW) ***
*** theoretisch liessen sich nach diesem Prinzip auch Wohn- und Mobilitätskosten in das Rest-Einkommen integrieren ***

quietly {
dropvars hhrinc restinc 
noi di "verbleibendes Einkommen nach Abzug Grundbedarf und Pkw-Kosten"
// 630 € für die 1. Person, 230 € für weitere Erwachsene, 200 € je Kind
gen hhrinc =  hinc_2007-400-230*adults-200*eqnkids

*** weiter werden noch Fixkosten der Pkw und die variablen Kosten des Arbeitsweges abgezogen
// 200 € je Pkw
local fixcost 200

gen restinc = hhrinc - `fixcost' * `varlist' - varcost
local incoffset 1700
dropvars rinc`incoffset'*
gen rinc`incoffset'=restinc+`incoffset'
gen rinc`incoffset'ln = ln(rinc`incoffset')
replace rinc`incoffset'ln=0 if rinc`incoffset'<=0

//drop hhrinc
}


end
****************************************************************************
