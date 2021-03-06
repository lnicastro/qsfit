; *******************************************************************
; Copyright (C) 2016-2018 Giorgio Calderone
;
; This program is free software; you can redistribute it and/or
; modify it under the terms of the GNU General Public icense
; as published by the Free Software Foundation; either version 2
; of the License, or (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program. If not, see <http://www.gnu.org/licenses/>.
;
; *******************************************************************

;=====================================================================
;NAME:
;  gfit_get_par
;
;PURPOSE:
;  Return all model parameters info.
;
;PARAMETERS:
;
;RETURN VALUE: (array of structures)
;  Each element of the array contain information for a model
;  parameter.  The template structure for each element is
;  template_param (see gfit_init.pro).
;
FUNCTION gfit_get_par
  COMPILE_OPT IDL2
  ON_ERROR, !glib.on_error
  COMMON GFIT

  IF (N_TAGS(gfit.comp) EQ 0) THEN RETURN, []
  par = LIST()
  FOR i=0, N_TAGS(gfit.comp)-1 DO BEGIN
     IF (~gfit.comp.(i).enabled) THEN CONTINUE
     FOR j=0, gfit.comp.(i).npar-1 DO $
        par.add, gfit.comp.(i).par.(j)
  ENDFOR
  IF (gn(par) EQ 0) THEN MESSAGE, 'No component is enabled'
  par = par.toArray()
  par.limited = FINITE(par.limits)

  RETURN, par
END
