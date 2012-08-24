*! version 1.0.0  28jun2004


program yxview_sarrows_draw

    if `:serset N' == 0 {
	exit
    }

    .style.marker.setgdifull
    local msz `.style.marker.size.val' 

    .style.line.setgdifull


    local j 1
    while `j' <= `:serset N' {

	gdi moveto `=serset(`.xvar', `j')'	///
		   `=serset(`.yvar', `j')'

	while `j' <= `:serset N' {
	    if (`=serset(`.xvar', `j')' >= . |	///
		`=serset(`.yvar', `j')' >= .) {
		continue, break
	    }
	    gdi lineto `=serset(`.xvar', `j')'	///
		       `=serset(`.yvar', `j')'
	    local ++j
	}

	arrow	`msz'				///
		`=serset(`.xvar', `=`j'-2')'	///
		`=serset(`.yvar', `=`j'-2')'	///
		`=serset(`.xvar', `=`j'-1')'	///
		`=serset(`.yvar', `=`j'-1')'
	local ++j

    }
end

program arrow
    args msz x0 y0 x1 y1

    if (`x0'>=. | `x1'>=. | `y1'>=. | `y0'>=.) exit

    local xtrans = `gdi(gbeta)' / `gdi(xbeta)'
    local ytrans = `gdi(gbeta)' / `gdi(ybeta)'

    local phi = atan(((`y1'-`y0') /		///
        (`x1' - `x0'))*(`xtrans'/`ytrans'))
    if `phi' >= . {
        local phi =            ///
        cond(`y1'-`y0' > 0, -c(pi)/2, c(pi)/2)
    }

    local sgn = cond(`x1'-`x0'>0, "+" , "-")

    local ya = `y1' `sgn' `ytrans' * `msz' *	///
		sin(c(pi) + `phi' + .5)
    local xa = `x1' `sgn' `xtrans' * `msz' *	///
		cos(c(pi) + `phi' + .5)
    gdi line `x1' `y1' `xa' `ya'

    local ya = `y1' `sgn' `ytrans' * `msz' *	///
		sin(c(pi) + `phi' - .5)
    local xa = `x1' `sgn' `xtrans' * `msz' *	///
		cos(c(pi) + `phi' - .5)
    gdi line `x1' `y1' `xa' `ya'

end

